import 'package:injectable/injectable.dart';
import 'package:reminders_app_flutter/configFiles/baseFiles/base_view_model.dart';
import 'package:reminders_app_flutter/configFiles/notification_helper.dart';
import 'package:reminders_app_flutter/constants/app_const.dart';
import 'package:reminders_app_flutter/utils/app_logs.dart';
import '../../appRepository/app_repository.dart';
import '../../main.dart';
import '../../configFiles/network/api_const.dart';

@injectable
class MainViewModel extends BaseViewModel {
  final AppRepository appRepository;

  MainViewModel(this.appRepository);

  get notesList => hiveHelper.hiveBox;

  void deleteReminder(int index, int id) async {
    hiveHelper.hiveBox.deleteAt(index);
    ALog.d("=============NOTE ID==========>", "${id}");
    turnOffNotificationById(flutterLocalNotificationsPlugin,id);
  }

  int _listLength = 0;
  get listLength => _listLength;
  void setListLength(length) {
    _listLength = length;
    notifyListeners();
  }

  void submitReview(int value) {
    var requestParams = {ApiConst.feedback : "${value.toString()}"};

    ALog.d("Api provider", "Api called");
    appRepository.submitReview(requestParams)
        .map((data) => {})
        .doOnError((e, stacktrace) {
          ALog.d("Api provider", "Api provider error");
          errorEventListener.appEvent(API_ERROR, e);
    })
        .doOnListen(() => setLoadingState(true))
        .doOnDone(() => setLoadingState(false))
        .listen((data) {
          errorEventListener.appEvent(REVIEW_SUBMIT_SUCCESS, data);
          ALog.d("Api provider", "Api provider success ${data.toString()}");
    });
  }



}