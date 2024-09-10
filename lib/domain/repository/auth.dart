import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture_spotify/data/models/create_user_req.dart';
import 'package:flutter_clean_architecture_spotify/data/models/sign_in_email_and_password_req.dart';

abstract class AuthRepository {
  Future<Either> signup(CreateUserReq req);
  Future<Either> singinWithEmailAndPassword(SignInEmailAndPasswordReq req);
}
