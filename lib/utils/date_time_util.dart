
import 'package:intl/intl.dart';

class DateTimeUtil {
  static const DATE_FORMAT1 = "dd/MM/yyyy";
  static const TIME_FORMAT1 = "hh:mm a";

  static DateTime dateFromString(String date) => DateFormat(DATE_FORMAT1).parse(date);

  static DateTime timeFromString(String time, String date) {
    var d1 = DateFormat(TIME_FORMAT1).parse(time);
    var d2 = DateFormat(DATE_FORMAT1).parse(date);

    return DateTime(d2.year,d2.month,d2.day,d1.hour,d1.minute,d1.second);
  }
  
  static String timeId() => DateFormat("yyyyddMMhhmmss").format(DateTime.now());

  /*static bool validTime(DateTime inputTime) {
    var currTime = DateTime.now();
    return
  }*/
}

//string to date time
// DateTime tempDate = new DateFormat("yyyy-MM-dd hh:mm:ss").parse(savedDateString);


//date time to string
// String date = DateFormat("yyyy-MM-dd hh:mm:ss").format(DateTime.now());
