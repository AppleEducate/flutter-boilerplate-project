import 'package:flutter/material.dart';

import '../../providers/index.dart';
import '../../routes.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.palette),
            title: Text(getLocale(context).theme_title),
            subtitle: Text(getLocale(context).theme_subtitle),
            onTap: () => Navigator.pushNamed(context, Routes.theme_settings),
          ),
          ListTile(
            leading: Icon(Icons.notifications),
            title: Text(getLocale(context).notifications_title),
            subtitle: Text(getLocale(context)
                .notifications_subtitle),
            onTap: () => Navigator.pushNamed(context, Routes.notifications),
          ),
          ListTile(
            leading: Icon(Icons.language),
            title: Text(getLocale(context).translations_title),
            subtitle: Text(getLocale(context).modify_and_change_languages),
            onTap: () => Navigator.pushNamed(context, Routes.translations),
          ),
          ListTile(
            leading: Icon(Icons.info),
            title: Text(getLocale(context).intro_title),
            subtitle: Text(getLocale(context).intro_subtitle),
            onTap: () => Navigator.pushNamed(context, Routes.intro),
          ),
        ],
      ),
    );
  }
}
