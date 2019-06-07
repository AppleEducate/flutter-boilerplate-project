import 'package:boilerplate/constants/index.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';

class ThemeProvider extends ChangeNotifier {
  final _storage = LocalStorage(StorageKeys.theme_key);
  bool _darkMode = false;
  bool get darkMode => _darkMode;

  void init() async {
    await _storage.ready;
    _darkMode = _storage.getItem(StorageKeys.is_dark_mode) ?? false;
    notifyListeners();
  }

  void changeBrightnessDark(bool value) {
    _darkMode = value;
    notifyListeners();
    _storage.setItem(StorageKeys.is_dark_mode, value);
  }

  bool isPlatformDark(BuildContext context) =>
      MediaQuery.platformBrightnessOf(context) == Brightness.dark;
}
