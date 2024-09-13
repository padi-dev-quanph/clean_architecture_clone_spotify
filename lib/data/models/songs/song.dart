import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_clean_architecture_spotify/data/models/songs/lyric.dart';
import 'package:flutter_clean_architecture_spotify/domain/entities/song.dart';

class SongModel {
  final String? title;
  final String? artist;
  final num? duration;
  final Timestamp? releaseDate;
  final String? cover;
  final String? content;
  // final List<Lyric>? lyrics;

  const SongModel({
    this.title,
    this.artist,
    this.duration,
    this.releaseDate,
    this.cover,
    this.content,
    // this.lyrics
  });

  factory SongModel.fromJson(Map<String, dynamic> data) {
    return SongModel(
      title: data['title'],
      artist: data['artist'],
      duration: data['duration'],
      releaseDate: data['releaseDate'],
      cover: data['cover'],
      content: data['content'],
      // lyrics: (data['lyrics'] as List)
      //     .map((lyric) => Lyric.fromJson(lyric))
      //     .toList(),
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
      // 'lyrics': lyrics
    };
  }

  // copyWith

  SongModel copyWith({
    String? title,
    String? artist,
    num? duration,
    Timestamp? releaseDate,
    String? cover,
    String? content,
    // List<Lyric>? lyrics,
  }) {
    return SongModel(
      title: title ?? this.title,
      artist: artist ?? this.artist,
      duration: duration ?? this.duration,
      releaseDate: releaseDate ?? this.releaseDate,
      cover: cover ?? this.cover,
      content: content ?? this.content,
      // lyrics: lyrics ?? this.lyrics,
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
      // lyrics: lyrics!,
    );
  }
}
