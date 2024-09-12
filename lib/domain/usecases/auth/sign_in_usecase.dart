import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture_spotify/core/usecases/usecase.dart';
import 'package:flutter_clean_architecture_spotify/data/models/auth/sign_in_email_and_password_req.dart';
import 'package:flutter_clean_architecture_spotify/domain/repository/auth/auth.dart';
import 'package:flutter_clean_architecture_spotify/service_locator.dart';

class SignInUsecase implements Usecase<Either, SignInEmailAndPasswordReq> {
  @override
  Future<Either> call({SignInEmailAndPasswordReq? params}) async {
    return await sl<AuthRepository>().signinWithEmailAndPassword(params!);
  }
}
