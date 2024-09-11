import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_clean_architecture_spotify/data/models/create_user_req.dart';
import 'package:flutter_clean_architecture_spotify/data/models/sign_in_email_and_password_req.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class AuthFirebaseService {
  Future<Either> signup(CreateUserReq req);
  Future<Either> signinWithEmailAndPassword(SignInEmailAndPasswordReq req);
  Future<Either> signInWithGoogle();
}

class AuthFirebaseServiceImpl implements AuthFirebaseService {
  @override
  Future<Either> signup(CreateUserReq req) async {
    try {
      final data = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: req.email, password: req.password);

      await FirebaseFirestore.instance.collection('users').add({
        'name': req.fullName,
        'email': data.user?.email,
      });

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
  Future<Either> signinWithEmailAndPassword(
      SignInEmailAndPasswordReq req) async {
    try {
      final credentialUser = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: req.email, password: req.password);
      return Right(credentialUser);
    } on FirebaseException catch (e) {
      String message = '';
      if (e.code == 'wrong-password') {
        message = 'The password provided is wrong';
      } else if (e.code == 'user-not-found') {
        message = 'The email is not reigister. Please register to login!';
      }
      return Left(message);
    }
  }

  @override
  Future<Either> signInWithGoogle() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();

    try {
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser == null) {
        return const Left('Please try again!');
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Create a new credential using the Google tokens
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in to Firebase with the Google credential
      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      return Right(userCredential);
    } on FirebaseException catch (e) {
      String message = '';
      if (e.code == 'wrong-password') {
        message = 'The password provided is wrong';
      } else if (e.code == 'user-not-found') {
        message = 'The email is not reigister. Please register to login!';
      }
      return Left(message);
    }
  }
}
