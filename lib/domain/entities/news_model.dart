// To parse this JSON data, do
//
//     final news = newsFromJson(jsonString);

import 'dart:convert';
import 'attachment_model.dart';
import 'author_model.dart';
import 'project_model.dart';

News newsFromJson(String str) => News.fromJson(json.decode(str));

String newsToJson(News data) => json.encode(data.toJson());

class News {
  final List<NewsElement>? news;
  final int? totalCount;
  final int? offset;
  final int? limit;

  News({
    this.news,
    this.totalCount,
    this.offset,
    this.limit,
  });

  factory News.fromJson(Map<String, dynamic> json) => News(
        news: json["news"] == null
            ? []
            : List<NewsElement>.from(
                json["news"]!.map((x) => NewsElement.fromJson(x))),
        totalCount: json["total_count"],
        offset: json["offset"],
        limit: json["limit"],
      );

  Map<String, dynamic> toJson() => {
        "news": news == null
            ? []
            : List<dynamic>.from(news!.map((x) => x.toJson())),
        "total_count": totalCount,
        "offset": offset,
        "limit": limit,
      };
}

class NewOnly {
  final NewsElement? news;

  NewOnly({this.news});

  factory NewOnly.fromJson(Map<String, dynamic> json) => NewOnly(
        news: json["news"] == null ? null : NewsElement.fromJson(json["news"]),
      );

  Map<String, dynamic> toJson() => {
        "news": news?.toJson(),
      };
}

class NewsElement {
  final int? id;
  final Project? project;
  final Author? author;
  final String? title;
  final String? summary;
  final String? description;
  final DateTime? createdOn;
  final List<Attachment>? attachments;

  NewsElement(
      {this.id,
      this.project,
      this.author,
      this.title,
      this.summary,
      this.description,
      this.createdOn,
      this.attachments});

  factory NewsElement.fromJson(Map<String, dynamic> json) => NewsElement(
        id: json["id"],
        project:
            json["project"] == null ? null : Project.fromJson(json["project"]),
        author: json["author"] == null ? null : Author.fromJson(json["author"]),
        title: json["title"],
        summary: json["summary"],
        description: json["description"],
        createdOn: json["created_on"] == null
            ? null
            : DateTime.parse(json["created_on"]),
        attachments: json["attachments"] == null
            ? []
            : List<Attachment>.from(
                json["attachments"]!.map((x) => Attachment.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "project": project?.toJson(),
        "author": author?.toJson(),
        "title": title,
        "summary": summary,
        "description": description,
        "created_on": createdOn?.toIso8601String(),
        "attachments": attachments == null
            ? []
            : List<dynamic>.from(attachments!.map((x) => x.toJson())),
      };
}
