import 'package:shared_preferences/shared_preferences.dart';

class LocalDataPersisance {
  static final _instance = LocalDataPersisance._internal();
  static SharedPreferences? _prefs;

  LocalDataPersisance._internal();
  factory LocalDataPersisance() => _instance;

  static Future<void> init() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  static Future<void> clear() async {
    await _prefs?.clear();
  }

  bool? get getIsFirstOpen => _prefs?.getBool("is_first_open");

  String? get getUserId => _prefs?.getString("user_id");

  String? get getUsername => _prefs?.getString("username");

  String? get getEmail => _prefs?.getString("email");

  String? get getLastCourse => _prefs?.getString("last_course");

  Future<void> setIsFirstOpen(bool value) async {
    await _prefs?.setBool('is_first_open', value);
  }

  Future<void> setUserId(String value) async {
    await _prefs?.setString('user_id', value);
  }

  Future<void> setUsername(String value) async {
    await _prefs?.setString('username', value);
  }

  Future<void> setEmail(String value) async {
    await _prefs?.setString('email', value);
  }

  Future<void> setLastCourse(String value) async {
    await _prefs?.setString('last_course', value);
  }

  Future<void> removeUserId() async {
    await _prefs?.remove('user_id');
  }

  Future<void> removeUsername() async {
    await _prefs?.remove('username');
  }

  Future<void> removeEmail() async {
    await _prefs?.remove('email');
  }

  Future<void> removeLastCourse() async {
    await _prefs?.remove('last_course');
  }
}
