import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:sipac_mobile_4/core/data/entities/credential.dart';

void main() {
  test('Should return a valid model from json', () {
    // arrange
    final jsonData = {
      "token": "*Asd*",
      "server": "127.0.0.1*",
      "name": "Tester",
      "password": "T12T34"
    };

    // act
    var credential = credentialFromJson(jsonEncode(jsonData));

    // expect
    expect(credential, isA<Credential>());
  });

  test('Should return a valid json from model', () {
    // arrange
    Credential credential = Credential(
        token: "*Asd*",
        server: "127.0.0.1",
        name: "Tester",
        password: "T12T34");

    // act
    var jsonData = jsonDecode(credentialToJson(credential));

    // expect
    expect(jsonData, isA<Map<String, dynamic>>());
  });
}
