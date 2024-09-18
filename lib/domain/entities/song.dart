import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_clean_architecture_spotify/data/models/songs/lyric.dart';

class SongEntity {
  final String title;
  final String artist;
  final num duration;
  final Timestamp releaseDate;
  final String cover;
  final String content;
  final List<Lyric> lyrics;
  final bool isFavorite;

  const SongEntity({
    required this.title,
    required this.artist,
    required this.duration,
    required this.releaseDate,
    required this.cover,
    required this.content,
    required this.lyrics,
    required this.isFavorite,
  });

  factory SongEntity.empty() {
    return SongEntity(
      title: '',
      artist: '',
      duration: 0,
      releaseDate: Timestamp.now(),
      cover: '',
      content: '',
      lyrics: [],
      isFavorite: false,
    );
  }

//   copy with

  SongEntity copyWith({
    String? title,
    String? artist,
    num? duration,
    Timestamp? releaseDate,
    String? cover,
    String? content,
    List<Lyric>? lyrics,
    bool? isFavorite
  }) {
    return SongEntity(
      title: title ?? this.title,
      artist: artist ?? this.artist,
      duration: duration ?? this.duration,
      releaseDate: releaseDate ?? this.releaseDate,
      cover: cover ?? this.cover,
      content: content ?? this.content,
      lyrics: lyrics ?? this.lyrics,
      isFavorite: isFavorite ?? this.isFavorite
    );
  }
}
