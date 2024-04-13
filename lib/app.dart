import 'dart:io';

import 'package:filex/providers/providers.dart';
import 'package:filex/screens/ios_error.dart';
import 'package:filex/screens/splash.dart';
import 'package:filex/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final lightColorScheme = ColorScheme.fromSeed(
        seedColor: const Color.fromRGBO(178, 216, 216, 100));
    final darkColorSchme =
        ColorScheme.fromSeed(seedColor: const Color.fromRGBO(0, 0, 76, 100));

    final ThemeData lightTheme = ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: lightColorScheme,
      scaffoldBackgroundColor: lightColorScheme.background,
      appBarTheme: AppBarTheme(
        elevation: 0,
        color: lightColorScheme.primary,
        titleTextStyle: TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.w800,
        ),
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
      ),
    );

    final ThemeData darkTheme = ThemeData(
      brightness: Brightness.dark,
      useMaterial3: true,
      scaffoldBackgroundColor: darkColorSchme.background,
      appBarTheme: AppBarTheme(
        elevation: 0,
        color: darkColorSchme.primary,
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w800,
        ),
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
    );
    return Consumer<AppProvider>(
      builder: (BuildContext context, appProvider, Widget? child) {
        return MaterialApp(
          key: appProvider.key,
          debugShowCheckedModeBanner: false,
          navigatorKey: appProvider.navigatorKey,
          title: AppStrings.appName,
          theme: lightTheme,
          darkTheme: darkTheme,
          home: Platform.isIOS ? IosError() : Splash(),
        );
      },
    );
  }
}
