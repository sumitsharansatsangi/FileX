
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  final String key = "theme";
  SharedPreferences? prefs;
  bool? darkTheme;

  ThemeProvider() {
    loadFromPrefs();
  }

  toggleTheme() {
    darkTheme = !darkTheme!;
    saveToPrefs();
    notifyListeners();
  }

  _initPrefs() async {
    if (prefs == null) prefs = await SharedPreferences.getInstance();
  }

  loadFromPrefs() async {
    await _initPrefs();
    darkTheme = prefs!.getBool(key);
    notifyListeners();
  }

  saveToPrefs() async {
    await _initPrefs();
    prefs!.setBool(key, darkTheme!);
  }
}