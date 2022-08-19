import 'dart:convert';

import 'package:app/ApiServices/userServices.dart';
import 'package:app/URL/constraints.dart';
import 'package:flutter_test/flutter_test.dart';

void main() async {
  test("Profile unit test", () async {
    bool expected = true;
    var userservice = userServices();
    var response = await userservice.fetchprofile(userloginid);
    var resBody = jsonDecode(
        jsonDecode(response.toString()));
    bool received = resBody["success"];
    expect(expected, received);
  });
}