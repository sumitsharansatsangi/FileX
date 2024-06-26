import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:filex/widgets/custom_divider.dart';
import 'package:filex/widgets/custom_loader.dart';

class AppScreen extends StatelessWidget {
  const AppScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Installed Apps'),
      ),
      body: FutureBuilder<List<Application>>(
        future: DeviceApps.getInstalledApplications(
          onlyAppsWithLaunchIntent: true,
          includeSystemApps: true,
          includeAppIcons: true,
        ),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Application>? data = snapshot.data;
            // Sort the App List on Alphabetical Order
            data!.sort((app1, app2) => app1.appName
                .toLowerCase()
                .compareTo(app2.appName.toLowerCase()));
            return ListView.separated(
              padding: const EdgeInsets.only(left: 10),
              itemCount: data.length,
              itemBuilder: (BuildContext context, int index) {
                Application app = data[index];
                return ListTile(
                  leading: app.icon != null
                      ? Image.memory(app.icon!, height: 40, width: 40)
                      : null,
                  title: Text(
                    app.appName,
                    style: TextStyle(
                        color: Theme.of(context).textTheme.titleSmall!.color),
                  ),
                  subtitle: Text(
                    app.packageName,
                    style: TextStyle(
                        color: Theme.of(context)
                            .textTheme
                            .titleSmall!
                            .color!
                            .withOpacity(0.6)),
                  ),
                  onTap: () => DeviceApps.openApp(app.packageName),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return const CustomDivider();
              },
            );
          }
          return const CustomLoader();
        },
      ),
    );
  }
}
