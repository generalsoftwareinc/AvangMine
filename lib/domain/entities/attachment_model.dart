// To parse this JSON data, do
//
//     final attachment = attachmentFromJson(jsonString);

import 'dart:convert';
import 'author_model.dart';

Attachment attachmentFromJson(String str) =>
    Attachment.fromJson(json.decode(str));

String attachmentToJson(Attachment data) => json.encode(data.toJson());

class Attachments {
  final Attachment? attachment;

  Attachments({this.attachment});

  factory Attachments.fromJson(Map<String, dynamic> json) => Attachments(
      attachment: json["attachment"] == null
          ? null
          : Attachment.fromJson(json["attachment"]));

  Map<String, dynamic> toJson() => {"attachment": attachment?.toJson()};
}

class Attachment {
  final int? id;
  final String? filename;
  final int? filesize;
  final String? contentType;
  final String? description;
  final String? contentUrl;
  final String? thumbnailUrl;
  final Author? author;
  final DateTime? createdOn;

  Attachment({
    this.id,
    this.filename,
    this.filesize,
    this.contentType,
    this.description,
    this.contentUrl,
    this.thumbnailUrl,
    this.author,
    this.createdOn,
  });

  factory Attachment.fromJson(Map<String, dynamic> json) => Attachment(
        id: json["id"],
        filename: json["filename"],
        filesize: json["filesize"],
        contentType: json["content_type"],
        description: json["description"],
        contentUrl: json["content_url"],
        thumbnailUrl: json["thumbnail_url"],
        author: json["author"] == null ? null : Author.fromJson(json["author"]),
        createdOn: json["created_on"] == null
            ? null
            : DateTime.parse(json["created_on"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "filename": filename,
        "filesize": filesize,
        "content_type": contentType,
        "description": description,
        "content_url": contentUrl,
        "thumbnail_url": thumbnailUrl,
        "author": author?.toJson(),
        "created_on": createdOn?.toIso8601String(),
      };
}
