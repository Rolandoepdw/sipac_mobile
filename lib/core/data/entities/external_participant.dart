import 'dart:convert';

ExternalParticipant externalParticipantFromJson(String str) =>
    ExternalParticipant.fromJson(json.decode(str));

String externalParticipantToJson(ExternalParticipant data) =>
    json.encode(data.toJson());

class ExternalParticipant {
  int externalParticipantId;
  String name;

  ExternalParticipant({
    required this.externalParticipantId,
    required this.name,
  });

  factory ExternalParticipant.fromJson(Map<String, dynamic> json) =>
      ExternalParticipant(
        externalParticipantId: json["externalParticipantId"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "externalParticipantId": externalParticipantId,
        "name": name,
      };

  @override
  String toString() {
    return name;
  }

  @override
  bool operator ==(Object other) =>
      externalParticipantId ==
      (other as ExternalParticipant).externalParticipantId;
}
