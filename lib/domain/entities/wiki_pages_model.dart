// To parse this JSON data, do
//
//     final wikiPages = wikiPagesFromJson(jsonString);

import 'dart:convert';
import 'author_model.dart';

WikiPages wikiPagesFromJson(String str) => WikiPages.fromJson(json.decode(str));

String wikiPagesToJson(WikiPages data) => json.encode(data.toJson());

class WikiPages {
  final List<WikiPage>? wikiPages;

  WikiPages({
    this.wikiPages,
  });

  factory WikiPages.fromJson(Map<String, dynamic> json) => WikiPages(
        wikiPages: json["wiki_pages"] == null
            ? []
            : List<WikiPage>.from(
                json["wiki_pages"]!.map((x) => WikiPage.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "wiki_pages": wikiPages == null
            ? []
            : List<dynamic>.from(wikiPages!.map((x) => x.toJson())),
      };
}

class WikiPage {
  final String? title;
  final String? parent;
  final String? text;
  final int? version;
  final Author? author;
  final String? comments;
  final DateTime? createdOn;
  final DateTime? updatedOn;

  WikiPage({
    this.title,
    this.parent,
    this.text,
    this.version,
    this.author,
    this.comments,
    this.createdOn,
    this.updatedOn,
  });

  factory WikiPage.fromJson(Map<String, dynamic> json) => WikiPage(
        title: json["title"],
        parent: json["parent"],
        text: json["text"],
        version: json["version"],
        author: json["author"] == null ? null : Author.fromJson(json["author"]),
        comments: json["comments"],
        createdOn: json["created_on"] == null
            ? null
            : DateTime.parse(json["created_on"]),
        updatedOn: json["updated_on"] == null
            ? null
            : DateTime.parse(json["updated_on"]),
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "parent": parent,
        "text": text,
        "version": version,
        "author": author,
        "comments": comments,
        "created_on": createdOn?.toIso8601String(),
        "updated_on": updatedOn?.toIso8601String(),
      };
}
