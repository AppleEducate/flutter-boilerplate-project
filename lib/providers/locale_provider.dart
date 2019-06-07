import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:provider/provider.dart';

import '../constants/index.dart';
import '../locale/index.dart';

class LocaleProvider extends ChangeNotifier {
  final _storage = LocalStorage(StorageKeys.locale_key);
  Map<String, Strings> get localizedValues => _localizedValues;
  void addLocale(String key, Strings data) {
    _localizedValues[key] = data;
    notifyListeners();
    _storage.setItem(StorageKeys.current_language, _locale);
    final Map<String, dynamic> _data = {};
    for (var key in _localizedValues.keys) {
      _data[key] = _localizedValues[key].toJson();
    }
  }

  Locale _locale;
  Locale get locale => _locale;

  void changeLanguage(String value) {
    _locale = Locale(value);
    notifyListeners();
    _storage.setItem(StorageKeys.current_language, value);
  }

  void init() async {
    reset(true);
    await _storage.ready;

    final _data = _storage.getItem(StorageKeys.languages);
    if (_data == null) {
      reset(false);
    } else {
      final Map<String, dynamic> _json = _data;
      for (var key in _json.keys) {
        _localizedValues[key] = Strings.fromJson(_json[key]);
      }
      notifyListeners();
    }

    final _code = _storage.getItem(StorageKeys.current_language);
    if (_code != null) {
      _locale = Locale(_code);
      notifyListeners();
    }
  }

  void reset(bool init) {
    _locale = null;
    _localizedValues = {
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
        intro_title: 'Welcome Intro',
        intro_subtitle: 'Run the Walkthrough Again',
        dark_mode_subtitle: 'Platform using Dark Mode',
        dark_mode_title: 'Dark Mode',
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
        intro_title: 'Introducción de bienvenida',
        intro_subtitle: 'Ejecutar el tutorial de nuevo',
        dark_mode_subtitle: 'Plataforma usando el modo oscuro',
        dark_mode_title: 'Modo oscuro',
      ),
    };
    notifyListeners();

    if (!init) {
      _storage.setItem(StorageKeys.current_language, _locale);
      final Map<String, dynamic> _data = {};
      for (var key in _localizedValues.keys) {
        _data[key] = _localizedValues[key].toJson();
      }
      _storage.setItem(StorageKeys.languages, _data);
    }
  }

  Map<String, Strings> _localizedValues = {};

  Strings get strings {
    final _data = _localizedValues[_locale?.languageCode ?? 'en'];
    return _data;
  }
}

Strings getLocale(BuildContext context) {
  return Provider.of<LocaleProvider>(context).strings;
}
