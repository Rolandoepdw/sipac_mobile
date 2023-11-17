import 'dart:convert';

Objective objectiveFromJson(String str) => Objective.fromJson(json.decode(str));

String objectiveToJson(Objective data) => json.encode(data.toJson());

class Objective {
  int objectiveId;
  String name;

  Objective({
    required this.objectiveId,
    required this.name,
  });

  factory Objective.fromJson(Map<String, dynamic> json) => Objective(
        objectiveId: json["objectiveId"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "objectiveId": objectiveId,
        "name": name,
      };

  @override
  String toString() {
    return name;
  }

  @override
  bool operator ==(Object other) =>
      objectiveId == (other as Objective).objectiveId;
}
