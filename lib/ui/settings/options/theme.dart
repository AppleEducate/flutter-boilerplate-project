import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../locale/index.dart';
import '../../../providers/index.dart';

class ThemeSettings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Provider.of<LocaleState>(context).strings.theme_title),
      ),
      body: Consumer<ThemeProvider>(
          builder: (context, theme, child) => ListView(
                children: <Widget>[
                  if (theme.isPlatformDark(context)) ...[
                    ListTile(
                      title: Text(Provider.of<LocaleState>(context)
                          .strings
                          .dark_mode_title),
                      subtitle: Text(Provider.of<LocaleState>(context)
                          .strings
                          .dark_mode_subtitle),
                      trailing: Switch.adaptive(
                        value: true,
                        onChanged: null,
                      ),
                    ),
                  ] else ...[
                    ListTile(
                      title: Text(Provider.of<LocaleState>(context)
                          .strings
                          .dark_mode_title),
                      trailing: Switch.adaptive(
                        value: theme.darkMode,
                        onChanged: theme.changeBrightnessDark,
                      ),
                    ),
                  ]
                ],
              )),
    );
  }
}
