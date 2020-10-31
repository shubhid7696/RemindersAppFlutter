import 'package:flutter/material.dart';
import 'package:reminders_app_flutter/resources/app_colors.dart';
import 'package:reminders_app_flutter/resources/app_size_config.dart';

// STYLES
TextStyle textInputStyle() => TextStyle(
    color: Colors.black,
    fontSize: AppSizeConfig.font18px,
    fontFamily: 'Montserrat');

// DECORATIONS
BoxDecoration inputFieldBoxDecoration() => BoxDecoration(
    color: transparentGray,
    borderRadius: BorderRadius.all(Radius.circular(AppSizeConfig.pv8)));

InputDecoration inputDecorationField(String hintText,
        [String counterText = "", Color hintColor = mediumGray]) =>
    InputDecoration(
      counterText: counterText,
      hintText: hintText,
      fillColor: hintColor,
      hintStyle: TextStyle(
          color: hintColor,
          fontSize: AppSizeConfig.font18px,
          fontFamily: 'Montserrat'),
      focusColor: whiteColor,
      errorStyle: TextStyle(height: 0, color: Colors.transparent),
      focusedBorder: InputBorder.none,
      enabledBorder: InputBorder.none,
      errorBorder: InputBorder.none,
      disabledBorder: InputBorder.none,
    );
