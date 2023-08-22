class Author {
  final int? id;
  final String? name;

  Author({this.id, this.name});

  factory Author.fromJson(Map<String, dynamic> json) =>
      Author(id: json["id"], name: json["name"]);

  Map<String, dynamic> toJson() => {"id": id, "name": name};
}
