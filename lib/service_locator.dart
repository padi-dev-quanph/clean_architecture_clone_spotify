import 'package:flutter_clean_architecture_spotify/common/blocs/now_playing/now_playing_cubit.dart';
import 'package:flutter_clean_architecture_spotify/data/data_sourses/song/song_firebase_service.dart';
import 'package:flutter_clean_architecture_spotify/data/repository/song/song_repository_impl.dart';
import 'package:flutter_clean_architecture_spotify/domain/repository/song/song.dart';
import 'package:flutter_clean_architecture_spotify/domain/usecases/auth/sign_in_google_usecase.dart';
import 'package:flutter_clean_architecture_spotify/domain/usecases/auth/sign_in_usecase.dart';
import 'package:flutter_clean_architecture_spotify/domain/usecases/song/like_song.dart';
import 'package:flutter_clean_architecture_spotify/features/auth/sign_in/sign_in_cubit.dart';
import 'package:flutter_clean_architecture_spotify/common/blocs/theme/theme_cubit.dart';
import 'package:flutter_clean_architecture_spotify/data/data_sourses/auth/auth_firebase_service.dart';
import 'package:flutter_clean_architecture_spotify/data/repository/auth/auth_repository_impl.dart';
import 'package:flutter_clean_architecture_spotify/domain/repository/auth/auth.dart';
import 'package:flutter_clean_architecture_spotify/domain/usecases/auth/sign_up_usecase.dart';
import 'package:flutter_clean_architecture_spotify/features/auth/sign_up/sign_up_cubit.dart';
import 'package:flutter_clean_architecture_spotify/features/music/home/home_cubit.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  // Services
  sl.registerSingleton<AuthFirebaseService>(AuthFirebaseServiceImpl());
  sl.registerSingleton<SongFirebaseService>(SongFirebaseServiceImpl());

  // Repositories
  sl.registerSingleton<AuthRepository>(AuthRepositoryImpl());
  sl.registerSingleton<SongRepository>(SongRepositoryImpl());

  // Usecases
  sl.registerSingleton<SignUpUsecase>(SignUpUsecase());
  sl.registerSingleton<SignInUsecase>(SignInUsecase());
  sl.registerSingleton<SignInGoogleUsecase>(SignInGoogleUsecase());
  sl.registerSingleton<LikeSOng>(LikeSOng());

  // Blocs
  sl.registerSingleton<ThemeCubit>(ThemeCubit());
  sl.registerFactory<SignUpCubit>(SignUpCubit.new);
  sl.registerFactory<SignInCubit>(SignInCubit.new);
  sl.registerFactory<HomeCubit>(HomeCubit.new);
  sl.registerSingleton<NowPlayingCubit>(NowPlayingCubit());
}
