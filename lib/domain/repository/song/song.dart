import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture_spotify/domain/entities/song.dart';

abstract class SongRepository {
  Future<Either> getNewSongs();
  Future<Either> updateSong(SongEntity song);
}
