import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture_spotify/data/models/songs/song.dart';
import 'package:flutter_clean_architecture_spotify/domain/entities/song.dart';

abstract class SongFirebaseService {
  Future<Either> getNewSongs();
}

class SongFirebaseServiceImpl implements SongFirebaseService {
  @override
  Future<Either> getNewSongs() async {
    try {
      List<SongEntity> songs = [];
      final data = await FirebaseFirestore.instance
          .collection('songs')
          .orderBy('releaseDate', descending: true)
          .limit(3)
          .get();

      log('---data : ${data.docs.first.data().toString()}');

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
}
