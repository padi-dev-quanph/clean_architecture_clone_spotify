import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_clean_architecture_spotify/data/models/songs/lyric.dart';

class SongEntity {
  final String title;
  final String artist;
  final num duration;
  final Timestamp releaseDate;
  final String cover;
  final String content;
  // final List<Lyric> lyrics;

  const SongEntity({
    required this.title,
    required this.artist,
    required this.duration,
    required this.releaseDate,
    required this.cover,
    required this.content,
    // required this.lyrics,
  });

  factory SongEntity.empty() {
    return SongEntity(
      title: '',
      artist: '',
      duration: 0,
      releaseDate: Timestamp.now(),
      cover: '',
      content: '',
      // lyrics: [],
    );
  }
}
