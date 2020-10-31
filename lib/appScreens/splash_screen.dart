import 'dart:async';
import 'package:flutter/material.dart';
import 'package:reminders_app_flutter/configFiles/app_routes.dart';
import 'package:reminders_app_flutter/resources/app_colors.dart';
import 'package:reminders_app_flutter/resources/app_images.dart';
import 'package:reminders_app_flutter/uiComponents/image_widgets.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  static const int _SPLASH_SCREEN_TIMING = 3000;

  @override
  void initState() {
    Timer(new Duration(milliseconds: _SPLASH_SCREEN_TIMING), () {
      navigateToNextPage();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBackgroundColor,
      body: Stack(
        children: <Widget>[
          Center(
            child: SizedImageWidget(
                ((MediaQuery.of(context).size.height / 100) * 28.11),
                ((MediaQuery.of(context).size.height / 100) * 63.21),
                AppImages.appLogo),
          )
        ],
      ),
    );
  }

  navigateToNextPage(){
    Navigator.pushNamedAndRemoveUntil(
        context, AppRoutes.mainRoute, (r) => false);
  }

}