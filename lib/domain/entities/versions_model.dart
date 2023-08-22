// To parse this JSON data, do
//
//     final versions = versionsFromJson(jsonString);

import 'dart:convert';

Versions versionsFromJson(String str) => Versions.fromJson(json.decode(str));

String versionsToJson(Versions data) => json.encode(data.toJson());

class Versions {
  final List<Version>? versions;

  Versions({
    this.versions,
  });

  factory Versions.fromJson(Map<String, dynamic> json) => Versions(
        versions: json["versions"] == null
            ? []
            : List<Version>.from(
                json["versions"]!.map((x) => Version.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "versions": versions == null
            ? []
            : List<dynamic>.from(versions!.map((x) => x.toJson())),
      };
}

class Version {
  final int? id;
  final String? project;
  final double? name;
  final String? description;
  final String? status;
  final DateTime? dueDate;
  final String? sharing;
  final DateTime? createdOn;
  final DateTime? updatedOn;
  final String? wikiPageTitle;

  Version({
    this.id,
    this.project,
    this.name,
    this.description,
    this.status,
    this.dueDate,
    this.sharing,
    this.createdOn,
    this.updatedOn,
    this.wikiPageTitle,
  });

  factory Version.fromJson(Map<String, dynamic> json) => Version(
        id: json["id"],
        project: json["project"],
        name: json["name"]?.toDouble(),
        description: json["description"],
        status: json["status"],
        dueDate:
            json["due_date"] == null ? null : DateTime.parse(json["due_date"]),
        sharing: json["sharing"],
        createdOn: json["created_on"] == null
            ? null
            : DateTime.parse(json["created_on"]),
        updatedOn: json["updated_on"] == null
            ? null
            : DateTime.parse(json["updated_on"]),
        wikiPageTitle: json["wiki_page_title"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "project": project,
        "name": name,
        "description": description,
        "status": status,
        "due_date":
            "${dueDate!.year.toString().padLeft(4, '0')}-${dueDate!.month.toString().padLeft(2, '0')}-${dueDate!.day.toString().padLeft(2, '0')}",
        "sharing": sharing,
        "created_on": createdOn?.toIso8601String(),
        "updated_on": updatedOn?.toIso8601String(),
        "wiki_page_title": wikiPageTitle,
      };
}
