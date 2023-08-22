// To parse this JSON data, do
//
//     final queries = queriesFromJson(jsonString);

import 'dart:convert';

Queries queriesFromJson(String str) => Queries.fromJson(json.decode(str));

String queriesToJson(Queries data) => json.encode(data.toJson());

class Queries {
  final List<Query>? queries;

  Queries({
    this.queries,
  });

  factory Queries.fromJson(Map<String, dynamic> json) => Queries(
        queries: json["queries"] == null
            ? []
            : List<Query>.from(json["queries"]!.map((x) => Query.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "queries": queries == null
            ? []
            : List<dynamic>.from(queries!.map((x) => x.toJson())),
      };
}

class Query {
  final int? id;
  final String? name;
  final bool? isPublic;
  final int? projectId;

  Query({
    this.id,
    this.name,
    this.isPublic,
    this.projectId,
  });

  factory Query.fromJson(Map<String, dynamic> json) => Query(
        id: json["id"],
        name: json["name"],
        isPublic: json["is_public"],
        projectId: json["project_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "is_public": isPublic,
        "project_id": projectId,
      };
}
