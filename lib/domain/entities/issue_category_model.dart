// To parse this JSON data, do
//
//     final issueCategories = issueCategoriesFromJson(jsonString);

import 'dart:convert';
import 'assigned_to_model.dart';
import 'project_model.dart';

IssueCategories issueCategoriesFromJson(String str) =>
    IssueCategories.fromJson(json.decode(str));

String issueCategoriesToJson(IssueCategories data) =>
    json.encode(data.toJson());

class IssueCategories {
  final IssueCategoriesClass? issueCategories;

  IssueCategories({
    this.issueCategories,
  });

  factory IssueCategories.fromJson(Map<String, dynamic> json) =>
      IssueCategories(
        issueCategories: json["issue_categories"] == null
            ? null
            : IssueCategoriesClass.fromJson(json["issue_categories"]),
      );

  Map<String, dynamic> toJson() => {
        "issue_categories": issueCategories?.toJson(),
      };
}

class IssueCategoriesClass {
  final List<IssueCategory>? issueCategory;

  IssueCategoriesClass({
    this.issueCategory,
  });

  factory IssueCategoriesClass.fromJson(Map<String, dynamic> json) =>
      IssueCategoriesClass(
        issueCategory: json["issue_category"] == null
            ? []
            : List<IssueCategory>.from(
                json["issue_category"]!.map((x) => IssueCategory.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "issue_category": issueCategory == null
            ? []
            : List<dynamic>.from(issueCategory!.map((x) => x.toJson())),
      };
}

class IssueCategory {
  final int? id;
  final Project? project;
  final String? name;
  final AssignedTo? assignedTo;

  IssueCategory({
    this.id,
    this.project,
    this.name,
    this.assignedTo,
  });

  factory IssueCategory.fromJson(Map<String, dynamic> json) => IssueCategory(
        id: json["id"],
        project:
            json["project"] == null ? null : Project.fromJson(json["project"]),
        name: json["name"],
        assignedTo: json["assigned_to"] == null
            ? null
            : AssignedTo.fromJson(json["assigned_to"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "project": project?.toJson(),
        "name": name,
        "assigned_to": assignedTo?.toJson(),
      };
}
