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

  String? get getUsername => _prefs?.getString("username");

  String? get getAvatar => _prefs?.getString("avatar");

  String? get getLastCourse => _prefs?.getString("last_course");

  Future<void> setIsFirstOpen(bool value) async {
    await _prefs?.setBool('is_first_open', value);
  }

  Future<void> setUsername(String value) async {
    await _prefs?.setString('username', value);
  }

  Future<void> setAvatar(String value) async {
    await _prefs?.setString('avatar', value);
  }

  Future<void> setLastCourse(String value) async {
    await _prefs?.setString('last_course', value);
  }

  Future<void> removeUsername() async {
    await _prefs?.remove('username');
  }

  Future<void> removeAvatar() async {
    await _prefs?.remove('avatar');
  }

  Future<void> removeLastCourse() async {
    await _prefs?.remove('last_course');
  }
}
