// To parse this JSON data, do
//
//     final users = usersFromJson(jsonString);

import 'dart:convert';
import 'custom_fields_model.dart';
import 'groups_model.dart';
import 'memberships_model.dart';
import 'project_model.dart';

Users usersFromJson(String str) => Users.fromJson(json.decode(str));

String usersToJson(Users data) => json.encode(data.toJson());

class Users {
  final User? user;
  final int? totalCount;
  final int? offset;
  final int? limit;

  Users({
    this.user,
    this.totalCount,
    this.offset,
    this.limit,
  });

  factory Users.fromJson(Map<String, dynamic> json) => Users(
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        totalCount: json["total_count"],
        offset: json["offset"],
        limit: json["limit"],
      );

  Map<String, dynamic> toJson() => {
        "user": user?.toJson(),
        "total_count": totalCount,
        "offset": offset,
        "limit": limit,
      };
}

class UserOnly {
  final User? user;

  UserOnly({this.user});

  factory UserOnly.fromJson(Map<String, dynamic> json) => UserOnly(
        user: json["user"] == null ? null : User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "user": user?.toJson(),
      };
}

class User {
  final int? id;
  final String? login;
  final String? firstname;
  final String? lastname;
  final String? mail;
  final DateTime? createdOn;
  final DateTime? updatedOn;
  final DateTime? lastLoginOn;
  final DateTime? passwdChangedOn;
  final String? apiKey;
  final String? avatarUrl;
  final int? status;
  final List<CustomField>? customFields;
  final List<Membership>? memberships;
  final List<Group>? groups;

  const User({
    this.id,
    this.login,
    this.firstname,
    this.lastname,
    this.mail,
    this.createdOn,
    this.updatedOn,
    this.lastLoginOn,
    this.passwdChangedOn,
    this.apiKey,
    this.avatarUrl,
    this.status,
    this.customFields,
    this.memberships,
    this.groups,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        login: json["login"],
        firstname: json["firstname"],
        lastname: json["lastname"],
        mail: json["mail"],
        createdOn: json["created_on"] == null
            ? null
            : DateTime.parse(json["created_on"]),
        updatedOn: json["updated_on"] == null
            ? null
            : DateTime.parse(json["updated_on"]),
        lastLoginOn: json["last_login_on"] == null
            ? null
            : DateTime.parse(json["last_login_on"]),
        passwdChangedOn: json["passwd_changed_on"] == null
            ? null
            : DateTime.parse(json["passwd_changed_on"]),
        apiKey: json["api_key"],
        avatarUrl: json["avatar_url"],
        status: json["status"],
        customFields: json["custom_fields"] == null
            ? []
            : List<CustomField>.from(json["custom_fields"]!.map((x) => x)),
        memberships: json["memberships"] == null
            ? []
            : List<Membership>.from(
                json["memberships"]!.map((x) => Membership.fromJson(x))),
        groups: json["groups"] == null
            ? []
            : List<Group>.from(json["groups"]!.map((x) => Group.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "login": login,
        "firstname": firstname,
        "lastname": lastname,
        "mail": mail,
        "created_on": createdOn?.toIso8601String(),
        "updated_on": updatedOn?.toIso8601String(),
        "last_login_on": lastLoginOn?.toIso8601String(),
        "passwd_changed_on": passwdChangedOn?.toIso8601String(),
        "api_key": apiKey,
        "avatar_url": avatarUrl,
        "status": status,
        "custom_fields": customFields == null
            ? []
            : List<dynamic>.from(customFields!.map((x) => x)),
        "memberships": memberships == null
            ? []
            : List<dynamic>.from(memberships!.map((x) => x.toJson())),
        "groups": groups == null
            ? []
            : List<dynamic>.from(groups!.map((x) => x.toJson())),
      };

  List<Project> getUserProjects() {
    List<Project> aux = [];
    if (memberships != null) {
      for (var e in memberships!) {
        if (e.project != null) {
          aux.add(e.project!);
        }
      }
    }
    return aux;
  }
}
