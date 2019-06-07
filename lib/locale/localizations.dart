// Copyright 2017 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// A simple "rough and ready" example of localizing a Flutter app.
// Spanish and English (locale language codes 'en' and 'es') are
// supported.

// The pubspec.yaml file must include flutter_localizations in its
// dependencies section. For example:
//
// dependencies:
//   flutter:
//   sdk: flutter
//  flutter_localizations:
//    sdk: flutter

// If you run this app with the device's locale set to anything but
// English or Spanish, the app's locale will be English. If you
// set the device's locale to Spanish, the app's locale will be
// Spanish.

import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show SynchronousFuture;
import 'package:flutter/rendering.dart' as prefix0;
import 'package:provider/provider.dart';

import 'index.dart';

class AppLocalizations {
  AppLocalizations(this.locale);

  final Locale locale;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  Strings getStrings(LocaleState value) {
    final _values = value.localizedValues;
    final _locale = locale;
    return _values[_locale.languageCode];
  }
}

class LocaleState extends ChangeNotifier {
  Map<String, Strings> get localizedValues => _localizedValues;
  void addLocale(String key, Strings data) {
    _localizedValues[key] = data;
    notifyListeners();
  }

  Locale _locale;
  Locale get locale => _locale;

  void changeLanguage(String value) {
    _locale = Locale(value);
    print('Language: $value => ${_localizedValues.keys}');
    notifyListeners();
  }

  Map<String, Strings> _localizedValues = {
    'en': Strings(
      title: 'Boilerplate Project',
      login_hint_user_email: 'Enter user email',
      login_hint_user_password: 'Enter password',
      login_button_forgot_password: 'Forgot Password?',
      login_button_sign_in: 'Sign In',
      login_validation_error: 'Please fill in all fields',
      posts_title: 'Posts',
      posts_not_found: 'No Posts Found',
      post_not_selected: 'No Post Selected',
      settings_title: 'Settings',
      translations_title: 'Translations',
      current_language: 'Current Language',
      modify_and_change_languages: 'Modify and Request Languages',
      language: 'Language',
      language_required: 'Language Required',
      new_language: 'New Language',
      edit_language: 'Edit Language',
      theme_title: 'Theme',
      theme_subtitle: 'Look and Feel',
      notifications_title: 'Notifications',
      notifications_subtitle: 'Push Notifications',
    ),
    'es': Strings(
      title: 'Proyecto repetitivo',
      login_hint_user_email: 'Ingrese el email del usuario',
      login_hint_user_password: 'introducir la contraseña',
      login_button_forgot_password: 'Se te olvidó tu contraseña',
      login_button_sign_in: 'Registrarse',
      login_validation_error: 'Por favor rellena todos los campos',
      posts_title: 'Mensajes',
      posts_not_found: 'No se han encontrado publicacionesd',
      post_not_selected: 'Ninguna publicación seleccionada',
      settings_title: 'Ajustes',
      translations_title: 'Traducciones',
      current_language: 'Idioma actual',
      modify_and_change_languages: 'Modificar y solicitar idiomas',
      language: 'Idioma',
      language_required: 'Idioma requerido',
      new_language: 'Nuevo idioma',
      edit_language: 'Editar idioma',
      theme_title: 'Tema',
      theme_subtitle: 'Mira y siente',
      notifications_title: 'Notificaciones',
      notifications_subtitle: 'Notificaciones push',
    ),
  };

  Strings get strings {
    final _data = _localizedValues[_locale?.languageCode ?? 'en'];
    return _data;
  }
}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate(this.state);
  final LocaleState state;

  @override
  bool isSupported(Locale locale) {
    return state.localizedValues.keys.contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) {
    // Returning a SynchronousFuture here because an async "load" operation
    // isn't needed to produce an instance of AppLocalizations.
    return SynchronousFuture<AppLocalizations>(AppLocalizations(locale));
  }

  @override
  bool shouldReload(AppLocalizationsDelegate old) => false;
}
