import 'package:flutter/material.dart';
import 'package:reminders_app_flutter/resources/app_colors.dart';
import 'package:reminders_app_flutter/resources/app_size_config.dart';

Widget primaryButton({GestureTapCallback onPressed, String label, Color btnColor = accentColor}) => RaisedButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizeConfig.pv45),
      ),
      onPressed: onPressed,
      color: btnColor,
      child: Container(
        height: AppSizeConfig.pv45,
        child: Center(
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: AppSizeConfig.font18px,
              color: whiteColor,
              fontFamily: 'Montserrat',
            ),
          ),
        ),
      ),
    );
