import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:injectable/injectable.dart';
import 'package:reminders_app_flutter/configFiles/baseFiles/base_view_model.dart';
import 'package:reminders_app_flutter/configFiles/notification_helper.dart';
import 'package:reminders_app_flutter/constants/app_const.dart';
import 'package:reminders_app_flutter/dataModels/note_model.dart';
import 'package:reminders_app_flutter/main.dart';
import 'package:reminders_app_flutter/utils/app_logs.dart';
import 'package:reminders_app_flutter/utils/date_time_util.dart';

@injectable
class AddNoteViewModel extends BaseViewModel {

  // TIME
  String _selectedTime = DateTimeUtil.TIME_FORMAT1;

  String get selectedTime => _selectedTime;

  void setTiming(String time) {
    _selectedTime = time;
    notifyListeners();
  }

  // DATE
  String _selectedDate = DateTimeUtil.DATE_FORMAT1;

  String get selectedDate => _selectedDate;

  void setDate(String date) {
    _selectedDate = date;
    notifyListeners();
  }

  // Repeat Type Selected
  int _repeatTypeSelected = 0;

  int get repeatTypeSelected => _repeatTypeSelected;

  void setRepeatTypeSelected(int type) {
    _repeatTypeSelected = type;
    notifyListeners();
  }


  void addNote(String title, String descr) {
    if (title.isEmpty) {
      errorEventListener.appEvent(SHOW_VALIDATION_MSG, "Please add a title");
      return;
    }
    if (descr.isEmpty) {
      errorEventListener.appEvent(
          SHOW_VALIDATION_MSG, "Please add description");
      return;
    }
    if (_selectedDate == "dd:mm:yyyy") {
      errorEventListener.appEvent(
          SHOW_VALIDATION_MSG, "Please select starting date");
      return;
    }
    if (_selectedTime == "HH:MM") {
      errorEventListener.appEvent(
          SHOW_VALIDATION_MSG, "Please select starting time");
      return;
    }
    if(_repeatTypeSelected == 0 && (DateTimeUtil.timeFromString(_selectedTime,_selectedDate).isBefore(DateTime.now()) || DateTimeUtil.timeFromString(_selectedTime,_selectedDate).isAtSameMomentAs(DateTime.now()))){
      ALog.d("=====================","${DateTime.now().hour}  ${DateTime.now().minute}    ${DateTimeUtil.timeFromString(_selectedTime,_selectedDate).hour}   ${DateTimeUtil.timeFromString(_selectedTime,_selectedDate).minute}");
      errorEventListener.appEvent(
          SHOW_VALIDATION_MSG, "Please select upcoming time");
      return;
    }

    var id = DateTime.now().millisecondsSinceEpoch~/1000;
    var noteModel = NoteModel(
        title, descr, _selectedDate, _selectedTime, _repeatTypeSelected,id);

    var selectedDate = DateTimeUtil.dateFromString(_selectedDate);
    var selectedTime = DateTimeUtil.timeFromString(_selectedTime,_selectedDate);

    ALog.d("===================SELECTED DATE===================>>","${selectedDate.year} ${selectedDate.month} ${selectedDate.day}");
    var notificationTime = new DateTime(
        selectedDate.year, (selectedDate.month), selectedDate.day,
        selectedTime.hour, selectedTime.minute);

    // set simple reminder notification
    if (_repeatTypeSelected == 0) {

      scheduleNotification(
          flutterLocalNotificationsPlugin, id, noteModel, notificationTime)
          .whenComplete(() => {
          // save it locally
          hiveHelper.hiveBox.add(noteModel).whenComplete(() => navEventListener.appEvent(POP_SCR, null))
      });
    } else {
      ALog.d("=====PERIODIC NOTIFICATION====>","NOTIFICATION ${_repeatTypeSelected} ${notificationTime.year}  ${notificationTime.month}  ${notificationTime.day} ${notificationTime.hour} ${notificationTime.minute}");
      schedulePeriodicNotification(
          flutterLocalNotificationsPlugin,
          id,
          noteModel,
          notificationTime,
           _repeatTypeSelected == 1 ? DateTimeComponents.time : (_repeatTypeSelected == 2 ? DateTimeComponents.dayOfWeekAndTime : DateTimeComponents.dayOfWeekAndTime)
      ).whenComplete(() => {
         // save it locally
         hiveHelper.hiveBox.add(noteModel).whenComplete(() => navEventListener.appEvent(POP_SCR, null))
       });
    }
  }


}