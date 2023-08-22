// To parse this JSON data, do
//
//     final myAccount = myAccountFromJson(jsonString);

import 'dart:convert';
import 'custom_fields_model.dart';
import 'groups_model.dart';
import 'memberships_model.dart';

MyAccount myAccountFromJson(String str) => MyAccount.fromJson(json.decode(str));

String myAccountToJson(MyAccount data) => json.encode(data.toJson());

class MyAccount {
  final Account? myAccount;

  MyAccount({this.myAccount});

  factory MyAccount.fromJson(Map<String, dynamic> json) => MyAccount(
      myAccount: json["user"] == null ? null : Account.fromJson(json["user"]));

  Map<String, dynamic> toJson() => {"user": myAccount?.toJson()};
}

class Account {
  final int? id;
  final String? login;
  final bool? admin;
  final String? firstname;
  final String? lastname;
  final String? mail;
  final DateTime? createdOn;
  final DateTime? lastLoginOn;
  final String? apiKey;
  final List<CustomField>? customFields;
  final List<Membership>? memberships;
  final List<Group>? groups;

  Account({
    this.id,
    this.login,
    this.admin,
    this.firstname,
    this.lastname,
    this.mail,
    this.createdOn,
    this.lastLoginOn,
    this.apiKey,
    this.customFields,
    this.memberships,
    this.groups,
  });

  factory Account.fromJson(Map<String, dynamic> json) => Account(
        id: json["id"],
        login: json["login"],
        admin: json["admin"],
        firstname: json["firstname"],
        lastname: json["lastname"],
        mail: json["mail"],
        createdOn: json["created_on"] == null
            ? null
            : DateTime.parse(json["created_on"]),
        lastLoginOn: json["last_login_on"] == null
            ? null
            : DateTime.parse(json["last_login_on"]),
        apiKey: json["api_key"],
        customFields: json["custom_fields"] == null
            ? []
            : List<CustomField>.from(
                json["custom_fields"]!.map((x) => CustomField.fromJson(x))),
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
        "admin": admin,
        "firstname": firstname,
        "lastname": lastname,
        "mail": mail,
        "created_on": createdOn?.toIso8601String(),
        "last_login_on": lastLoginOn?.toIso8601String(),
        "api_key": apiKey,
        "custom_fields": customFields == null
            ? []
            : List<CustomField>.from(customFields!.map((x) => x.toJson())),
        "memberships": memberships == null
            ? []
            : List<dynamic>.from(memberships!.map((x) => x.toJson())),
        "groups": groups == null
            ? []
            : List<dynamic>.from(groups!.map((x) => x.toJson())),
      };
}
