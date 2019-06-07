import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../locale/index.dart';
import '../../routes.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.palette),
            title: Text(Provider.of<LocaleState>(context).strings.theme_title),
            subtitle:
                Text(Provider.of<LocaleState>(context).strings.theme_subtitle),
            onTap: () => Navigator.pushNamed(context, Routes.theme_settings),
          ),
          ListTile(
            leading: Icon(Icons.notifications),
            title: Text(
                Provider.of<LocaleState>(context).strings.notifications_title),
            subtitle: Text(Provider.of<LocaleState>(context)
                .strings
                .notifications_subtitle),
            onTap: () => Navigator.pushNamed(context, Routes.notifications),
          ),
          ListTile(
            leading: Icon(Icons.language),
            title: Text(
                Provider.of<LocaleState>(context).strings.translations_title),
            subtitle: Text(Provider.of<LocaleState>(context)
                .strings
                .modify_and_change_languages),
            onTap: () => Navigator.pushNamed(context, Routes.translations),
          ),
          ListTile(
            leading: Icon(Icons.info),
            title: Text(Provider.of<LocaleState>(context).strings.intro_title),
            subtitle:
                Text(Provider.of<LocaleState>(context).strings.intro_subtitle),
            onTap: () => Navigator.pushNamed(context, Routes.intro),
          ),
        ],
      ),
    );
  }
}
