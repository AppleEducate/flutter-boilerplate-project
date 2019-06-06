import 'package:boilerplate/utils/index.dart';
import 'package:flutter/material.dart';

import 'options/index.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.palette),
            title: Text('Theme'),
            subtitle: Text('Look and Feel'),
          ),
          ListTile(
            leading: Icon(Icons.notifications),
            title: Text('Notifications'),
            subtitle: Text('Push Notifications'),
          ),
          ListTile(
            leading: Icon(Icons.language),
            title: Text('Translations'),
            subtitle: Text('Modify and Request Languages'),
            onTap: () => navigate(context, TranslationHelpScreen()),
          ),
        ],
      ),
    );
  }
}
