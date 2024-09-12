import 'package:flutter_clean_architecture_spotify/core/usecases/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture_spotify/data/models/auth/create_user_req.dart';
import 'package:flutter_clean_architecture_spotify/domain/repository/auth/auth.dart';
import 'package:flutter_clean_architecture_spotify/service_locator.dart';

class SignUpUsecase implements Usecase<Either, CreateUserReq> {
  @override
  Future<Either> call({CreateUserReq? params}) async {
    return sl<AuthRepository>().signup(params!);
  }
}
