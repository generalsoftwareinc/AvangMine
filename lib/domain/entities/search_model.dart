// To parse this JSON data, do
//
//     final search = searchFromJson(jsonString);

import 'dart:convert';

Search searchFromJson(String str) => Search.fromJson(json.decode(str));

String searchToJson(Search data) => json.encode(data.toJson());

class Search {
  final List<Result>? results;
  final int? totalCount;
  final int? offset;
  final int? limit;

  Search({
    this.results,
    this.totalCount,
    this.offset,
    this.limit,
  });

  factory Search.fromJson(Map<String, dynamic> json) => Search(
        results: json["results"] == null
            ? []
            : List<Result>.from(
                json["results"]!.map((x) => Result.fromJson(x))),
        totalCount: json["total_count"],
        offset: json["offset"],
        limit: json["limit"],
      );

  Map<String, dynamic> toJson() => {
        "results": results == null
            ? []
            : List<dynamic>.from(results!.map((x) => x.toJson())),
        "total_count": totalCount,
        "offset": offset,
        "limit": limit,
      };
}

class Result {
  final int? id;
  final String? title;
  final String? type;
  final String? url;
  final String? description;
  final DateTime? datetime;

  Result({
    this.id,
    this.title,
    this.type,
    this.url,
    this.description,
    this.datetime,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        title: json["title"],
        type: json["type"],
        url: json["url"],
        description: json["description"],
        datetime:
            json["datetime"] == null ? null : DateTime.parse(json["datetime"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "type": type,
        "url": url,
        "description": description,
        "datetime": datetime?.toIso8601String(),
      };
}
