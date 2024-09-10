import 'package:flutter_clean_architecture_spotify/common/blocs/theme/theme_cubit.dart';
import 'package:flutter_clean_architecture_spotify/data/data_sourses/auth_firebase_service.dart';
import 'package:flutter_clean_architecture_spotify/data/repository/auth_repository_impl.dart';
import 'package:flutter_clean_architecture_spotify/domain/repository/auth.dart';
import 'package:flutter_clean_architecture_spotify/domain/usecases/sign_up_usecase.dart';
import 'package:flutter_clean_architecture_spotify/features/auth/sign_up/cubit/sign_up_cubit.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  // Theme Bloc
  sl.registerSingleton<ThemeCubit>(ThemeCubit());

  sl.registerSingleton<AuthFirebaseService>(AuthFirebaseServiceImpl());

  sl.registerSingleton<AuthRepository>(AuthRepositoryImpl());

  sl.registerSingleton<SignUpUsecase>(SignUpUsecase());

  sl.registerFactory<SignUpCubit>(SignUpCubit.new);
}
