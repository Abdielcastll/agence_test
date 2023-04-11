import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:test_app/app/domain/value_object/email.dart';
import 'package:test_app/app/domain/value_object/password.dart';
import 'package:test_app/app/domain/value_object/status.dart';

part 'login_state.freezed.dart';

@freezed
class LoginState with _$LoginState {
  const factory LoginState({
    @Default(FormStatus.editing) FormStatus status,
    @Default(false) bool loadingLogin,
    String? msgError,
    Email? email,
    Password? password,
  }) = _LoginState;

  const LoginState._();

  bool get isComplete => email != null && password != null;
}
