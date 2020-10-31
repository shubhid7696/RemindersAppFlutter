
import 'package:flutter/material.dart';
import 'package:reminders_app_flutter/resources/app_colors.dart';
import 'package:reminders_app_flutter/resources/app_images.dart';
import 'package:reminders_app_flutter/resources/app_size_config.dart';
import 'package:reminders_app_flutter/uiComponents/button_widgets.dart';
import 'package:reminders_app_flutter/uiComponents/image_widgets.dart';
import 'package:reminders_app_flutter/utils/app_logs.dart';

class RateUsDialog extends StatefulWidget {
  final Function fun;
  RateUsDialog(this.fun);

  @override
  _RateUsDialogState createState() => _RateUsDialogState();
}

class _RateUsDialogState extends State<RateUsDialog> {

  double rangeValue = 0.0;
  String rateImage = AppImages.appLogo;

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
            SizedImageWidget(AppSizeConfig.pv40,AppSizeConfig.pv40, rateImage),
            SizedBox(
              height: AppSizeConfig.pv24,
            ),
            Text("Please give us your feedback !",style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: AppSizeConfig.pv16,
              fontFamily: 'Montserrat',
            ),),
            SizedBox(
              height: AppSizeConfig.pv24,
            ),
            Column(
              children: <Widget>[
                Center(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: AppSizeConfig.pv12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        SizedImageWidget(AppSizeConfig.pv24,AppSizeConfig.pv24,AppImages.angry),
                        SizedImageWidget(AppSizeConfig.pv24,AppSizeConfig.pv24,AppImages.sad),
                        SizedImageWidget(AppSizeConfig.pv24,AppSizeConfig.pv24,AppImages.normal),
                        SizedImageWidget(AppSizeConfig.pv24,AppSizeConfig.pv24,AppImages.happy),
                        SizedImageWidget(AppSizeConfig.pv24,AppSizeConfig.pv24,AppImages.awesome),
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: AppSizeConfig.pv4,right: AppSizeConfig.pv2),
                  child: Slider(
                    min: 0.0,
                    max: 10.0,
                    divisions: 4,
                    value: rangeValue,
                    onChanged: (v)=>
                      setState(() {
                        rangeValue = v;
                        ALog.d("++++++++++", "${v}");
                        switch(v.toInt()){
                          case 0:
                            rateImage = AppImages.angry;
                            break;
                          case 2:
                            rateImage = AppImages.sad;
                            break;
                          case 5:
                            rateImage = AppImages.normal;
                            break;
                          case 7:
                            rateImage = AppImages.happy;
                            break;
                          case 10:
                            rateImage = AppImages.awesome;
                            break;
                        }
                      })
                    ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: primaryButton(
                    onPressed: () {
                      widget.fun(rangeValue.toInt());
                    },
                    label: "Submit",
                    btnColor: accentColor,
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