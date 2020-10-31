import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:reminders_app_flutter/dataModels/note_model.dart';
import 'package:reminders_app_flutter/dataModels/notification/notification_model.dart';
import 'package:reminders_app_flutter/utils/app_logs.dart';
import 'package:rxdart/subjects.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;



final BehaviorSubject<NotificationClass> didReceiveLocalNotificationSubject =
BehaviorSubject<NotificationClass>();

final BehaviorSubject<String> selectNotificationSubject =
BehaviorSubject<String>();

const String scheduleNotificationId = "Ea01";
const String nonScheduleNotificationId = "Ea02";
const String weeklyNotificationId = "Ea03";
const String monthlyNotificationId = "Ea04";

Future<void> initNotifications(
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
  var initializationSettingsAndroid = AndroidInitializationSettings('app_icon');
  var initializationSettingsIOS = IOSInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
      onDidReceiveLocalNotification:
          (int id, String title, String body, String payload) async {
        didReceiveLocalNotificationSubject.add(NotificationClass(
            id: id, title: title, body: body, payload: payload));
      });
  var initializationSettings = InitializationSettings(android : initializationSettingsAndroid, iOS: initializationSettingsIOS);
  configureLocalTimeZone();
  await flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onSelectNotification: (String payload) async {
        if (payload != null) {
          debugPrint('notification payload: ' + payload);
        }
        selectNotificationSubject.add(payload);
      });
}

const methodChannel  = MethodChannel("Android_TimeZone");

Future<void> configureLocalTimeZone() async {
  tz.initializeTimeZones();
  final String timeZoneName = await methodChannel.invokeMethod('checkTimeZOne');
  tz.setLocalLocation(tz.getLocation(timeZoneName));
}

Future<void> showNotification(
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
  var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      '0123', 'EAReminder', 'This here is channel reminder',
      importance: Importance.max, priority: Priority.high, ticker: 'ticker');
  var iOSPlatformChannelSpecifics = IOSNotificationDetails();
  var platformChannelSpecifics = NotificationDetails(
      android : androidPlatformChannelSpecifics, iOS:iOSPlatformChannelSpecifics);
  await flutterLocalNotificationsPlugin.show(
      0, 'Natalia title', 'plain body', platformChannelSpecifics,
      payload: 'item x');
}

Future<void> turnOffNotification(
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
  await flutterLocalNotificationsPlugin.cancelAll();
}

Future<void> turnOffNotificationById(
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
    num id) async {
  await flutterLocalNotificationsPlugin.cancel(id);
}

Future<void> scheduleNotification(
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
    int id,
    NoteModel noteModel,
    DateTime scheduledNotificationDateTime) async {
  var androidPlatformChannelSpecifics = AndroidNotificationDetails(
    nonScheduleNotificationId,
    "Daily Notification",
    "These are the never repeating daily notifications",
    icon: 'app_icon',
  );
  var iOSPlatformChannelSpecifics = IOSNotificationDetails();
  var platformChannelSpecifics = NotificationDetails(
      android:androidPlatformChannelSpecifics, iOS:iOSPlatformChannelSpecifics);
ALog.d("Notification Helper ====>", "${scheduledNotificationDateTime.year}  ${scheduledNotificationDateTime.month}  ${scheduledNotificationDateTime.day} ${scheduledNotificationDateTime.hour}    m0onth ${scheduledNotificationDateTime.minute}");
  await flutterLocalNotificationsPlugin.schedule(id, noteModel.title, noteModel.descr,
      scheduledNotificationDateTime, platformChannelSpecifics);
}

Future<void> scheduleNotificationPeriodically(
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
    int id,
    NoteModel noteModel,
    RepeatInterval interval) async {
  var androidPlatformChannelSpecifics = AndroidNotificationDetails(
    scheduleNotificationId,
    noteModel.title,
    noteModel.descr,
    icon: 'app_icon',
  );
  var iOSPlatformChannelSpecifics = IOSNotificationDetails();
  var platformChannelSpecifics = NotificationDetails(
      android:androidPlatformChannelSpecifics, iOS:iOSPlatformChannelSpecifics);
  await flutterLocalNotificationsPlugin.periodicallyShow(
      noteModel.id, noteModel.title, noteModel.descr, interval, platformChannelSpecifics);
}

void requestIOSPermissions(
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) {
  flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
      IOSFlutterLocalNotificationsPlugin>()
      ?.requestPermissions(
    alert: true,
    badge: true,
    sound: true,
  );
}

Future<void> schedulePeriodicNotification(
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
    int id,
    NoteModel noteModel,
    DateTime dateTime,
    DateTimeComponents interval) async {

  var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      weeklyNotificationId,
      'Weekly Notifications',
      'These are for the scheduled notifications');
  var iOSPlatformChannelSpecifics = IOSNotificationDetails();
  var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics, iOS:iOSPlatformChannelSpecifics);


  var time = tz.TZDateTime(tz.local, dateTime.year, dateTime.month, dateTime.hour, dateTime.minute);

  ALog.d("=+=+=+=+==+=++=+++= ${DateTime.now().year}= ${DateTime.now().month}= ${DateTime.now().day}= ${DateTime.now().hour}","${dateTime.year}  ${dateTime.month}  ${dateTime.day}  ${dateTime.hour}, ${dateTime.minute}  ${tz.local}");

  await flutterLocalNotificationsPlugin.zonedSchedule(
    id,
    noteModel.title,
    noteModel.descr,
    time,
    platformChannelSpecifics,
    androidAllowWhileIdle: true,
    matchDateTimeComponents: interval,);
}
