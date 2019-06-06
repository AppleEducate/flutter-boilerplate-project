import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_local_notifications_provider/flutter_local_notifications_provider.dart';

class Notifications {
  Notifications._();

  static const String android_icon = "app_icon";

  // static Future onSelectNotification(String payload) {}

  // static Future onDidReceiveLocalNotification(
  //     int id, String title, String body, String payload) {}

  static Future<bool> setupNotifications(
    BuildContext context, {
    String androidIcon = 'app_icon',
    Function(String) onSelectNotification,
    Function(int, String, String, String) onDidReceiveLocalNotification,
  }) async {
    var plugin = NotificationProvider.of(context);
    AndroidInitializationSettings _android =
        new AndroidInitializationSettings(android_icon);
    IOSInitializationSettings _ios = IOSInitializationSettings(
      onDidReceiveLocalNotification: onDidReceiveLocalNotification,
    );
    InitializationSettings _settings = InitializationSettings(_android, _ios);
    final _setup = await plugin.initialize(
      _settings,
      onSelectNotification: onSelectNotification,
    );
    return _setup ?? false;
  }

 static Future showNotification(
    BuildContext context, {
    @required String title,
    @required String body,
    int id = 0,
    NotificationDetails notificationDetails,
  }) async {
    var plugin = NotificationProvider.of(context);
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        '000000', 'General', 'General Notifications',
        importance: Importance.Max, priority: Priority.High);
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await plugin.show(
        id, title, body, notificationDetails ?? platformChannelSpecifics);
  }
}
