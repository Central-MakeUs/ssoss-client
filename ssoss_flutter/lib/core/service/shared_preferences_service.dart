import 'package:shared_preferences/shared_preferences.dart';

/// `shared_preferences` 래퍼.
class SharedPreferencesService {
  SharedPreferencesService({SharedPreferences? preferences})
      : _preferences = preferences;

  SharedPreferences? _preferences;

  Future<SharedPreferences> get _instance async {
    return _preferences ??= await SharedPreferences.getInstance();
  }

  Future<String?> readString(String key) async {
    final prefs = await _instance;
    return prefs.getString(key);
  }

  Future<void> writeString(String key, String value) async {
    final prefs = await _instance;
    await prefs.setString(key, value);
  }

  Future<void> remove(String key) async {
    final prefs = await _instance;
    await prefs.remove(key);
  }
}
