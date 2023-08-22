// To parse this JSON data, do
//
//     final issuePriorities = issuePrioritiesFromJson(jsonString);

import 'dart:convert';

IssuePriorities issuePrioritiesFromJson(String str) =>
    IssuePriorities.fromJson(json.decode(str));

String issuePrioritiesToJson(IssuePriorities data) =>
    json.encode(data.toJson());

class IssuePriorities {
  final List<IssuePriority>? issuePriorities;

  IssuePriorities({this.issuePriorities});

  factory IssuePriorities.fromJson(Map<String, dynamic> json) =>
      IssuePriorities(
        issuePriorities: json["issue_priorities"] == null
            ? []
            : List<IssuePriority>.from(json["issue_priorities"]!
                .map((x) => IssuePriority.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "issue_priorities": issuePriorities == null
            ? []
            : List<dynamic>.from(issuePriorities!.map((x) => x.toJson())),
      };
}

class IssuePriority {
  final int? id;
  final String? name;
  final bool? isDefault;

  IssuePriority({
    this.id,
    this.name,
    this.isDefault,
  });

  factory IssuePriority.fromJson(Map<String, dynamic> json) => IssuePriority(
        id: json["id"],
        name: json["name"],
        isDefault: json["is_default"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "is_default": isDefault,
      };
}
