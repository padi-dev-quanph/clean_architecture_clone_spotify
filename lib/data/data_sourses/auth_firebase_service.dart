import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_clean_architecture_spotify/data/models/create_user_req.dart';
import 'package:flutter_clean_architecture_spotify/data/models/sign_in_req.dart';

abstract class AuthFirebaseService {
  Future<Either> signup(CreateUserReq req);
  Future<Either> singinWithEmailAndPassword(SignInReq req);
}

class AuthFirebaseServiceImpl implements AuthFirebaseService {
  @override
  Future<Either> signup(CreateUserReq req) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: req.email, password: req.password);

      return const Right('Signup Successfully');
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
  Future<Either> singinWithEmailAndPassword(SignInReq req) async {
    try {
      final user = FirebaseAuth.instance
          .signInWithEmailAndPassword(email: req.email, password: req.password);
      return Right(user);
    } on FirebaseException catch (e) {
      String message = '';
      if (e.code == 'wrong-password') {
        message = 'The password provided is wrong';
      }
      return Left(message);
    }
  }
}
