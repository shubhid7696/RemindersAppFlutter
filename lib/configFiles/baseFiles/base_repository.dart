import 'package:injectable/injectable.dart';
import 'package:reminders_app_flutter/configFiles/di/injection.dart';
import 'package:reminders_app_flutter/configFiles/network/api_provider.dart';


@singleton
class BaseRepository {

  ApiProvider apiProvider = getIt<ApiProvider>();

}