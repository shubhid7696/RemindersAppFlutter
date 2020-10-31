

import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;
import 'package:reminders_app_flutter/dataModels/note_model.dart';
import 'hive_const.dart';

@singleton
class HiveHelper {

  Box hiveBox;

  HiveHelper()  {
    initHiveBox();
  }

  // store all store related data in this shop box and close it when app closes
  void saveHiveData(String key, dynamic data){
    if(hiveBox.isOpen){
      hiveBox.put(key, data);
    }
  }

  dynamic getHiveData(String key, defValue){
    return hiveBox.get(key,defaultValue: defValue);
  }

  void initHiveBox() async{
    final appDocsDir = await pathProvider.getApplicationDocumentsDirectory();
    await Hive.init(appDocsDir.path);
    Hive.registerAdapter(NoteModelAdapter());
    Hive.openBox(HiveConst.remindersBox).whenComplete(() => {
      hiveBox = Hive.box(HiveConst.remindersBox)
    });
  }
}