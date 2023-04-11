import 'package:bloc/bloc.dart';
import 'package:test_app/app/domain/repository/auth_repository.dart';
import 'package:test_app/app/view/home/home_page.dart';
import 'package:test_app/app/view/login/login_page.dart';
import 'package:test_app/app/view/splash/bloc/splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit(this._authRepository) : super(const SplashState()) {
    checkUser();
  }

  final AuthRepository _authRepository;

  Future<void> checkUser() async {
    var user = await _authRepository.user;
    emit(state.copyWith(
      route: user == null ? LoginPage.route : HomePage.route,
    ));
  }
}
