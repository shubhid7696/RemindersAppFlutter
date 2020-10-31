
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:reminders_app_flutter/configFiles/baseFiles/base_repository.dart';
import 'package:reminders_app_flutter/configFiles/network/api_const.dart';

@injectable
class AppRepository extends BaseRepository {

  Observable submitReview(dynamic params) => apiProvider.postParamRequest(ApiConst.reviewPath ,queryParams : params);
}