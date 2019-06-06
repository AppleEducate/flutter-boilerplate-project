import 'package:boilerplate/locale/index.dart';
import 'package:boilerplate/utils/index.dart';
import 'package:flutter/material.dart';
import 'package:recase/recase.dart';

class TranslationHelpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Translations'),
      ),
      body: ListView.builder(
        itemCount: localStrings.keys.length,
        itemBuilder: (context, index) {
          final _key = localStrings.keys.toList()[index];
          final _language = localStrings[_key];
          return ListTile(
            leading: Icon(Icons.flag),
            title: Text(Locale(_key).languageCode),
            onTap: () => navigate(
                context, LanguageView(languageCode: _key, strings: _language)),
          );
        },
      ),
    );
  }
}

class LanguageView extends StatelessWidget {
  const LanguageView({
    @required this.languageCode,
    @required this.strings,
  });
  final String languageCode;
  final Strings strings;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Language: $languageCode'),
      ),
      body: ListView.builder(
        itemCount: strings.toJson().keys.length,
        itemBuilder: (context, index) {
          final _key = strings.toJson().keys.toList()[index];
          final _language = strings.toJson()[_key];
          return ListTile(
            // leading: Icon(Icons.flag),
            title: Text(ReCase(_key).titleCase),
            subtitle: Text(_language),
          );
        },
      ),
    );
  }
}
