import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_clean_architecture_spotify/data/models/create_user_req.dart';
import 'package:flutter_clean_architecture_spotify/data/models/sign_in_email_and_password_req.dart';

abstract class AuthFirebaseService {
  Future<Either> signup(CreateUserReq req);
  Future<Either> singinWithEmailAndPassword(SignInEmailAndPasswordReq req);
}

class AuthFirebaseServiceImpl implements AuthFirebaseService {
  @override
  Future<Either> signup(CreateUserReq req) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: req.email, password: req.password);

      return const Right('Register successfully, You can login now!');
    } on FirebaseException catch (e) {
      String message = '';
      if (e.code == 'weak-password') {
        message = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        message = 'The account already exists for that email.';
      } else if (e.code == 'invalid-email') {
        message = 'Your email address appears to be malformed.';
      }
      return Left(message);
    }
  }

  @override
  Future<Either> singinWithEmailAndPassword(
      SignInEmailAndPasswordReq req) async {
    try {
      final user = FirebaseAuth.instance
          .signInWithEmailAndPassword(email: req.email, password: req.password);
      print('user: ${user.toString()}');
      return Right(user);
    } on FirebaseException catch (e) {
      String message = '';
      if (e.code == 'wrong-password') {
        message = 'The password provided is wrong';
      } else if (e.code == 'user-not-found') {
        message = 'The email is not reigister. Please register to login!';
      }
      return Left(message);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
