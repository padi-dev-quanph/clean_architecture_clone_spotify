import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_clean_architecture_spotify/domain/entities/song.dart';

class SongModel {
  final String? title;
  final String? artist;
  final num? duration;
  final Timestamp? releaseDate;
  final String? cover;

  const SongModel(
      {this.title, this.artist, this.duration, this.releaseDate, this.cover});

  factory SongModel.fromJson(Map<String, dynamic> data) {
    return SongModel(
      title: data['title'],
      artist: data['artist'],
      duration: data['duration'],
      releaseDate: data['releaseDate'],
      cover: data['cover'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'artist': artist,
      'duration': duration,
      'releaseDate': releaseDate,
      'cover': cover
    };
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
    );
  }
}
