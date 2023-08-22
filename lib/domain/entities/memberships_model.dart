// To parse this JSON data, do
//
//     final memberships = membershipsFromJson(jsonString);

import 'dart:convert';
import 'my_account_model.dart';
import 'project_model.dart';
import 'roles_model.dart';

Memberships membershipsFromJson(String str) =>
    Memberships.fromJson(json.decode(str));

String membershipsToJson(Memberships data) => json.encode(data.toJson());

class Memberships {
  final List<Membership>? memberships;
  final int? totalCount;
  final int? offset;
  final int? limit;

  Memberships({
    this.memberships,
    this.totalCount,
    this.offset,
    this.limit,
  });

  factory Memberships.fromJson(Map<String, dynamic> json) => Memberships(
        memberships: json["memberships"] == null
            ? []
            : List<Membership>.from(
                json["memberships"]!.map((x) => Membership.fromJson(x))),
        totalCount: json["total_count"],
        offset: json["offset"],
        limit: json["limit"],
      );

  Map<String, dynamic> toJson() => {
        "memberships": memberships == null
            ? []
            : List<dynamic>.from(memberships!.map((x) => x.toJson())),
        "total_count": totalCount,
        "offset": offset,
        "limit": limit,
      };
}

class Membership {
  final int? id;
  final Project? project;
  final Account? user;
  final List<Role>? roles;

  Membership({
    this.id,
    this.project,
    this.user,
    this.roles,
  });

  factory Membership.fromJson(Map<String, dynamic> json) => Membership(
        id: json["id"],
        project:
            json["project"] == null ? null : Project.fromJson(json["project"]),
        user: json["user"] == null ? null : Account.fromJson(json["user"]),
        roles: json["roles"] == null
            ? []
            : List<Role>.from(json["roles"]!.map((x) => Role.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "project": project?.toJson(),
        "user": user?.toJson(),
        "roles":
            roles == null ? [] : List<Role>.from(roles!.map((x) => x.toJson())),
      };
}
