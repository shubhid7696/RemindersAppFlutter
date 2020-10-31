import 'package:dio/dio.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:reminders_app_flutter/configFiles/database/hive_const.dart';
import 'package:reminders_app_flutter/configFiles/network/error_response.dart';
import 'package:reminders_app_flutter/resources/app_size_config.dart';
import 'package:reminders_app_flutter/utils/app_logs.dart';

import '../app_routes.dart';

@singleton
class ErrorUtil {
  void handleError(BuildContext context, [DioError dioError]) {

    ErrorResponse _errorResponse;

    if(dioError.response != null && dioError.response.data != null) {
      try {
        _errorResponse = ErrorResponse.fromJson(dioError.response.data);
      } catch (e){
        showSnackBar(context, "");
      }
    }

    if (dioError != null) {
      switch (dioError.type) {
        case DioErrorType.CONNECT_TIMEOUT: {
            showSnackBar(context, "Please check your internet connection !");
            break;
          }
        case DioErrorType.RECEIVE_TIMEOUT: {
          showSnackBar(context, "Please check your internet connection !");
          break;
        }
        case DioErrorType.SEND_TIMEOUT: {
          showSnackBar(context, "Please check your internet connection !");
          break;
        }
        case DioErrorType.RESPONSE: {
            if (dioError.response.data != null) {
              ALog.d("ERROR UTIL ", "  ==>>  " + _errorResponse.message);
              handleWithErrorCodes(context, _errorResponse);
            }
            break;
          }
        case DioErrorType.CANCEL: {
            showSnackBar(context, "Request Canceled");
            break;
          }
        case DioErrorType.DEFAULT: {
            showSnackBar(context, "No Internet Connection");
            break;
          }
      }
    } else {
      showSnackBar(context, "");
    }
  }

  void showSnackBar(BuildContext context, String msg) {
    if (msg == null || msg.isEmpty) {
      msg = "Something Went Wrong";
    }
    Flushbar(
      message: msg,
      duration: Duration(seconds: 3),
    )..show(context);
  }

  void showValidationSnackBar(BuildContext context, String message) {
    Flushbar(
      margin: EdgeInsets.all(AppSizeConfig.pv8),
      borderRadius: 8,
      backgroundColor: Colors.red,
      //title:  "Hey Ninja",
      messageText:  Text(message,style: TextStyle(color: Colors.white,fontSize: AppSizeConfig.font16px,
          fontFamily: 'Montserrat')),
      duration:  Duration(seconds: 3),
    )..show(context);
  }

  void showSuccessSnackBar(BuildContext context, String message) {
    Flushbar(
      margin: EdgeInsets.all(AppSizeConfig.pv8),
      borderRadius: 8,
      backgroundColor: Colors.green,
      //title:  "Hey Ninja",
      messageText:  Text(message,style: TextStyle(color: Colors.white,fontSize: AppSizeConfig.font16px,
          fontFamily: 'Montserrat')),
      duration:  Duration(seconds: 3),
    )..show(context);
  }

  void handleWithErrorCodes(BuildContext context, ErrorResponse errorResponse) {
    switch (errorResponse.statusCode) {
      case 400:
        showSnackBar(context, errorResponse.message);
        break;

      case 401:
        showSnackBar(context, errorResponse.message);//"Session timed out"
        _logout(context);
        break;

      case 403:
        showSnackBar(context, errorResponse.message);
        break;

      case 404:
        showSnackBar(context, errorResponse.message);
        break;

      case 500:
        showSnackBar(context, "SERVER ERROR");
        break;

      default:
        showSnackBar(context, "");
        break;

    }
  }

  void _logout(BuildContext context) {
    var hiveBox = Hive.box(HiveConst.remindersBox);
    hiveBox.put(HiveConst.isLoggedIn, false);
    //Navigator.pushNamedAndRemoveUntil(context, AppRoutes.loginRoute, (r) => false);
  }
}
