import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/sharedpref/constants/index.dart';
import '../locale/index.dart';
import '../routes.dart';
import '../utils/index.dart';
import '../widgets/index.dart';
import 'home/home.dart';
import 'settings/settings.dart';

class AppNavigation extends StatefulWidget {
  @override
  _AppNavigationState createState() => _AppNavigationState();
}

class _AppNavigationState extends State<AppNavigation>
    with AfterLayoutMixin<AppNavigation> {
  @override
  Widget build(BuildContext context) {
    return DynamicNavigation(
      type: NavigationType.bottomTabs,
      children: [
        Screen(
            iconData: Icons.home,
            title: AppLocalizations.of(context).posts_title,
            child: HomeScreen(),
            actions: [
              IconButton(
                onPressed: () {
                  SharedPreferences.getInstance().then((preference) {
                    preference.setBool(Preferences.is_logged_in, false);
                    Navigator.of(context).pushReplacementNamed(Routes.login);
                  });
                },
                icon: Icon(
                  Icons.power_settings_new,
                ),
              ),
            ]),
        Screen(
          iconData: Icons.settings,
          title: AppLocalizations.of(context).settings_title,
          child: SettingsScreen(),
        ),
      ],
    );
  }

  @override
  void afterFirstLayout(BuildContext context) {
    Notifications.setupNotifications(context).then((setup) {
      //  -- Notifications Setup --
      SharedPreferences.getInstance().then((preference) {
        if (preference.getBool(Preferences.is_fresh_install) ?? true) {
          Notifications.showNotification(
            context,
            id: 0,
            title: 'Welcome',
            body: 'Welcome to the app!',
          );
          preference.setBool(Preferences.is_fresh_install, false);
        }
      });
    });
  }
}
