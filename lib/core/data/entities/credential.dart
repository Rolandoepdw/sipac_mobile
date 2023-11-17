import 'dart:convert';

Credential credentialFromJson(String str) =>
    Credential._fromJson(json.decode(str));

String credentialToJson(Credential data) => json.encode(data._toJson());

class Credential {
  Credential(
      {required this.token,
      required this.server,
      required this.name,
      required this.password});

  String token;
  String server;
  String name;
  String password;

  factory Credential._fromJson(Map<String, dynamic> json) => Credential(
      token: json["token"],
      server: json['server'],
      name: json["name"],
      password: json["password"]);

  Map<String, dynamic> _toJson() =>
      {"token": token, "server": server, "name": name, "password": password};
}
