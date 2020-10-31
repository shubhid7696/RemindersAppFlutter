import 'package:flutter/material.dart';
import 'package:reminders_app_flutter/resources/app_colors.dart';
import 'package:reminders_app_flutter/resources/app_size_config.dart';


Widget noteLabelText(String labelText) {
  return Text(
    labelText,
    style: TextStyle(
        fontSize: AppSizeConfig.font16px,
        color: primaryColor,
        fontFamily: 'Montserrat',
        fontWeight: FontWeight.w500),
  );
}