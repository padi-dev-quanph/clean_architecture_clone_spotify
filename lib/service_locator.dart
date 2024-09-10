import 'package:flutter_clean_architecture_spotify/domain/usecases/sign_in_google_usecase.dart';
import 'package:flutter_clean_architecture_spotify/domain/usecases/sign_in_usecase.dart';
import 'package:flutter_clean_architecture_spotify/features/auth/sign_in/sign_in_cubit.dart';
import 'package:flutter_clean_architecture_spotify/common/blocs/theme/theme_cubit.dart';
import 'package:flutter_clean_architecture_spotify/data/data_sourses/auth_firebase_service.dart';
import 'package:flutter_clean_architecture_spotify/data/repository/auth_repository_impl.dart';
import 'package:flutter_clean_architecture_spotify/domain/repository/auth.dart';
import 'package:flutter_clean_architecture_spotify/domain/usecases/sign_up_usecase.dart';
import 'package:flutter_clean_architecture_spotify/features/auth/sign_up/sign_up_cubit.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  // Services
  sl.registerSingleton<AuthFirebaseService>(AuthFirebaseServiceImpl());

  // Repositories
  sl.registerSingleton<AuthRepository>(AuthRepositoryImpl());

  // Usecases
  sl.registerSingleton<SignUpUsecase>(SignUpUsecase());
  sl.registerSingleton<SignInUsecase>(SignInUsecase());
  sl.registerSingleton<SignInGoogleUsecase>(SignInGoogleUsecase());

  // Blocs
  sl.registerSingleton<ThemeCubit>(ThemeCubit());
  sl.registerFactory<SignUpCubit>(SignUpCubit.new);
  sl.registerFactory<SignInCubit>(SignInCubit.new);
}
