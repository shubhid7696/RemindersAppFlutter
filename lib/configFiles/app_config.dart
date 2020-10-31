// DEV for local, STAGING for staging, PROD for production
import 'dart:io';

enum Environment { DEV, STAGING, PROD }

class AppConfig {
  static Map<String, String> _config;
  static void setEnvironments(Environment env) {
    switch (env) {
      case Environment.DEV:
        _config = _Config.debugConstants;
        break;
      case Environment.PROD:
        _config = _Config.prodConstants;
        break;
      case Environment.STAGING:
        _config = _Config.stagingConstants;
        break;
    }
  }

  static get HTTP_SERVER {
    return _config[_Config.HTTP_SERVER];
  }

  static get PAYMENT_GATEWAY_KEY{
    return _config[_Config.PAYMENT_GATEWAY_KEY];
  }

  static get WHERE_AM_I {
    return _config[_Config.WHERE_AM_I];
  }

  static get isAndroidPlatform {
    return Platform.isAndroid? true: false;
  }
}

class _Config {
  /*
    * HTTP_SERVER used for backend server url,
    * PAYMENT_GATEWAY_KEY used for payment gateway key,
    * WHERE_AM_I used to check in which environment user is
    */
  static const HTTP_SERVER = "HTTP_SERVER";
  static const PAYMENT_GATEWAY_KEY = "PAYMENT_GATEWAY_KEY";
  static const WHERE_AM_I = "WHERE_AM_I";

  // local config
  static Map<String, String> debugConstants = {
    HTTP_SERVER: 'http://52.24.211.200/new/finnity/public/',
    PAYMENT_GATEWAY_KEY: 'rzp_test_1DP5mmOlF5G5ag',
    WHERE_AM_I: 'DEV',
  };

  // production config
  static Map<String, String> prodConstants = {
    HTTP_SERVER: 'https://rest.finitty.in/',
    PAYMENT_GATEWAY_KEY: 'rzp_live_0b53b3nCRmma4U',
    WHERE_AM_I: 'PROD',
  };

  // staging config
  static Map<String, String> stagingConstants = {
    HTTP_SERVER: 'http://52.24.211.200/new/finnity/public/',
    PAYMENT_GATEWAY_KEY: 'rzp_test_1DP5mmOlF5G5ag',
    WHERE_AM_I: 'STAGING',
  };
}