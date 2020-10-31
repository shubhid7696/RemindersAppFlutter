import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:reminders_app_flutter/configFiles/database/hive_helper.dart';
import 'package:reminders_app_flutter/configFiles/di/injection.dart';
import 'app_event_listener.dart';

@singleton
class BaseViewModel extends ChangeNotifier {
  AppEventListener errorEventListener;
  AppEventListener navEventListener;

  var hiveHelper = getIt<HiveHelper>();

  //  ====  LOADING STATE ====
  bool _isLoading = false;

  bool get isLoading => _isLoading;
  void setLoadingState(bool isLoading){
    _isLoading = isLoading;
    notifyListeners();
  }

  // store all store related data in this shop box and close it when app closes
  void saveHiveData(String key, dynamic data){
    hiveHelper.saveHiveData(key, data);
      // hiveBox.put(key, data);
  }

  dynamic getHiveData(String key,dynamic defValue ){
    // hiveBox.get(key);
    return hiveHelper.getHiveData(key,defValue);
  }

  // Manage Multiple loading states using array
  int loadValues = 0;
  void setLoadValue(bool isLoading){
    if(isLoading){
      loadValues += 1;
    }else {
      loadValues -= 1;
    }
    if(loadValues > 0){
      setLoadingState(true);
    }else {
      setLoadingState(false);
    }
  }
}

