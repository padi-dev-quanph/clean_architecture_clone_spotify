import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_clean_architecture_spotify/data/models/songs/lyric.dart';
import 'package:flutter_clean_architecture_spotify/domain/entities/song.dart';
import 'package:intl/intl.dart';

class SongModel {
  final String? title;
  final String? artist;
  final num? duration;
  final Timestamp? releaseDate;
  final String? cover;
  final String? content;
  final String? lyrics;

  const SongModel(
      {this.title,
      this.artist,
      this.duration,
      this.releaseDate,
      this.cover,
      this.content,
      this.lyrics});

  factory SongModel.fromJson(Map<String, dynamic> data) {
    return SongModel(
      title: data['title'],
      artist: data['artist'],
      duration: data['duration'],
      releaseDate: data['releaseDate'],
      cover: data['cover'],
      content: data['content'],
      lyrics: data['lyrics'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'artist': artist,
      'duration': duration,
      'releaseDate': releaseDate,
      'cover': cover,
      'content': content,
      'lyrics': lyrics
    };
  }

  // copyWith

  SongModel copyWith(
      {String? title,
      String? artist,
      num? duration,
      Timestamp? releaseDate,
      String? cover,
      String? content,
      String? lyrics}) {
    return SongModel(
      title: title ?? this.title,
      artist: artist ?? this.artist,
      duration: duration ?? this.duration,
      releaseDate: releaseDate ?? this.releaseDate,
      cover: cover ?? this.cover,
      content: content ?? this.content,
      lyrics: lyrics ?? this.lyrics,
    );
  }
}

extension SongModelX on SongModel {
  SongEntity toEntity() {
    return SongEntity(
      title: title!,
      artist: artist!,
      duration: duration!,
      releaseDate: releaseDate!,
      cover: cover!,
      content: content!,
      lyrics: lyrics!
          .split('[winter]')
          .map((e) {
            final parts = e.split('[w]');
            if (parts.length > 1) {
              final text = parts[1];
              final timeString = parts[0].replaceAll('[', '').trim();
              final time = DateFormat('mm:ss.SS').parse(timeString);
              return Lyric(text, time);
            }
            return Lyric('xxx', DateTime.now());
          })
          .where((e) => e.words != 'xxx')
          .toList(),
    );
  }
}
