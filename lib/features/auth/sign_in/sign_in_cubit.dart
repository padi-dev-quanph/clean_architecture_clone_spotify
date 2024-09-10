import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture_spotify/features/auth/sign_in/sign_in_state.dart';
import 'package:flutter_clean_architecture_spotify/common/enums/load_status.dart';
import 'package:flutter_clean_architecture_spotify/common/enums/sign_in_type.dart';
import 'package:flutter_clean_architecture_spotify/data/models/sign_in_email_and_password_req.dart';
import 'package:flutter_clean_architecture_spotify/domain/repository/auth.dart';
import 'package:flutter_clean_architecture_spotify/service_locator.dart';

class SignInCubit extends Cubit<SignInState> {
  SignInCubit() : super(SignInState.initial());

  void signIn(SignInEmailAndPasswordReq req) async {
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
    if (req.signInType == SignInType.useEmailAndPassword) {
      _signInWithEmailAndPassword(req);
    } else if (req.signInType == SignInType.useGoogle) {
      _signInWithGoogle();
    } else {
      _signInWithApple();
    }
  }

  void _signInWithEmailAndPassword(SignInEmailAndPasswordReq req) async {
    final result = await sl<AuthRepository>().singinWithEmailAndPassword(req);
    result.fold((error) {
      emit(state.copyWith(loadStatus: LoadStatus.failed, message: error));
    }, (response) {
      emit(state.copyWith(
          loadStatus: LoadStatus.success, message: 'Login Successfully'));
    });
  }

  void _signInWithGoogle() {}

  void _signInWithApple() {}
}
