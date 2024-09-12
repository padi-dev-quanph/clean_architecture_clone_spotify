import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture_spotify/common/enums/load_status.dart';
import 'package:flutter_clean_architecture_spotify/domain/repository/song/song.dart';
import 'package:flutter_clean_architecture_spotify/features/music/home/home_state.dart';
import 'package:flutter_clean_architecture_spotify/service_locator.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeState.initial());

  void getNewSogns() async {
    emit(state.copyWith(loadStatus: LoadStatus.loading));
    final result = await sl<SongRepository>().getNewSongs();
    result.fold((error) {
      emit(state.copyWith(loadStatus: LoadStatus.failed, message: error));
    }, (response) {
      emit(state.copyWith(loadStatus: LoadStatus.success, songs: response));
    });
  }
}
