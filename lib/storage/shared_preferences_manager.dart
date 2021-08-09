import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesManager {
  final SharedPreferences prefs;

  SharedPreferencesManager({required this.prefs});

  Future storeString(String key, String value) async {
    await prefs.setString(key, value);
    return;
  }

  String? getString(String key) {
    var response = prefs.getString(key);
    return response;
  }
}
