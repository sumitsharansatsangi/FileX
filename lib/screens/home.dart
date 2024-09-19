import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:filex/utils/dialogs.dart';
import 'package:permission_handler/permission_handler.dart';

import 'browse.dart';
import 'gallery.dart';
import 'settings.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<Home> {
  late PageController _pageController;
  int _page = 0;
  bool _notPermission = true;

  @override
  Widget build(BuildContext context) {
      //  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    //   statusBarColor: Theme.of(context).brightness == Brightness.dark
    //       ? Colors.white
    //       : Colors.black,
    // ));
    if (_notPermission) {
      return Scaffold(
          backgroundColor: const Color.fromARGB(200, 18, 147, 137),
          body: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Permission not granted',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              ElevatedButton(
                  onPressed: requestPermission,
                  child: const Text("Grant Permission"))
            ],
          )));
    } else {
      return WillPopScope(
        onWillPop: () => Dialogs.showExitDialog(context),
        child: Scaffold(
          body: PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: _pageController,
            onPageChanged: onPageChanged,
            children: const <Widget>[
              Browse(),
              Gallery(),
              Settings(),
            ],
          ),
          bottomNavigationBar: NavigationBar(
            elevation: 4.0,
            destinations: const [
              NavigationDestination(
                icon: Icon(Feather.folder),
                label: 'Browse',
              ),
              NavigationDestination(
                icon: Icon(Icons.image_outlined),
                label: 'Gallery',
              ),
              NavigationDestination(
                icon: Icon(Feather.settings),
                label: 'Settings',
              ),
            ],
            onDestinationSelected: navigationTapped,
            selectedIndex: _page,
          ),
        ),
      );
    }
  }

  void navigationTapped(int page) {
    _pageController.jumpToPage(page);
  }

  Future<void> checkPermission() async {
    PermissionStatus status = await Permission.storage.status;
    if (!status.isGranted) {
      await requestPermission();
    } else {
      FlutterNativeSplash.remove();
      setState(() {
        _notPermission = false;
      });
    }
  }

  Future<void> requestPermission() async {
    PermissionStatus status = await Permission.storage.request();
    FlutterNativeSplash.remove();
    if (status.isGranted) {
      setState(() {
        _notPermission = false;
      });
    } else if (status.isPermanentlyDenied) {
      await openAppSettings();
      await checkPermission();
    }
  }

  @override
  void initState() {
    super.initState();
    checkPermission();
    _pageController = PageController(initialPage: 0);
    SchedulerBinding.instance.addPostFrameCallback((_) {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
          overlays: SystemUiOverlay.values);
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Theme.of(context).primaryColor,
        systemNavigationBarColor: Colors.black,
      ));
    });
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }
}
