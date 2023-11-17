import 'dart:convert';

Process processFromJson(String str) => Process.fromJson(json.decode(str));

String processToJson(Process data) => json.encode(data.toJson());

class Process {
  int processId;
  String name;

  Process({
    required this.processId,
    required this.name,
  });

  factory Process.fromJson(Map<String, dynamic> json) => Process(
        processId: json["processId"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "processId": processId,
        "name": name,
      };

  @override
  String toString() {
    return name;
  }

  @override
  bool operator ==(Object other) => processId == (other as Process).processId;
}
