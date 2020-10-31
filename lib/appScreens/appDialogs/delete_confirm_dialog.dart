

import 'package:flutter/material.dart';
import 'package:reminders_app_flutter/resources/app_colors.dart';
import 'package:reminders_app_flutter/resources/app_images.dart';
import 'package:reminders_app_flutter/resources/app_size_config.dart';
import 'package:reminders_app_flutter/uiComponents/button_widgets.dart';
import 'package:reminders_app_flutter/uiComponents/image_widgets.dart';

class DeleteConfirmationDialog extends StatefulWidget {
  final Function fun;
  DeleteConfirmationDialog(this.fun);

  @override
  _DeleteConfirmationDialogState createState() => _DeleteConfirmationDialogState();
}

class _DeleteConfirmationDialogState extends State<DeleteConfirmationDialog> {

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        padding: EdgeInsets.only(left: AppSizeConfig.pv20,right: AppSizeConfig.pv20),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(AppSizeConfig.pv12)
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(
              height: AppSizeConfig.pv24,
            ),
            SizedImageWidget(AppSizeConfig.pv40,AppSizeConfig.pv40, AppImages.deleteIcon),
            SizedBox(
              height: AppSizeConfig.pv24,
            ),
            Text("Sure you want to delete ?",style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: AppSizeConfig.pv16,
              fontFamily: 'Montserrat',
            ),),
            SizedBox(
              height: AppSizeConfig.pv24,
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Expanded(
                  child: primaryButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    label: "No",
                    btnColor: accentColor,
                  ),
                ),
                SizedBox(width: AppSizeConfig.pv20,),
                Expanded(
                  child: primaryButton(
                    onPressed: () {
                      widget.fun();
                    },
                    label: "Yes",
                    btnColor: primaryColor,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: AppSizeConfig.pv24,
            ),
          ],
        ),
      ),);
  }
}