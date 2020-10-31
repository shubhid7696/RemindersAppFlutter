// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

ErrorResponse welcomeFromJson(String str) => ErrorResponse.fromJson(json.decode(str));

String welcomeToJson(ErrorResponse data) => json.encode(data.toJson());

class ErrorResponse {
  ErrorResponse({
    this.sucess,
    this.statusCode,
    this.message,
  });

  bool sucess;
  int statusCode;
  String message;

  factory ErrorResponse.fromJson(Map<String, dynamic> json) => ErrorResponse(
    sucess: json["sucess"],
    statusCode: json["statusCode"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "sucess": sucess,
    "statusCode": statusCode,
    "message": message,
  };
}
