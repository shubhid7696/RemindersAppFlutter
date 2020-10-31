
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:reminders_app_flutter/resources/app_size_config.dart';

abstract class BaseState<T extends StatefulWidget> extends State<T> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }

  void showSnackBar(int type, String message) {
    Flushbar(
      margin: EdgeInsets.all(AppSizeConfig.pv8),
      borderRadius: 8,
      backgroundColor: Colors.red,
      //title:  "Hey Ninja",
      messageText:  Text(message,style: TextStyle(color: Colors.white,fontSize: AppSizeConfig.font16px,
        fontFamily: 'Montserrat',)),
      duration:  Duration(seconds: 3),
    )..show(context);
  }
}
