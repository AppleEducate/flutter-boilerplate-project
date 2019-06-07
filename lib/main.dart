import 'package:boilerplate/providers/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_local_notifications_provider/flutter_local_notifications_provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'constants/app_theme.dart';
import 'locale/index.dart';
import 'routes.dart';
import 'ui/splash/splash.dart';

void main() {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
    DeviceOrientation.landscapeRight,
    DeviceOrientation.landscapeLeft,
  ]).then((_) {
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ListenableProvider<LocaleProvider>.value(listenable: LocaleProvider()..init()),
        ListenableProvider<ThemeProvider>.value(listenable: ThemeProvider()..init()),
      ],
      child: Consumer<ThemeProvider>(
          builder: (context, theme, child) => Consumer<LocaleProvider>(
                builder: (context, locale, child) => NotificationProvider(
                    service: FlutterLocalNotificationsPlugin(),
                    child: MaterialApp(
                      localizationsDelegates: [
                        // ... app-specific localization delegate[s] here
                        GlobalMaterialLocalizations.delegate,
                        GlobalWidgetsLocalizations.delegate,
                        AppLocalizationsDelegate(locale),
                      ],
                      supportedLocales: locale.localizedValues.keys
                          .map((k) => Locale(k))
                          .toList(),
                      debugShowCheckedModeBanner: false,
                      onGenerateTitle: (BuildContext context) {
                        return locale?.strings?.title ?? '';
                      },
                      locale: locale?.locale,
                      theme: theme.darkMode ? themeDataDark : themeData,
                      darkTheme: themeDataDark,
                      routes: Routes.routes,
                      home: SplashScreen(),
                    )),
              )),
    );
  }
}
