// To parse this JSON data, do
//
//     final groups = groupsFromJson(jsonString);

import 'dart:convert';
import 'my_account_model.dart';

Groups groupsFromJson(String str) => Groups.fromJson(json.decode(str));

String groupsToJson(Groups data) => json.encode(data.toJson());

class Groups {
  final GroupsClass? groups;

  Groups({this.groups});

  factory Groups.fromJson(Map<String, dynamic> json) => Groups(
      groups:
          json["groups"] == null ? null : GroupsClass.fromJson(json["groups"]));

  Map<String, dynamic> toJson() => {"groups": groups?.toJson()};
}

class GroupsClass {
  final List<Group>? group;

  GroupsClass({this.group});

  factory GroupsClass.fromJson(Map<String, dynamic> json) => GroupsClass(
        group: json["group"] == null
            ? []
            : List<Group>.from(json["group"]!.map((x) => Group.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "group": group == null
            ? []
            : List<dynamic>.from(group!.map((x) => x.toJson())),
      };
}

class Group {
  final int? id;
  final String? name;
  final List<int>? userIds;
  final List<Account>? users;

  Group({
    this.id,
    this.name,
    this.userIds,
    this.users,
  });

  factory Group.fromJson(Map<String, dynamic> json) => Group(
        id: json["id"],
        name: json["name"],
        userIds: json["user_ids"] == null
            ? []
            : List<int>.from(json["user_ids"]!.map((x) => x)),
        users: json["users"] == null
            ? []
            : List<Account>.from(
                json["users"]!.map((x) => Account.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "user_ids":
            userIds == null ? [] : List<dynamic>.from(userIds!.map((x) => x)),
        "users": users == null
            ? []
            : List<dynamic>.from(users!.map((x) => x.toJson())),
      };
}
