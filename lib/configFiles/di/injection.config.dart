// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import '../../appScreens/addNoteScreen/add_note_view_model.dart';
import '../network/api_provider.dart';
import '../../appRepository/app_repository.dart';
import '../baseFiles/base_repository.dart';
import '../baseFiles/base_view_model.dart';
import '../network/error_utils.dart';
import '../database/hive_helper.dart';
import '../../appScreens/mainHomeScreen/main_view_model.dart';

/// adds generated dependencies
/// to the provided [GetIt] instance

GetIt $initGetIt(
  GetIt get, {
  String environment,
  EnvironmentFilter environmentFilter,
}) {
  final gh = GetItHelper(get, environment, environmentFilter);
  gh.factory<AddNoteViewModel>(() => AddNoteViewModel());
  gh.factory<AppRepository>(() => AppRepository());
  gh.factory<MainViewModel>(() => MainViewModel(get<AppRepository>()));

  // Eager singletons must be registered in the right order
  gh.singleton<HiveHelper>(HiveHelper());
  gh.singleton<ErrorUtil>(ErrorUtil());
  gh.singleton<ApiProvider>(ApiProvider());
  gh.singleton<BaseRepository>(BaseRepository());
  gh.singleton<BaseViewModel>(BaseViewModel());
  return get;
}
