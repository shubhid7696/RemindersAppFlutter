import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:reminders_app_flutter/configFiles/network/api_const.dart';
import 'package:reminders_app_flutter/utils/app_logs.dart';
import 'package:rxdart/rxdart.dart';

/*
@singleton
final dio = Dio()
  ..options = BaseOptions(baseUrl: 'https://api.github.com/', connectTimeout: 30, receiveTimeout: 30)
//  ..interceptors.add(AuthInterceptor())
  ..interceptors.add(LogInterceptor(responseBody: true, requestBody: true));
  */

@singleton
class ApiProvider {

  ApiProvider(){
    initDio();
  }
  final String _endpoint = "https://europe-west1-epap-fg44.cloudfunctions.net/";
  Dio _dio;
  // token can be set at home screen or anywhere else and can be removed when logout.
  static String token = "EDwtpIrpwpRDDuI57d56QPAI28Jb5aO1";

  //  ====  ====  POST PARAMS API    ====
  Future _postQuery(String url, {Map<String, dynamic> queryParams, dynamic bodyParams}) async {
    ALog.d("NETWORK REQUEST ** POST **  ->  ",
        "${_endpoint}${url} \n **  HEADERS  **  ->  ${token} \n **  BODY PARAMS  **  ->  " + queryParams.toString()+"\n **  QUERY PARAMS  **  ->  " + queryParams.toString());
    _dio.options.headers[ApiConst.auth] = "Bearer ${token}";
    // _dio.options.followRedirects = false;
    
    var apiResponse = await _dio.post(_endpoint + url, queryParameters: queryParams, data : bodyParams);
    ALog.d("API RESPONSE ** POST **  ->  ", apiResponse.toString());
    var response = apiResponse.data;
    return response;
  }

  Observable postParamRequest(String url, {Map<String, dynamic> queryParams, dynamic bodyParams}) =>
      Observable.fromFuture(_postQuery(url, queryParams: queryParams, bodyParams : bodyParams)).asBroadcastStream();


  // Interceptor
  dynamic errorInterceptor(DioError dioError) {
    if(dioError.response.statusCode == 302){
      ALog.d("API PROVIDER errorInterceptor","ERROR CODEIS 302");
    }
    if (dioError.message.contains("ERROR_001")) {
      // this will push a new route and remove all the routes that were present
      /*navigatorKey.currentState.pushNamedAndRemoveUntil(
          "/login", (Route<dynamic> route) => false);*/
    }
    return dioError;
  }

  void initDio() {
    _dio = Dio();
    _dio.options.followRedirects = true;
    _dio.options.validateStatus =  (status) {
      return status < 500;
    };
    _dio.interceptors.add(InterceptorsWrapper(
        onRequest:(RequestOptions options) async {
          // Do something before request is sent
          return options; //continue
          // If you want to resolve the request with some custom data，
          // you can return a `Response` object or return `dio.resolve(data)`.
          // If you want to reject the request with a error message,
          // you can return a `DioError` object or return `dio.reject(errMsg)`
        },
        onResponse:(Response response) async {
          // Do something with response data
          ALog.d("========================================","${response.data}, ${response.statusCode}, ${response.statusMessage}");
          return response; // continue
        },
        onError: (DioError e) async {
          // Do something with response error
          /*if(e.response.statusCode == 302){
            e.response.statusCode = 200;
          }*/
          ALog.d("========================================","302 miliya ee oye,  ${e.message},   ${e.response.data}");
          return  e;//continue
        }
    ));
  }
}
