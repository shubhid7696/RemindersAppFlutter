// To parse this JSON data, do
//
//     final reviewSubmitResponse = reviewSubmitResponseFromJson(jsonString);

import 'dart:convert';

ReviewSubmitResponse reviewSubmitResponseFromJson(String str) => ReviewSubmitResponse.fromJson(json.decode(str));

String reviewSubmitResponseToJson(ReviewSubmitResponse data) => json.encode(data.toJson());

class ReviewSubmitResponse {
  ReviewSubmitResponse({
    this.displayText,
  });

  dynamic displayText;

  factory ReviewSubmitResponse.fromJson(Map<String, dynamic> json) => ReviewSubmitResponse(
    displayText: json["displayText"] == null ? null : json["displayText"],
  );

  Map<String, dynamic> toJson() => {
    "displayText": displayText == null ? null : displayText,
  };
}
