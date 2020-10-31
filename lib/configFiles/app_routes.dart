import 'package:flutter/material.dart';
import 'package:reminders_app_flutter/appScreens/addNoteScreen/add_note_scr.dart';
import 'package:reminders_app_flutter/appScreens/mainHomeScreen/main_screen.dart';
import 'package:reminders_app_flutter/appScreens/splash_screen.dart';

class AppRoutes {

  static const String errorRoute                  = "/errorScr";
  static const String splashRoute                 = "/splashScr";
  static const String mainRoute                   = "/mainScr";
  static const String addNoteRoute                = "/addNoteScr";

  static Route<dynamic> generateRoute(RouteSettings settings) {

    // AppArguments appArgs = settings.arguments;

    switch (settings.name) {
      case splashRoute:
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case mainRoute:
        return MaterialPageRoute(builder: (_) => MainScreen());
      case addNoteRoute:
        return MaterialPageRoute(builder: (_) => AddNoteScreen());

    /*default:
        return MaterialPageRoute(builder: (_) => RoutingErrorScreen());*/
    }
  }
}
