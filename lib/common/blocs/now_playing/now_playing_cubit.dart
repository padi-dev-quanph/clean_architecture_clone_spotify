import 'package:audio_service/audio_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture_spotify/common/blocs/now_playing/now_playing_state.dart';
import 'package:flutter_clean_architecture_spotify/common/enums/load_status.dart';
import 'package:flutter_clean_architecture_spotify/common/helpers/time_ex.dart';
import 'package:flutter_clean_architecture_spotify/domain/entities/song.dart';
import 'package:flutter_clean_architecture_spotify/domain/usecases/song/like_song.dart';
import 'package:flutter_clean_architecture_spotify/service_locator.dart';
import 'package:just_audio/just_audio.dart';

class NowPlayingCubit extends Cubit<NowPlayingState> {
  AudioPlayer player = AudioPlayer();

  NowPlayingCubit() : super(NowPlayingState.initial()) {
    player.positionStream.listen((p) {
      _updateSongPlayer(p);
    });
  }

  void _updateSongPlayer(Duration position) async {
    if (getTimeFollowSecond(state.song.duration) ==
        position.inSeconds.toDouble()) {
      emit(state.copyWith(isPlaying: false, position: position));
    } else {
      if (state.isPlaying) {
        emit(state.copyWith(position: position));
      } else {
        emit(state.copyWith(position: position, isPlaying: true));
      }
    }
  }

  void loadSong(SongEntity song) async {
    try {
      if (song.content == state.song.content) {
        return;
      }
      emit(state.copyWith(
          loadStatus: LoadStatus.success,
          song: song,
          isPlaying: true,
          position: Duration.zero));

      await player.setAudioSource(
          AudioSource.uri(
            Uri.parse(song.content),
            tag: MediaItem(
              id: song.content,
              album: 'Winter Album',
              title: song.title,
              artUri: Uri.parse(song.cover),
            ),
          ),
          initialPosition: Duration.zero);
      await player.play();
    } catch (e) {
      emit(state.copyWith(loadStatus: LoadStatus.failed, isPlaying: false));
    }
  }

  void handlePlayPause() async {
    if (player.playing) {
      player.pause().then((value) {
        emit(state.copyWith(isPlaying: false));
      });
    } else {
      player.play().then((value) {
        emit(state.copyWith(isPlaying: true));
      });
    }
  }

  void handleClose() {
    player.stop();
    emit(state.copyWith(isPlaying: false, song: SongEntity.empty()));
  }

  void handleSeek(double value) {
    player
      ..seek(Duration(seconds: value.toInt())).then((value) {
        _updateSongPlayer(player.position);
      })
      ..play();
  }

  void handleLikeSong() async{
    final result = await sl<LikeSOng>().call(params: state.song.copyWith(
      isFavorite: !state.song.isFavorite
    ));
    result.fold((error) {
      emit(state.copyWith(loadStatus: LoadStatus.failed));
    }, (response) {
      emit(state.copyWith(
        song: state.song.copyWith(isFavorite: !state.song.isFavorite),
      ));
    });
  }

  @override
  Future<void> close() {
    player.dispose();
    return super.close();
  }
}
