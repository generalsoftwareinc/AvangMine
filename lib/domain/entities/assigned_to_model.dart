class AssignedTo {
  final int? id;
  final String? name;

  AssignedTo({this.id, this.name});

  factory AssignedTo.fromJson(Map<String, dynamic> json) =>
      AssignedTo(id: json["id"], name: json["name"]);

  Map<String, dynamic> toJson() => {"id": id, "name": name};
}
