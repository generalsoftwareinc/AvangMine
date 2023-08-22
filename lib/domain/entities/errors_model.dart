// To parse this JSON data, do
//
//     final errors = errorsFromJson(jsonString);

import 'dart:convert';

Errors errorsFromJson(String str) => Errors.fromJson(json.decode(str));

String errorsToJson(Errors data) => json.encode(data.toJson());

class Errors {
  final List<String>? errors;

  Errors({this.errors});

  factory Errors.fromJson(Map<String, dynamic> json) => Errors(
        errors: json["errors"] == null
            ? []
            : List<String>.from(json["errors"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "errors":
            errors == null ? [] : List<dynamic>.from(errors!.map((x) => x)),
      };
}
