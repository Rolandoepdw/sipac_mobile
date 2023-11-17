import 'dart:convert';

Strategy strategyFromJson(String str) => Strategy.fromJson(json.decode(str));

String strategyToJson(Strategy data) => json.encode(data.toJson());

class Strategy {
  int strategyId;
  String name;

  Strategy({
    required this.strategyId,
    required this.name,
  });

  factory Strategy.fromJson(Map<String, dynamic> json) => Strategy(
        strategyId: json["strategyId"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "strategyId": strategyId,
        "name": name,
      };

  @override
  String toString() {
    return name;
  }

  @override
  bool operator ==(Object other) =>
      strategyId == (other as Strategy).strategyId;
}
