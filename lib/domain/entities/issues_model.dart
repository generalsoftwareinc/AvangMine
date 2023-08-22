// To parse this JSON data, do
//
//     final issues = issuesFromJson(jsonString);

import 'dart:convert';
import 'assigned_to_model.dart';
import 'author_model.dart';
import 'custom_fields_model.dart';
import 'enumerations_model.dart';
import 'issue_category_model.dart';
import 'issues_status_model.dart';
import 'project_model.dart';
import 'trackers_model.dart';

Issues issuesFromJson(String str) => Issues.fromJson(json.decode(str));

String issuesToJson(Issues data) => json.encode(data.toJson());

class Issues {
  final List<Issue>? issues;
  final int? totalCount;
  final int? offset;
  final int? limit;

  Issues({
    this.issues,
    this.totalCount,
    this.offset,
    this.limit,
  });

  factory Issues.fromJson(Map<String, dynamic> json) => Issues(
        issues: json["issues"] == null
            ? []
            : List<Issue>.from(json["issues"]!.map((x) => Issue.fromJson(x))),
        totalCount: json["total_count"],
        offset: json["offset"],
        limit: json["limit"],
      );

  Map<String, dynamic> toJson() => {
        "issues": issues == null
            ? []
            : List<dynamic>.from(issues!.map((x) => x.toJson())),
        "total_count": totalCount,
        "offset": offset,
        "limit": limit,
      };
}

class IssueOnly {
  final Issue? issue;

  IssueOnly({this.issue});

  factory IssueOnly.fromJson(Map<String, dynamic> json) => IssueOnly(
        issue: json["issue"] == null ? null : Issue.fromJson(json["issue"]),
      );

  Map<String, dynamic> toJson() => {
        "issue": issue?.toJson(),
      };
}

class Issue {
  final int? id;
  final Project? project;
  final Tracker? tracker;
  final IssueStatus? status;
  final IssuePriority? priority;
  final Author? author;
  final IssueCategory? category;
  final AssignedTo? assignedTo;
  final String? subject;
  final String? description;
  final DateTime? startDate;
  final DateTime? dueDate;
  final int? doneRatio;
  final bool? isPrivate;
  final double? estimatedHours;
  final List<CustomField>? customFields;
  final DateTime? createdOn;
  final DateTime? updatedOn;
  final DateTime? closedOn;
  final Issue? parent;

  Issue({
    this.id,
    this.project,
    this.tracker,
    this.status,
    this.priority,
    this.author,
    this.category,
    this.assignedTo,
    this.subject,
    this.description,
    this.startDate,
    this.dueDate,
    this.doneRatio,
    this.isPrivate,
    this.estimatedHours,
    this.customFields,
    this.createdOn,
    this.updatedOn,
    this.closedOn,
    this.parent,
  });

  factory Issue.fromJson(Map<String, dynamic> json) => Issue(
        id: json["id"],
        project:
            json["project"] == null ? null : Project.fromJson(json["project"]),
        tracker:
            json["tracker"] == null ? null : Tracker.fromJson(json["tracker"]),
        status: json["status"] == null
            ? null
            : IssueStatus.fromJson(json["status"]),
        priority: json["priority"] == null
            ? null
            : IssuePriority.fromJson(json["priority"]),
        author: json["author"] == null ? null : Author.fromJson(json["author"]),
        category: json["tracker"] == null
            ? null
            : IssueCategory.fromJson(json["tracker"]),
        assignedTo: json["assigned_to"] == null
            ? null
            : AssignedTo.fromJson(json["assigned_to"]),
        subject: json["subject"],
        description: json["description"],
        startDate: json["start_date"] == null
            ? null
            : DateTime.parse(json["start_date"]),
        dueDate:
            json["due_date"] == null ? null : DateTime.parse(json["due_date"]),
        doneRatio: json["done_ratio"],
        isPrivate: json["is_private"],
        estimatedHours: json["estimated_hours"],
        customFields: json["custom_fields"] == null
            ? []
            : List<CustomField>.from(
                json["custom_fields"]!.map((x) => CustomField.fromJson(x))),
        createdOn: json["created_on"] == null
            ? null
            : DateTime.parse(json["created_on"]),
        updatedOn: json["updated_on"] == null
            ? null
            : DateTime.parse(json["updated_on"]),
        closedOn: json["closed_on"] == null
            ? null
            : DateTime.parse(json["closed_on"]),
        parent: json["parent"] == null ? null : Issue.fromJson(json["parent"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "project": project?.toJson(),
        "tracker": tracker?.toJson(),
        "status": status?.toJson(),
        "priority": priority?.toJson(),
        "author": author?.toJson(),
        "category": category?.toJson(),
        "assigned_to": assignedTo?.toJson(),
        "subject": subject,
        "description": description,
        "start_date": startDate?.toIso8601String(),
        "due_date": dueDate?.toIso8601String(),
        "done_ratio": doneRatio,
        "is_private": isPrivate,
        "estimated_hours": estimatedHours,
        "custom_fields": customFields == null
            ? []
            : List<dynamic>.from(customFields!.map((x) => x.toJson())),
        "created_on": createdOn?.toIso8601String(),
        "updated_on": updatedOn?.toIso8601String(),
        "closed_on": closedOn?.toIso8601String(),
        "parent": parent?.toJson(),
      };
}
