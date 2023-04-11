import 'package:shared_preferences/shared_preferences.dart';

class LocalDataRepository {
  static final LocalDataRepository _instance = LocalDataRepository._();
  factory LocalDataRepository() {
    return _instance;
  }
  LocalDataRepository._();

  late SharedPreferences _localStorage;

  initPrefs() async {
    _localStorage = await SharedPreferences.getInstance();
  }

  bool get isLogged => _localStorage.getBool('@isLogged') ?? false;

  set isLogged(bool value) {
    _localStorage.setBool('@isLogged', value);
  }

  String? get userEmail => _localStorage.getString('@email');

  set userEmail(String? value) {
    _localStorage.setString('@email', value!);
  }

  Future<void> logOut() async {
    _localStorage.clear();
  }
}
