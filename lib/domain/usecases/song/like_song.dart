import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture_spotify/core/usecases/usecase.dart';
import 'package:flutter_clean_architecture_spotify/domain/entities/song.dart';
import 'package:flutter_clean_architecture_spotify/domain/repository/song/song.dart';
import 'package:flutter_clean_architecture_spotify/service_locator.dart';

class LikeSOng implements Usecase<Either, SongEntity> {
  @override
  Future<Either> call({SongEntity? params}) async {
    return await sl<SongRepository>().updateSong(params!);
  }
}
