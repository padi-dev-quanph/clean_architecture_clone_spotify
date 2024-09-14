import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture_spotify/domain/usecases/auth/sign_in_google_usecase.dart';
import 'package:flutter_clean_architecture_spotify/domain/usecases/auth/sign_in_usecase.dart';
import 'package:flutter_clean_architecture_spotify/features/auth/sign_in/sign_in_state.dart';
import 'package:flutter_clean_architecture_spotify/common/enums/load_status.dart';
import 'package:flutter_clean_architecture_spotify/data/models/auth/sign_in_email_and_password_req.dart';
import 'package:flutter_clean_architecture_spotify/service_locator.dart';

class SignInCubit extends Cubit<SignInState> {
  SignInCubit() : super(SignInState.initial());

  void signInWithEmailAndPassword(SignInEmailAndPasswordReq req) async {
    if (req.email.isEmpty) {
      emit(state.copyWith(
          loadStatus: LoadStatus.failed, message: 'Please enter email!'));
      return;
    }

    if (req.password.isEmpty) {
      emit(state.copyWith(
          loadStatus: LoadStatus.failed, message: 'Please enter password!'));
      return;
    }
    emit(state.copyWith(loadStatus: LoadStatus.loading));
    final result = await sl<SignInUsecase>().call(params: req);
    result.fold((error) {
      emit(state.copyWith(loadStatus: LoadStatus.failed, message: error));
    }, (response) {
      emit(state.copyWith(
          loadStatus: LoadStatus.success, message: 'Login Successfully'));
    });
  }

  void signInWithGoogle() async {
    emit(state.copyWith(loadStatus: LoadStatus.loading));
    final result = await sl<SignInGoogleUsecase>().call();
    result.fold((error) {
      emit(state.copyWith(loadStatus: LoadStatus.failed, message: error));
    }, (response) {
      emit(state.copyWith(
          loadStatus: LoadStatus.success, message: 'Login Successfully'));
    });
  }

  void signInWithApple() {}
}
