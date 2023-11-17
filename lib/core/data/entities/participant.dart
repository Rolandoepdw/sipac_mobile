import 'dart:convert';

Participant participantFromJson(String str) =>
    Participant.fromJson(json.decode(str));

String participantToJson(Participant data) => json.encode(data.toJson());

class Participant {
  int participantId;
  String name;

  Participant({
    required this.participantId,
    required this.name,
  });

  factory Participant.fromJson(Map<String, dynamic> json) => Participant(
        participantId: json["participantId"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "participantId": participantId,
        "name": name,
      };

  @override
  String toString() {
    return name;
  }

  @override
  bool operator ==(Object other) =>
      participantId == (other as Participant).participantId;
}
