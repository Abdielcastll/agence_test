import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRepository {
  Future<void> login({required String email, required String password});
  Future<User?> get user;
  Future<User?> signInWithGoogle();
  Future<User?> signInWithFacebook();
  Future<void> logOut();
}
