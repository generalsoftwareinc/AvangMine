// To parse this JSON data, do
//
//     final relations = relationsFromJson(jsonString);

import 'dart:convert';

Relations relationsFromJson(String str) => Relations.fromJson(json.decode(str));

String relationsToJson(Relations data) => json.encode(data.toJson());

class Relations {
  final List<Relation>? relations;

  Relations({
    this.relations,
  });

  factory Relations.fromJson(Map<String, dynamic> json) => Relations(
        relations: json["relations"] == null
            ? []
            : List<Relation>.from(
                json["relations"]!.map((x) => Relation.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "relations": relations == null
            ? []
            : List<dynamic>.from(relations!.map((x) => x.toJson())),
      };
}

class Relation {
  final int? id;
  final int? issueId;
  final int? issueToId;
  final String? relationType;
  final String? delay;

  Relation({
    this.id,
    this.issueId,
    this.issueToId,
    this.relationType,
    this.delay,
  });

  factory Relation.fromJson(Map<String, dynamic> json) => Relation(
        id: json["id"],
        issueId: json["issue_id"],
        issueToId: json["issue_to_id"],
        relationType: json["relation_type"],
        delay: json["delay"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "issue_id": issueId,
        "issue_to_id": issueToId,
        "relation_type": relationType,
        "delay": delay,
      };
}
