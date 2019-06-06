import 'package:after_layout/after_layout.dart';
import 'package:flutter/cupertino.dart';
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
            iosIconData: CupertinoIcons.home,
            title: AppLocalizations.of(context).strings.posts_title,
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
          iosIconData: CupertinoIcons.settings,
          title: AppLocalizations.of(context).strings.settings_title,
          child: SettingsScreen(),
        ),
      ],
    );
  }

  @override
  void afterFirstLayout(BuildContext context) {
    Notifications.setupNotifications(context, onSelectNotification: (val) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => NotificationDetailsScreen(val),
          fullscreenDialog: true,
        ),
      );
    }).then((setup) {
      //  -- Notifications Setup --
      SharedPreferences.getInstance().then((preference) {
        if (preference.getBool(Preferences.is_fresh_install) ?? true) {
          Notifications.show(
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

class NotificationDetailsScreen extends StatelessWidget {
  NotificationDetailsScreen(this.payload);
  final String payload;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notification'),
      ),
      body: Center(
        child: Text(payload),
      ),
    );
  }
}
