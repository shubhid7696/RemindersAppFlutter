import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:reminders_app_flutter/resources/app_colors.dart';
import 'package:reminders_app_flutter/resources/app_size_config.dart';

class AppLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      color: Colors.black.withOpacity(0.7),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              height: AppSizeConfig.pv40,
              width: AppSizeConfig.pv40,
              child: CircularProgressIndicator(
                strokeWidth: AppSizeConfig.pv7,
                valueColor: AlwaysStoppedAnimation<Color>(accentColor),
              ),
            ),
            SizedBox(
              height: AppSizeConfig.pv30,
            ),
            Text(
              "Loading Please Wait...",
              style: TextStyle(
                color: whiteColor,
                fontSize: AppSizeConfig.font22px,
                fontFamily: 'Montserrat',
              ),
            )
          ],
        ),
      ),
    );
  }
}

class AppDivider extends StatelessWidget {
  final double height;

  const AppDivider({this.height = 8.0});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: double.infinity,
      color: Colors.grey.withOpacity(0.5),
    );
  }
}
