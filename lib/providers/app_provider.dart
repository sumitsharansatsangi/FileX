import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppProvider extends ChangeNotifier {
  AppProvider() {
    checkTheme();
  }

  // ThemeData theme = ThemeConfig.lightTheme;
  Key key = UniqueKey();
  GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  void setKey(value) {
    key = value;
    notifyListeners();
  }

  void setNavigatorKey(value) {
    navigatorKey = value;
    notifyListeners();
  }

  void setTheme(value, c, context) {
    // theme = value;
    SharedPreferences.getInstance().then((prefs) {
      prefs.setString('theme', c).then((val) {
        SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
            overlays: SystemUiOverlay.values);
        SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
          statusBarColor: Theme.of(context).colorScheme.primary,
          statusBarIconBrightness:
              c == 'dark' ? Brightness.light : Brightness.dark,
        ));
      });
    });
    notifyListeners();
  }

  ThemeData getTheme(value) {
    return ThemeData.dark();
  }

  Future<ThemeData> checkTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    ThemeData t = ThemeData.dark();
    String? r =
        prefs.getString('theme') == null ? 'light' : prefs.getString('theme');

    // if (r == 'light') {
    //   t = ThemeConfig.lightTheme;
    //   setTheme(ThemeConfig.lightTheme, 'light', context);
    // } else {
    //   t = ThemeConfig.darkTheme;
    //   setTheme(ThemeConfig.darkTheme, 'dark', context);
    // }

    return t;
  }
}
