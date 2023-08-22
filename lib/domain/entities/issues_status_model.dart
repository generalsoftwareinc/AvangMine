// To parse this JSON data, do
//
//     final issueStatuses = issueStatusesFromJson(jsonString);

import 'dart:convert';

IssueStatuses issueStatusesFromJson(String str) =>
    IssueStatuses.fromJson(json.decode(str));

String issueStatusesToJson(IssueStatuses data) => json.encode(data.toJson());

class IssueStatuses {
  final List<IssueStatus>? issueStatuses;

  IssueStatuses({
    this.issueStatuses,
  });

  factory IssueStatuses.fromJson(Map<String, dynamic> json) => IssueStatuses(
        issueStatuses: json["issue_statuses"] == null
            ? []
            : List<IssueStatus>.from(
                json["issue_statuses"]!.map((x) => IssueStatus.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "issue_statuses": issueStatuses == null
            ? []
            : List<dynamic>.from(issueStatuses!.map((x) => x.toJson())),
      };
}

class IssueStatus {
  final int id;
  final String? name;
  final bool? isClosed;

  const IssueStatus({
    required this.id,
    this.name,
    this.isClosed,
  });

  factory IssueStatus.fromJson(Map<String, dynamic> json) => IssueStatus(
        id: json["id"],
        name: json["name"],
        isClosed: json["is_closed"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "is_closed": isClosed,
      };
}
