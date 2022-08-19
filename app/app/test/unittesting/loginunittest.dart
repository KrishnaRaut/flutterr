import 'dart:convert';

import 'package:app/ApiServices/userServices.dart';
import 'package:flutter_test/flutter_test.dart';

void main() async {
  test("User Login", () async {
    bool expected = true;

    var userservices = userServices();
    var body = {
      "email": "manojpoudell@gmail.com",
      "password": "manoj@1",

    };
    var response = await userservices.login(body);
    var resBody = json.decode(response.toString());
    bool received = resBody["success"];
    expect(expected, received);
  });
}