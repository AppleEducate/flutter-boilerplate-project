import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_local_notifications_provider/flutter_local_notifications_provider.dart';

class Notifications {
  Notifications._();

  static const String android_channel_description = "app_icon";
  static const String android_channel_id = "000000";
  static const String android_channel_name = "app_icon";
  static const String android_icon = "app_icon";
  static const Importance android_importance = Importance.Max;
  static const Priority android_proprity = Priority.High;
  static const bool ios_present_alert = true;
  static const bool ios_present_badge = false;
  static const bool ios_present_sound = false;
  static const String ios_sound = null;

  static Future<bool> setupNotifications(
    BuildContext context, {
    Function(String) onSelectNotification,
    Function(int, String, String, String) onDidReceiveLocalNotification,
    bool requestAlertPermission: true,
    bool requestSoundPermission: true,
    bool requestBadgePermission: true,
    bool defaultPresentAlert: true,
    bool defaultPresentSound: true,
    bool defaultPresentBadge: true,
  }) async {
    var plugin = NotificationProvider.of(context);
    final _android = AndroidInitializationSettings(android_icon);
    final _ios = IOSInitializationSettings(
      requestAlertPermission: requestAlertPermission,
      requestSoundPermission: requestSoundPermission,
      requestBadgePermission: requestBadgePermission,
      defaultPresentAlert: defaultPresentAlert,
      defaultPresentSound: defaultPresentSound,
      defaultPresentBadge: defaultPresentBadge,
      onDidReceiveLocalNotification: onDidReceiveLocalNotification,
    );
    InitializationSettings _settings = InitializationSettings(_android, _ios);
    final _setup = await plugin.initialize(
      _settings,
      onSelectNotification: onSelectNotification,
    );
    return _setup ?? false;
  }

  static NotificationDetails _getSpecifics() {
    final androidPlatformChannelSpecifics = AndroidNotificationDetails(
        android_channel_id, android_channel_name, android_channel_description,
        importance: android_importance, priority: android_proprity);
    final iOSPlatformChannelSpecifics = IOSNotificationDetails(
      presentAlert: ios_present_alert,
      presentBadge: ios_present_badge,
      presentSound: ios_present_sound,
      sound: ios_sound,
    );
    final platformChannelSpecifics = NotificationDetails(
      androidPlatformChannelSpecifics,
      iOSPlatformChannelSpecifics,
    );
    return platformChannelSpecifics;
  }

  static Future show(
    BuildContext context, {
    @required String title,
    @required String body,
    String payload,
    int id = 0,
    NotificationDetails notificationDetails,
  }) async {
    FlutterLocalNotificationsPlugin plugin = NotificationProvider.of(context);
    NotificationDetails platformChannelSpecifics = _getSpecifics();
    await plugin.show(
      id,
      title,
      body,
      notificationDetails ?? platformChannelSpecifics,
      payload: payload,
    );
  }

  static Future delete(BuildContext context, int id) {
    FlutterLocalNotificationsPlugin plugin = NotificationProvider.of(context);
    return plugin.cancel(id);
  }

  static Future clear(BuildContext context) {
    FlutterLocalNotificationsPlugin plugin = NotificationProvider.of(context);
    return plugin.cancelAll();
  }

  static Future periodicallyShow(
    BuildContext context,
    int id,
    String title,
    String body,
    RepeatInterval repeatInterval, {
    String payload,
    NotificationDetails notificationDetails,
  }) {
    FlutterLocalNotificationsPlugin plugin = NotificationProvider.of(context);
    NotificationDetails platformChannelSpecifics = _getSpecifics();
    return plugin.periodicallyShow(
      id,
      title,
      body,
      repeatInterval,
      notificationDetails ?? platformChannelSpecifics,
      payload: payload,
    );
  }

  static Future schedule(
    BuildContext context,
    int id,
    String title,
    String body,
    DateTime scheduledDate, {
    String payload,
    NotificationDetails notificationDetails,
  }) {
    FlutterLocalNotificationsPlugin plugin = NotificationProvider.of(context);
    NotificationDetails platformChannelSpecifics = _getSpecifics();
    return plugin.schedule(
      id,
      title,
      body,
      scheduledDate,
      notificationDetails ?? platformChannelSpecifics,
      payload: payload,
    );
  }

  static Future showDailyAtTime(
    BuildContext context,
    int id,
    String title,
    String body,
    Time notificationTime, {
    String payload,
    NotificationDetails notificationDetails,
  }) {
    FlutterLocalNotificationsPlugin plugin = NotificationProvider.of(context);
    NotificationDetails platformChannelSpecifics = _getSpecifics();
    return plugin.showDailyAtTime(
      id,
      title,
      body,
      notificationTime,
      notificationDetails ?? platformChannelSpecifics,
      payload: payload,
    );
  }

  static Future showWeeklyAtDayAndTime(
    BuildContext context,
    int id,
    String title,
    String body,
    Day day,
    Time notificationTime, {
    String payload,
    NotificationDetails notificationDetails,
  }) {
    FlutterLocalNotificationsPlugin plugin = NotificationProvider.of(context);
    NotificationDetails platformChannelSpecifics = _getSpecifics();
    return plugin.showWeeklyAtDayAndTime(
      id,
      title,
      body,
      day,
      notificationTime,
      notificationDetails ?? platformChannelSpecifics,
      payload: payload,
    );
  }

  static Future<NotificationAppLaunchDetails> getNotificationAppLaunchDetails(
      BuildContext context) {
    FlutterLocalNotificationsPlugin plugin = NotificationProvider.of(context);
    return plugin.getNotificationAppLaunchDetails();
  }

  static Future<List<PendingNotificationRequest>> pendingNotificationRequests(
      BuildContext context) {
    FlutterLocalNotificationsPlugin plugin = NotificationProvider.of(context);
    return plugin.pendingNotificationRequests();
  }
}
