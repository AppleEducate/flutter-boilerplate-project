import 'package:flutter/material.dart';

import 'ui/login/login.dart';
import 'ui/navigation.dart';
import 'ui/settings/options/index.dart';
import 'ui/settings/options/theme.dart';
import 'ui/settings/options/translations.dart';
import 'ui/splash/index.dart';
import 'ui/splash/splash.dart';

class Routes {
  Routes._();

  //static variables
  static const String splash = '/splash';
  static const String login = '/login';
  static const String home = '/home';
  static const String intro = '/intro';
  static const String theme_settings = '/theme_settings';
  static const String notifications = '/notifications';
  static const String translations = '/translations';

  static final routes = <String, WidgetBuilder>{
    splash: (_) => SplashScreen(),
    login: (_) => LoginScreen(),
    home: (_) => AppNavigation(),
    intro: (_) => IntroScreen(),
    theme_settings: (_) => ThemeSettings(),
    notifications: (_) => NotificationsSettings(),
    translations: (_) => TranslationHelpScreen(),
  };
}
