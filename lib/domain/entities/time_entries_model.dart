// To parse this JSON data, do
//
//     final timeEntries = timeEntriesFromJson(jsonString);

import 'dart:convert';
import 'issues_model.dart';

TimeEntries timeEntriesFromJson(String str) =>
    TimeEntries.fromJson(json.decode(str));

String timeEntriesToJson(TimeEntries data) => json.encode(data.toJson());

class TimeEntries {
  final List<TimeEntry>? timeEntries;
  final int? totalCount;
  final int? offset;
  final int? limit;

  TimeEntries({
    this.timeEntries,
    this.totalCount,
    this.offset,
    this.limit,
  });

  factory TimeEntries.fromJson(Map<String, dynamic> json) => TimeEntries(
        timeEntries: json["time_entries"] == null
            ? []
            : List<TimeEntry>.from(
                json["time_entries"]!.map((x) => TimeEntry.fromJson(x))),
        totalCount: json["total_count"],
        offset: json["offset"],
        limit: json["limit"],
      );

  Map<String, dynamic> toJson() => {
        "time_entries": timeEntries == null
            ? []
            : List<dynamic>.from(timeEntries!.map((x) => x.toJson())),
        "total_count": totalCount,
        "offset": offset,
        "limit": limit,
      };
}

class TimeEntry {
  final int? id;
  final Activity? project;
  final Issue? issue;
  final Activity? user;
  final Activity? activity;
  final double? hours;
  final String? comments;
  final DateTime? spentOn;
  final DateTime? createdOn;
  final DateTime? updatedOn;

  TimeEntry({
    this.id,
    this.project,
    this.issue,
    this.user,
    this.activity,
    this.hours,
    this.comments,
    this.spentOn,
    this.createdOn,
    this.updatedOn,
  });

  factory TimeEntry.fromJson(Map<String, dynamic> json) => TimeEntry(
        id: json["id"],
        project:
            json["project"] == null ? null : Activity.fromJson(json["project"]),
        issue: json["issue"] == null ? null : Issue.fromJson(json["issue"]),
        user: json["user"] == null ? null : Activity.fromJson(json["user"]),
        activity: json["activity"] == null
            ? null
            : Activity.fromJson(json["activity"]),
        hours: json["hours"]?.toDouble(),
        comments: json["comments"],
        spentOn:
            json["spent_on"] == null ? null : DateTime.parse(json["spent_on"]),
        createdOn: json["created_on"] == null
            ? null
            : DateTime.parse(json["created_on"]),
        updatedOn: json["updated_on"] == null
            ? null
            : DateTime.parse(json["updated_on"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "project": project?.toJson(),
        "issue": issue?.toJson(),
        "user": user?.toJson(),
        "activity": activity?.toJson(),
        "hours": hours,
        "comments": comments,
        "spent_on":
            "${spentOn!.year.toString().padLeft(4, '0')}-${spentOn!.month.toString().padLeft(2, '0')}-${spentOn!.day.toString().padLeft(2, '0')}",
        "created_on": createdOn?.toIso8601String(),
        "updated_on": updatedOn?.toIso8601String(),
      };
}

class Activity {
  final int? id;
  final String? name;

  Activity({
    this.id,
    this.name,
  });

  factory Activity.fromJson(Map<String, dynamic> json) => Activity(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
