import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../locale/index.dart';
import '../../utils/index.dart';
import 'options/index.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.palette),
            title: Text(Provider.of<LocaleState>(context).strings.theme_title),
            subtitle: Text(Provider.of<LocaleState>(context).strings.theme_subtitle),
          ),
          ListTile(
            leading: Icon(Icons.notifications),
            title: Text(Provider.of<LocaleState>(context).strings.notifications_title),
            subtitle: Text(Provider.of<LocaleState>(context).strings.notifications_subtitle),
          ),
          ListTile(
            leading: Icon(Icons.language),
            title: Text(Provider.of<LocaleState>(context).strings.translations_title),
            subtitle: Text(Provider.of<LocaleState>(context).strings.modify_and_change_languages),
            onTap: () => navigate(context, TranslationHelpScreen()),
          ),
        ],
      ),
    );
  }
}
