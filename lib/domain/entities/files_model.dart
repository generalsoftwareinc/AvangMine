// To parse this JSON data, do
//
//     final files = filesFromJson(jsonString);

import 'dart:convert';

Files filesFromJson(String str) => Files.fromJson(json.decode(str));

String filesToJson(Files data) => json.encode(data.toJson());

class Files {
  final List<FileElement>? files;

  Files({this.files});

  factory Files.fromJson(Map<String, dynamic> json) => Files(
        files: json["files"] == null
            ? []
            : List<FileElement>.from(
                json["files"]!.map((x) => FileElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "files": files == null
            ? []
            : List<dynamic>.from(files!.map((x) => x.toJson()))
      };
}

class FileElement {
  final int? id;
  final String? filename;
  final int? filesize;
  final String? contentType;
  final String? description;
  final String? contentUrl;
  final String? author;
  final DateTime? createdOn;
  final String? version;
  final String? digest;
  final int? downloads;

  FileElement({
    this.id,
    this.filename,
    this.filesize,
    this.contentType,
    this.description,
    this.contentUrl,
    this.author,
    this.createdOn,
    this.version,
    this.digest,
    this.downloads,
  });

  factory FileElement.fromJson(Map<String, dynamic> json) => FileElement(
        id: json["id"],
        filename: json["filename"],
        filesize: json["filesize"],
        contentType: json["content_type"],
        description: json["description"],
        contentUrl: json["content_url"],
        author: json["author"],
        createdOn: json["created_on"] == null
            ? null
            : DateTime.parse(json["created_on"]),
        version: json["version"],
        digest: json["digest"],
        downloads: json["downloads"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "filename": filename,
        "filesize": filesize,
        "content_type": contentType,
        "description": description,
        "content_url": contentUrl,
        "author": author,
        "created_on": createdOn?.toIso8601String(),
        "version": version,
        "digest": digest,
        "downloads": downloads,
      };
}
