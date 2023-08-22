// To parse this JSON data, do
//
//     final trackers = trackersFromJson(jsonString);

import 'dart:convert';
import 'issues_status_model.dart';

Trackers trackersFromJson(String str) => Trackers.fromJson(json.decode(str));

String trackersToJson(Trackers data) => json.encode(data.toJson());

class Trackers {
  final List<Tracker>? trackers;

  Trackers({
    this.trackers,
  });

  factory Trackers.fromJson(Map<String, dynamic> json) => Trackers(
        trackers: json["trackers"] == null
            ? []
            : List<Tracker>.from(
                json["trackers"]!.map((x) => Tracker.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "trackers": trackers == null
            ? []
            : List<dynamic>.from(trackers!.map((x) => x.toJson())),
      };
}

class Tracker {
  final int? id;
  final String? name;
  final IssueStatus? defaultStatus;
  final String? description;
  final List<String>? enabledStandardFields;

  Tracker({
    this.id,
    this.name,
    this.defaultStatus,
    this.description,
    this.enabledStandardFields,
  });

  factory Tracker.fromJson(Map<String, dynamic> json) => Tracker(
        id: json["id"],
        name: json["name"],
        defaultStatus: json["default_status"] == null
            ? null
            : IssueStatus.fromJson(json["default_status"]),
        description: json["description"],
        enabledStandardFields: json["enabled_standard_fields"] == null
            ? []
            : List<String>.from(json["enabled_standard_fields"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "default_status": defaultStatus?.toJson(),
        "description": description,
        "enabled_standard_fields": enabledStandardFields == null
            ? []
            : List<dynamic>.from(enabledStandardFields!.map((x) => x)),
      };
}

class EnabledStandardFields {
  final List<String>? field;

  EnabledStandardFields({
    this.field,
  });

  factory EnabledStandardFields.fromJson(Map<String, dynamic> json) =>
      EnabledStandardFields(
        field: json["field"] == null
            ? []
            : List<String>.from(json["field"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "field": field == null ? [] : List<dynamic>.from(field!.map((x) => x)),
      };
}
