import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:test_app/app/domain/repository/auth_repository.dart';
import 'package:test_app/app/domain/value_object/email.dart';
import 'package:test_app/app/domain/value_object/password.dart';
import 'package:test_app/app/domain/value_object/status.dart';
import 'package:test_app/app/view/login/bloc/login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this._authRepository) : super(const LoginState());

  final AuthRepository _authRepository;

  void email(String value) {
    try {
      emit(
        state.copyWith(
          status: FormStatus.editing,
          email: Email(value.trim()),
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: FormStatus.editing,
          email: null,
        ),
      );
    }
  }

  void password(String value) {
    try {
      emit(
        state.copyWith(
          status: FormStatus.editing,
          password: Password(value.trim()),
        ),
      );
    } catch (_) {
      emit(
        state.copyWith(
          status: FormStatus.editing,
          password: null,
        ),
      );
    }
  }

  Future<void> login() async {
    emit(state.copyWith(status: FormStatus.loading));
    try {
      await _authRepository.login(
        email: state.email!.value,
        password: state.password!.value,
      );

      emit(
        state.copyWith(
          status: FormStatus.done,
        ),
      );
    } catch (e) {
      log(e.toString());
      emit(
        state.copyWith(status: FormStatus.error, msgError: e.toString()),
      );
    }
  }

  Future<void> loginGoogle() async {
    emit(state.copyWith(loadingLogin: true));
    try {
      await _authRepository.signInWithGoogle();
      emit(state.copyWith(status: FormStatus.done));
    } catch (e) {
      log(e.toString());
      emit(state.copyWith(loadingLogin: false));
    }
  }

  Future<void> loginFacebook() async {
    emit(state.copyWith(loadingLogin: true));
    try {
      await _authRepository.signInWithFacebook();
      emit(state.copyWith(status: FormStatus.done));
    } catch (e) {
      log(e.toString());
      emit(state.copyWith(loadingLogin: false));
    }
  }
}
