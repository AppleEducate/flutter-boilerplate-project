import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recase/recase.dart';

import '../../../locale/index.dart';
import '../../../utils/index.dart';

class TranslationHelpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text(Provider.of<LocaleState>(context).strings.translations_title),
        actions: <Widget>[
          Consumer<LocaleState>(
            builder: (context, model, child) => IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () => navigate<Map<String, Map<String, dynamic>>>(
                        context,
                        EditLanguageView(),
                        fullScreen: true,
                      ).then((data) {
                        if (data != null) {
                          final _key = data.keys.first;
                          model.addLocale(_key, Strings.fromJson(data[_key]));
                          Navigator.pop(context);
                        }
                      }),
                ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Consumer<LocaleState>(
              builder: (context, model, child) => Column(
                    children: <Widget>[
                      ListTile(
                        title: DropdownButtonFormField<String>(
                          value:
                              AppLocalizations.of(context).locale.languageCode,
                          decoration: InputDecoration(
                              labelText: Provider.of<LocaleState>(context)
                                  .strings
                                  .current_language),
                          onChanged: model.changeLanguage,
                          items: [
                            for (var code in model.localizedValues.keys) ...[
                              DropdownMenuItem<String>(
                                value: code,
                                child: SizedBox(
                                  width: 300,
                                  child: Text(languageCodes[code], maxLines: 1),
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                      for (int i = 0;
                          i < model.localizedValues.keys.length;
                          i++) ...[
                        Builder(
                          builder: (_) {
                            final _key = model.localizedValues.keys.toList()[i];
                            return ListTile(
                              selected: model?.locale?.languageCode == _key,
                              title:
                                  Text(ReCase(languageCodes[_key]).titleCase),
                              subtitle: Text(_key),
                              onTap: () => navigate<Map<String, Strings>>(
                                  context,
                                  LanguageView(
                                    languageCode: _key,
                                    strings: model.localizedValues[_key],
                                  )),
                            );
                          },
                        )
                      ],
                    ],
                  )),
        ),
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
        title: Text('${languageCodes[languageCode]}'),
        actions: <Widget>[
          Consumer<LocaleState>(
            builder: (context, model, child) => IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () => navigate<Map<String, Map<String, dynamic>>>(
                        context,
                        EditLanguageView(
                          strings: strings,
                          languageCode: languageCode,
                        ),
                        fullScreen: true,
                      ).then((data) {
                        if (data != null) {
                          final _key = data.keys.first;
                          model.addLocale(_key, Strings.fromJson(data[_key]));
                          Navigator.pop(context);
                        }
                      }),
                ),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: strings.toJson().keys.length,
        itemBuilder: (context, index) {
          final _key = strings.toJson().keys.toList()[index];
          final _language = strings.toJson()[_key];
          return ListTile(
            title: Text(ReCase(_key).titleCase),
            subtitle: Text(_language),
          );
        },
      ),
    );
  }
}

class EditLanguageView extends StatefulWidget {
  const EditLanguageView({
    this.languageCode,
    this.strings,
  });
  final String languageCode;
  final Strings strings;

  @override
  _EditLanguageViewState createState() => _EditLanguageViewState();
}

class _EditLanguageViewState extends State<EditLanguageView> {
  Map<String, dynamic> _strings;
  String _language;
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    _strings = widget?.strings?.toJson() ??
        Strings(
          title: '',
          login_hint_user_email: '',
          login_hint_user_password: '',
          login_button_forgot_password: '',
          login_button_sign_in: '',
          login_validation_error: '',
          posts_title: '',
          posts_not_found: '',
          post_not_selected: '',
          settings_title: '',
          translations_title: '',
          current_language: '',
          modify_and_change_languages: '',
          language: '',
          language_required: '',
          theme_subtitle: '',
          theme_title: '',
          notifications_subtitle: '',
          notifications_title: '',
          new_language: '',
          edit_language: '',
          intro_subtitle: '',
          intro_title: '',
          dark_mode_subtitle: '',
          dark_mode_title: '',
        )?.toJson();
    _language = widget?.languageCode ?? null;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget?.languageCode == null || widget.languageCode.isEmpty
              ? Provider.of<LocaleState>(context).strings.new_language
              : Provider.of<LocaleState>(context).strings.edit_language,
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () async {
              if (_formKey.currentState.validate()) {
                _formKey.currentState.save();
                final Map<String, Map<String, dynamic>> _data = {};
                _data[_language] = _strings;
                print('$_language => $_strings');
                Navigator.of(context).pop(_data);
              }
            },
          ),
        ],
      ),
      body: Form(
        autovalidate: true,
        key: _formKey,
        child: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              children: <Widget>[
                ListTile(
                  title: DropdownButtonFormField<String>(
                    value: _language,
                    decoration: InputDecoration(
                        labelText:
                            Provider.of<LocaleState>(context).strings.language),
                    validator: (val) => val == null || val.isEmpty
                        ? Provider.of<LocaleState>(context)
                            .strings
                            .language_required
                        : null,
                    onSaved: (val) => _language = val,
                    onChanged: (val) {
                      if (mounted)
                        setState(() {
                          _language = val;
                        });
                    },
                    items: [
                      for (var code in languageCodes.keys) ...[
                        DropdownMenuItem<String>(
                          value: code,
                          child: SizedBox(
                            width: 300,
                            child: Text(languageCodes[code], maxLines: 1),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                for (int i = 0; i < _strings.keys.length; i++) ...[
                  ListTile(
                    title: Builder(
                      builder: (_) {
                        final _key = _strings.keys.toList()[i];
                        final _lang = _strings[_key];
                        return TextFormField(
                          initialValue: _lang,
                          decoration: InputDecoration(
                              labelText: ReCase(_key).titleCase),
                          validator: (val) => val.isEmpty
                              ? '${ReCase(_key).titleCase} Required'
                              : null,
                          onSaved: (val) => _strings[_key] = val,
                        );
                      },
                    ),
                  ),
                ]
              ],
            ),
          ),
        ),
      ),
    );
  }
}
