import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class ALog {
  static void d(String key, String message) {
    if (kDebugMode){
      debugPrint("### "+key + " - " + message);
    }
  }


}
