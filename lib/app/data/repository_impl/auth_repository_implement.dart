import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:test_app/app/data/data_source/local/local_data_repository.dart';
import 'package:test_app/app/domain/repository/auth_repository.dart';
import 'package:test_app/app/domain/value_object/network_error.dart';

class AuthRepositoryImplement extends AuthRepository {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;
  final FacebookAuth _facebookAuth;
  final Completer<void> _completer = Completer();

  User? _user;

  AuthRepositoryImplement({
    required FirebaseAuth firebaseAuth,
    required GoogleSignIn googleSignIn,
    required FacebookAuth facebookAuth,
  })  : _firebaseAuth = firebaseAuth,
        _googleSignIn = googleSignIn,
        _facebookAuth = facebookAuth {
    _init();
  }

  @override
  Future<void> login({required String email, required String password}) async {
    await Future.delayed(const Duration(seconds: 2));
    if (email == 'test@gmail.com' && password == '123456789') {
      LocalDataRepository()
        ..isLogged = true
        ..userEmail = 'test@gmail.com';
      return;
    } else {
      throw ApiException(
          code: 400, message: 'Usuario o contraseña incorrecta!');
    }
  }

  @override
  Future<User?> get user async {
    await _completer.future;
    return _user;
  }

  void _init() async {
    _firebaseAuth.authStateChanges().listen((user) {
      if (!_completer.isCompleted) {
        _completer.complete();
      }
      _user = user;
    });
  }

  @override
  Future<User?> signInWithGoogle() async {
    final account = await _googleSignIn.signIn();
    if (account == null) {
      throw Exception('User has canceled sing in with google');
    }
    final googleAuth = await account.authentication;
    final oAuthCredential = GoogleAuthProvider.credential(
      idToken: googleAuth.idToken,
      accessToken: googleAuth.accessToken,
    );
    final credential =
        await _firebaseAuth.signInWithCredential(oAuthCredential);
    LocalDataRepository().userEmail = credential.user!.email;
    return credential.user;
  }

  @override
  Future<void> logOut() async {
    await _firebaseAuth.signOut();
    await _googleSignIn.signOut();
    await _facebookAuth.logOut();
    LocalDataRepository().logOut();
  }

  @override
  Future<User?> signInWithFacebook() async {
    final loginResult = await _facebookAuth.login();
    if (loginResult.accessToken == null) {
      throw Exception('User has canceled sing in with facebook');
    }
    final oAuthCredential = FacebookAuthProvider.credential(
      loginResult.accessToken!.token,
    );
    final credential =
        await _firebaseAuth.signInWithCredential(oAuthCredential);
    LocalDataRepository().userEmail = credential.user!.email;
    return credential.user;
  }
}
