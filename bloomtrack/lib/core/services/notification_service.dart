import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;

class NotificationService {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static Future<void> init() async {
    tz.initializeTimeZones();
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await _notificationsPlugin.initialize(
      settings: initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) async {},
    );
  }

  static Future<void> scheduleReminder() async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'bloomtrack_reminders',
      'Reminders',
      channelDescription: 'Reminders for logging periods and symptoms',
      importance: Importance.max,
      priority: Priority.high,
    );
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    await _notificationsPlugin.show(
      id: 1,
      title: 'Period Approaching',
      body: 'Your period is approaching in a few days.',
      notificationDetails: platformChannelSpecifics,
      payload: 'reminder',
    );
  }

  static Future<void> scheduleDailyNudge() async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'bloomtrack_daily_nudge',
      'Daily Nudge',
      channelDescription: 'Daily reminders to log symptoms',
      importance: Importance.max,
      priority: Priority.high,
    );
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    await _notificationsPlugin.periodicallyShow(
      id: 2,
      title: 'Daily Logging Nudge',
      body: 'Don\'t forget to log how you\'re feeling today!',
      repeatInterval: RepeatInterval.daily,
      notificationDetails: platformChannelSpecifics,
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
    );
  }

  static Future<void> schedulePillReminder() async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'bloomtrack_pill',
      'Pill Reminder',
      channelDescription: 'Reminder to take your pill',
      importance: Importance.max,
      priority: Priority.high,
    );
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    await _notificationsPlugin.periodicallyShow(
      id: 3,
      title: 'Pill Reminder',
      body: 'Time to take your pill.',
      repeatInterval: RepeatInterval.daily,
      notificationDetails: platformChannelSpecifics,
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
    );
  }

  static Future<void> scheduleSelfExamReminder() async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'bloomtrack_self_exam',
      'Self-exam Reminder',
      channelDescription: 'Weekly self-exam reminder',
      importance: Importance.max,
      priority: Priority.high,
    );
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    // Note: flutter_local_notifications' RepeatInterval has no monthly option,
    // so this fires weekly. The UI copy matches this behaviour.
    await _notificationsPlugin.periodicallyShow(
      id: 4,
      title: 'Self-exam Reminder',
      body: 'It\'s time for your weekly self-exam.',
      repeatInterval: RepeatInterval.weekly,
      notificationDetails: platformChannelSpecifics,
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
    );
  }

  static Future<void> cancelReminder(int id) async {
    await _notificationsPlugin.cancel(id: id);
  }
}
