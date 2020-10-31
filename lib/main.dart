import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:injectable/injectable.dart';
import 'configFiles/app_routes.dart';
import 'configFiles/di/injection.dart';
import 'configFiles/notification_helper.dart';
import 'resources/app_size_config.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
NotificationAppLaunchDetails notificationAppLaunchDetails;

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  configureInjection(Environment.dev);

  notificationAppLaunchDetails = await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
  await initNotifications(flutterLocalNotificationsPlugin);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.);
  @override
  Widget build(BuildContext context) {

    return LayoutBuilder(
      builder: (context, constraints) => OrientationBuilder(builder: (context, orientation) {
        AppSizeConfig().init(constraints);
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.portraitUp,
          DeviceOrientation.portraitDown,
        ]);
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Reminders',
          initialRoute: AppRoutes.splashRoute,
          onGenerateRoute: AppRoutes.generateRoute,
        );
      }),
    );
  }

}