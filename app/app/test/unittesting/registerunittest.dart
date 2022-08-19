

import 'dart:convert';

import 'package:app/ApiServices/userServices.dart';
import 'package:flutter_test/flutter_test.dart';

void main() async {
  test("User register", () async {
    bool expected = true;

    var userservices = userServices();
    var body = {
      "email": "softwarica@gmail.com",
      "username":"softwarica",
      "password": "softwarica",

    };
    var response = await userservices.Register(body);
    var resBody = json.decode(response.toString());
    bool received = resBody["success"];
    expect(expected, received);
  });
}