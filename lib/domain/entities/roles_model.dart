// To parse this JSON data, do
//
//     final roles = rolesFromJson(jsonString);

import 'dart:convert';

Roles rolesFromJson(String str) => Roles.fromJson(json.decode(str));

String rolesToJson(Roles data) => json.encode(data.toJson());

class Roles {
  final List<Role>? roles;

  Roles({
    this.roles,
  });

  factory Roles.fromJson(Map<String, dynamic> json) => Roles(
        roles: json["roles"] == null
            ? []
            : List<Role>.from(json["roles"]!.map((x) => Role.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "roles": roles == null
            ? []
            : List<dynamic>.from(roles!.map((x) => x.toJson())),
      };
}

class Role {
  final int? id;
  final String? name;
  final bool? assignable;
  final String? issuesVisibility;
  final String? timeEntriesVisibility;
  final String? usersVisibility;
  final Permissions? permissions;
  final bool? inherited;

  Role({
    this.id,
    this.name,
    this.assignable,
    this.issuesVisibility,
    this.timeEntriesVisibility,
    this.usersVisibility,
    this.permissions,
    this.inherited,
  });

  factory Role.fromJson(Map<String, dynamic> json) => Role(
        id: json["id"],
        name: json["name"],
        assignable: json["assignable"],
        issuesVisibility: json["issues_visibility"],
        timeEntriesVisibility: json["time_entries_visibility"],
        usersVisibility: json["users_visibility"],
        inherited: json["inherited"],
        permissions: json["permissions"] == null
            ? null
            : Permissions.fromJson(json["permissions"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "assignable": assignable,
        "issues_visibility": issuesVisibility,
        "time_entries_visibility": timeEntriesVisibility,
        "users_visibility": usersVisibility,
        "inherited": inherited,
        "permissions": permissions?.toJson(),
      };
}

class Permissions {
  final List<String>? permission;

  Permissions({
    this.permission,
  });

  factory Permissions.fromJson(Map<String, dynamic> json) => Permissions(
        permission: json["permission"] == null
            ? []
            : List<String>.from(json["permission"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "permission": permission == null
            ? []
            : List<dynamic>.from(permission!.map((x) => x)),
      };
}
