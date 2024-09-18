import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture_spotify/data/models/songs/song.dart';
import 'package:flutter_clean_architecture_spotify/domain/entities/song.dart';

abstract class SongFirebaseService {
  Future<Either> getNewSongs();
  Future<Either> updateSong(SongEntity song);
}

class SongFirebaseServiceImpl implements SongFirebaseService {
  @override
  Future<Either> getNewSongs() async {
    try {
      List<SongEntity> songs = [];
      final data = await FirebaseFirestore.instance
          .collection('songs')
          .orderBy('releaseDate', descending: true)
          .limit(5)
          .get();
      for (var song in data.docs) {
        var songModel = SongModel.fromJson(song.data());
        songs.add(songModel.toEntity());
      }

      return Right(songs);
    } catch (e) {
      log('Error: ${e.toString()}');
      return const Left('An error occurred, Please try again!');
    }
  }

  @override
  Future<Either> updateSong(SongEntity song) async {
    try {
      await FirebaseFirestore.instance.collection('songs').doc(song.content).set({
        'title': song.title,
        'artist': song.artist,
        'duration': song.duration,
        'releaseDate': song.releaseDate,
        'cover': song.cover,
        'content': song.content,
        'lyrics': song.lyrics,
        'isFavorite': song.isFavorite
      });
      return const Right('Success');
    } catch(e) {
      return Left(e.toString());
    }
  }
}
