// To parse this JSON data, do
//
//     final projects = projectsFromJson(jsonString);

import 'dart:convert';
import 'custom_fields_model.dart';
import 'issue_category_model.dart';
import 'trackers_model.dart';

Projects projectsFromJson(String str) => Projects.fromJson(json.decode(str));

String projectsToJson(Projects data) => json.encode(data.toJson());

class Projects {
  final List<Project>? projects;
  final int? totalCount;
  final int? offset;
  final int? limit;

  Projects({
    this.projects,
    this.totalCount,
    this.offset,
    this.limit,
  });

  factory Projects.fromJson(Map<String, dynamic> json) => Projects(
        projects: json["projects"] == null
            ? []
            : List<Project>.from(
                json["projects"]!.map((x) => Project.fromJson(x))),
        totalCount: json["total_count"],
        offset: json["offset"],
        limit: json["limit"],
      );

  Map<String, dynamic> toJson() => {
        "projects": projects == null
            ? []
            : List<dynamic>.from(projects!.map((x) => x.toJson())),
        "total_count": totalCount,
        "offset": offset,
        "limit": limit,
      };
}

class ProjectOnly {
  final Project? project;

  ProjectOnly({this.project});

  factory ProjectOnly.fromJson(Map<String, dynamic> json) => ProjectOnly(
        project:
            json["project"] == null ? null : Project.fromJson(json["project"]),
      );

  Map<String, dynamic> toJson() => {
        "project": project?.toJson(),
      };
}

class Project {
  final int id;
  final String? name;
  final String? identifier;
  final String? description;
  final DateTime? createdOn;
  final DateTime? updatedOn;
  final bool? isPublic;
  final String? homepage;
  final int? status;
  final bool? inheritMembers;
  final List<CustomField>? customFields;
  final List<Tracker>? trackers;
  final List<IssueCategory>? issueCategories;
  // Arreglar
  final List<EnabledModule>? timeEntryActivities;
  final List<EnabledModule>? enabledModules;
  final CustomField? parent;

  const Project({
    required this.id,
    this.name,
    this.identifier,
    this.description,
    this.createdOn,
    this.updatedOn,
    this.isPublic,
    this.homepage,
    this.status,
    this.inheritMembers,
    this.customFields,
    this.trackers,
    this.issueCategories,
    this.timeEntryActivities,
    this.enabledModules,
    this.parent,
  });

  factory Project.fromJson(Map<String, dynamic> json) => Project(
      id: json["id"],
      name: json["name"],
      identifier: json["identifier"],
      description: json["description"],
      isPublic: json["is_public"],
      homepage: json["homepage"],
      status: json["status"],
      inheritMembers: json["inherit_members"],
      customFields: json["custom_fields"] == null
          ? []
          : List<CustomField>.from(
              json["custom_fields"]!.map((x) => CustomField.fromJson(x))),
      trackers: json["trackers"] == null
          ? []
          : List<Tracker>.from(
              json["trackers"]!.map((x) => Tracker.fromJson(x))),
      issueCategories: json["issue_categories"] == null
          ? []
          : List<IssueCategory>.from(
              json["issue_categories"]!.map((x) => IssueCategory.fromJson(x))),
      timeEntryActivities: json["issue_categories"] == null
          ? []
          : List<EnabledModule>.from(json["time_entry_activities"]!
              .map((x) => EnabledModule.fromJson(x))),
      enabledModules: json["time_entry_activities"] == null
          ? []
          : List<EnabledModule>.from(
              json["enabled_modules"]!.map((x) => EnabledModule.fromJson(x))),
      createdOn: json["created_on"] == null
          ? null
          : DateTime.parse(json["created_on"]),
      updatedOn: json["updated_on"] == null
          ? null
          : DateTime.parse(json["updated_on"]),
      parent: json["parent"] == null ? null : CustomField.fromJson(json["parent"]));

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "identifier": identifier,
        "description": description,
        "created_on": createdOn?.toIso8601String(),
        "updated_on": updatedOn?.toIso8601String(),
        "is_public": isPublic,
        "homepage": homepage,
        "status": status,
        "inherit_members": inheritMembers,
        "custom_fields": customFields == null
            ? []
            : List<dynamic>.from(customFields!.map((x) => x.toJson())),
        "trackers": trackers == null
            ? []
            : List<dynamic>.from(trackers!.map((x) => x.toJson())),
        "issue_categories": issueCategories == null
            ? []
            : List<dynamic>.from(issueCategories!.map((x) => x)),
        "time_entry_activities": timeEntryActivities == null
            ? []
            : List<dynamic>.from(timeEntryActivities!.map((x) => x.toJson())),
        "enabled_modules": enabledModules == null
            ? []
            : List<dynamic>.from(enabledModules!.map((x) => x.toJson())),
        "parent": parent?.toJson(),
      };
}

class EnabledModule {
  final int? id;
  final String? name;

  EnabledModule({
    this.id,
    this.name,
  });

  factory EnabledModule.fromJson(Map<String, dynamic> json) => EnabledModule(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
