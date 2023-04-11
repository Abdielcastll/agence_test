import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:test_app/app/data/repository_impl/auth_repository_implement.dart';
import 'package:test_app/app/data/repository_impl/products_repository_implement.dart';
import 'package:test_app/app/domain/repository/auth_repository.dart';
import 'package:test_app/app/domain/repository/products_repositoyr.dart';

final getIt = GetIt.instance;

abstract class ServiceLocator {
  static Future<void> setup() async {
    getIt
      ..registerSingleton<AuthRepository>(AuthRepositoryImplement(
        firebaseAuth: FirebaseAuth.instance,
        googleSignIn: GoogleSignIn(),
        facebookAuth: FacebookAuth.i,
      ))
      ..registerSingleton<ProductsRepository>(ProductsRepositoryImplement());
  }
}
