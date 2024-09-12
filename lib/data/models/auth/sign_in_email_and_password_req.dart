import 'package:flutter_clean_architecture_spotify/common/enums/sign_in_type.dart';

class SignInEmailAndPasswordReq {
  final String email;
  final String password;
  final SignInType signInType;

  SignInEmailAndPasswordReq(
      {required this.email, required this.password, required this.signInType});
}
