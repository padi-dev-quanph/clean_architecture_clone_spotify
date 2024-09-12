import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture_spotify/data/data_sourses/song/song_firebase_service.dart';
import 'package:flutter_clean_architecture_spotify/domain/repository/song/song.dart';
import 'package:flutter_clean_architecture_spotify/service_locator.dart';

class SongRepositoryImpl implements SongRepository {
  @override
  Future<Either> getNewSongs() async {
    return await sl<SongFirebaseService>().getNewSongs();
  }
}
