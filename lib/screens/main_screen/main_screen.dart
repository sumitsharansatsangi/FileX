import 'package:filex/providers/providers.dart';
import 'package:filex/screens/browse/browse.dart';
import 'package:filex/screens/settings.dart';
// import 'package:filex/screens/share.dart';
import 'package:filex/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late PageController _pageController;
  int _page = 0;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Dialogs.showExitDialog(context),
      child: Scaffold(
        body: PageView(
          physics: NeverScrollableScrollPhysics(),
          controller: _pageController,
          onPageChanged: onPageChanged,
          children: <Widget>[
            Browse(),
            // Share(),
            Settings(),
          ],
        ),
        bottomNavigationBar: NavigationBar(
          elevation: 4.0,
          destinations: [
            NavigationDestination(
              icon: Icon(Feather.folder),
              label: 'Browse',
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

  void navigationTapped(int page) {
    _pageController.jumpToPage(page);
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
    SchedulerBinding.instance.addPostFrameCallback((_) {
      Provider.of<CoreProvider>(context, listen: false).checkSpace();
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
          overlays: SystemUiOverlay.values);
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Theme.of(context).primaryColor,
        systemNavigationBarColor: Colors.black,
        // statusBarIconBrightness:
        //     Theme.of(context).primaryColor == ThemeConfig.darkTheme.primaryColor
        //         ? Brightness.light
        //         : Brightness.dark,
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
      this._page = page;
    });
  }
}
