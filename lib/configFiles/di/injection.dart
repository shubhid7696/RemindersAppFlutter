import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:reminders_app_flutter/configFiles/di/injection.config.dart';

final getIt = GetIt.instance;

abstract class AppEnv {
  static const dev    = 'DEV';
  static const prod   = 'PROD';
  static const test   = 'TEST';
}

@InjectableInit()
void configureInjection(String environment) => $initGetIt(getIt, environment : environment);



