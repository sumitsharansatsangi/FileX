import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:filex/providers/category_provider.dart';
import 'package:filex/screens/about.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:filex/utils/navigate.dart';
import 'package:filex/widgets/custom_divider.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        physics: const NeverScrollableScrollPhysics(),
        children: <Widget>[
          Consumer(
            builder: (context, ref, child) {
              final model = ref.watch(modelManagerProvider);
                return SwitchListTile.adaptive(
                  contentPadding: const EdgeInsets.all(0),
                  secondary: const Icon(
                    Feather.eye_off,
                  ),
                  title: Text(
                    'See hidden files',
                    style: TextStyle(
                        color: Theme.of(context).textTheme.titleSmall!.color),
                  ),
                  value: model.hidden,
                  onChanged: (value) async {
                    await ref.read(modelManagerProvider.notifier).changeHidden(value);
                  },
                  activeColor: Theme.of(context).colorScheme.secondary,
                );
            
            },
          ),
          const CustomDivider(),
          Consumer(
            builder: (context, ref, child) {
              final model = ref.watch(modelManagerProvider);
              final themeMode = ref.read(themeModeManagerProvider.notifier);
          
                return SwitchListTile.adaptive(
                  contentPadding: const EdgeInsets.all(0),
                  secondary: const Icon(Icons.light_mode),
                  title: Text(
                    "Dark Mode",
                    style: TextStyle(
                        color: Theme.of(context).textTheme.titleSmall!.color),
                  ),
                  onChanged: (val) async {
                    if (val) {
                      themeMode.toggleDark();
                    } else {
                      themeMode.toggleLight();
                    }
                    await ref.read(modelManagerProvider.notifier).changeTheme(val);
                  },
                  value: model.darkTheme,
                  activeColor: Theme.of(context).colorScheme.secondary,
                );
            },
          ),
          const CustomDivider(),
          ListTile(
            contentPadding: const EdgeInsets.all(0),
            onTap: () => showLicensePage(context: context),
            leading: const Icon(Feather.file_text),
            title: Text(
              'Open source licences',
              style: TextStyle(
                  color: Theme.of(context).textTheme.titleSmall!.color),
            ),
          ),
          const CustomDivider(),
          ListTile(
            contentPadding: const EdgeInsets.all(0),
            onTap: () => Navigate.pushPage(context, const About()),
            leading: const Icon(Feather.info),
            title: Text(
              'About',
              style: TextStyle(
                  color: Theme.of(context).textTheme.titleSmall!.color),
            ),
          ),
          Divider(
            height: 1,
            color: Theme.of(context).dividerColor,
          ),
        ],
      ),
    );
  }
}
