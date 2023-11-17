import 'dart:convert';

InternalLeader internalLeaderFromJson(String str) =>
    InternalLeader.fromJson(json.decode(str));

String internalLeaderToJson(InternalLeader data) => json.encode(data.toJson());

class InternalLeader {
  int internalLeaderId;
  String name;

  InternalLeader({
    required this.internalLeaderId,
    required this.name,
  });

  factory InternalLeader.fromJson(Map<String, dynamic> json) => InternalLeader(
        internalLeaderId: json["internalLeaderId"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "internalLeaderId": internalLeaderId,
        "name": name,
      };

  @override
  String toString() {
    return name;
  }

  @override
  bool operator ==(Object other) =>
      internalLeaderId == (other as InternalLeader).internalLeaderId;
}
