import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:filex/providers/provider.dart';
import 'package:filex/screens/home.dart';
import 'dart:io';

import 'package:filex/screens/ios_error.dart';
import 'package:filex/utils/strings.dart';


void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.fromSeed(
        seedColor: const Color.fromRGBO(178, 216, 216, 100));

    final ThemeData lightTheme = ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: colorScheme.surface,
      iconButtonTheme: IconButtonThemeData(
          style: IconButton.styleFrom(
        foregroundColor: colorScheme.primary,
      )),
      textTheme: TextTheme(
          titleLarge: TextStyle(color: colorScheme.primary),
          titleMedium: TextStyle(color: colorScheme.primary),
          titleSmall: TextStyle(color: colorScheme.primary)),
      iconTheme: IconThemeData(color: colorScheme.primary),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: colorScheme.primaryContainer,
        indicatorColor: colorScheme.onSecondary.withOpacity(0.5),
        iconTheme:
            WidgetStatePropertyAll(IconThemeData(color: colorScheme.primary)),
        labelTextStyle:
            WidgetStatePropertyAll(TextStyle(color: colorScheme.primary)),
      ),
      appBarTheme: AppBarTheme(
        elevation: 0,
        color: colorScheme.primaryContainer,
        titleTextStyle: TextStyle(
          color: colorScheme.secondary,
          fontSize: 20,
          fontWeight: FontWeight.w800,
        ),
      ),
    );

    final ThemeData darkTheme = ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: colorScheme.onSurface,
      iconButtonTheme: IconButtonThemeData(
          style: IconButton.styleFrom(
        foregroundColor: colorScheme.primaryContainer,
      )),
      textTheme: TextTheme(
          titleLarge: TextStyle(color: colorScheme.secondaryContainer),
          titleMedium: TextStyle(color: colorScheme.secondaryContainer),
          titleSmall: TextStyle(color: colorScheme.secondaryContainer)),
      iconTheme: IconThemeData(color: colorScheme.primaryContainer),
      listTileTheme: ListTileThemeData(iconColor: colorScheme.surfaceContainerHighest),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: colorScheme.secondary,
        indicatorColor: colorScheme.onSecondary.withOpacity(0.3),
        iconTheme: WidgetStatePropertyAll(
            IconThemeData(color: colorScheme.onInverseSurface)),
        labelTextStyle: WidgetStatePropertyAll(
            TextStyle(color: colorScheme.onInverseSurface)),
      ),
      appBarTheme: AppBarTheme(
        elevation: 0,
        color: colorScheme.secondary,
        titleTextStyle: TextStyle(
          color: colorScheme.onPrimary,
          fontSize: 20,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
    return Consumer(
      builder: (BuildContext context, ref, Widget? child) {
        final themeMode = ref.watch(themeModeManagerProvider);
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: AppStrings.appName,
          themeMode: themeMode,
          theme: lightTheme,
          darkTheme: darkTheme,
          home: Platform.isIOS ? const IosError() : const Home(),
        );
      },
    );
  }
}
