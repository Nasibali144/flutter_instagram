import 'package:shared_preferences/shared_preferences.dart';

enum StorageKeys {
  UID,
  TOKEN,
}

class Prefs {
  static store(StorageKeys key, String data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(_getKey(key), data);
  }

  static Future<String?> load(StorageKeys key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_getKey(key));
  }

  static Future<bool> remove(StorageKeys key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.remove(_getKey(key));
  }

  static String _getKey(StorageKeys key) {
    switch(key) {
      case StorageKeys.UID: return "uid";
      case StorageKeys.TOKEN: return "token";
    }
  }
}