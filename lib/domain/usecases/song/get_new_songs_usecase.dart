import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture_spotify/core/usecases/usecase.dart';
import 'package:flutter_clean_architecture_spotify/domain/repository/song/song.dart';
import 'package:flutter_clean_architecture_spotify/service_locator.dart';

class GetNewSongsUsecase implements Usecase<Either, void> {
  @override
  Future<Either> call({void params}) async {
    return await sl<SongRepository>().getNewSongs();
  }
}
