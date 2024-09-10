import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture_spotify/data/data_sourses/auth_firebase_service.dart';
import 'package:flutter_clean_architecture_spotify/data/models/create_user_req.dart';
import 'package:flutter_clean_architecture_spotify/data/models/sign_in_email_and_password_req.dart';
import 'package:flutter_clean_architecture_spotify/domain/repository/auth.dart';
import 'package:flutter_clean_architecture_spotify/service_locator.dart';

class AuthRepositoryImpl implements AuthRepository {
  @override
  Future<Either> signup(CreateUserReq req) async {
    return await sl<AuthFirebaseService>().signup(req);
  }

  @override
  Future<Either> singinWithEmailAndPassword(SignInEmailAndPasswordReq req) async {
    return await sl<AuthFirebaseService>().singinWithEmailAndPassword(req);
  }
}
