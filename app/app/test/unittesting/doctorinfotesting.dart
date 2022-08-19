import 'dart:convert';

import 'package:app/ApiServices/adminServices.dart';

import 'package:flutter_test/flutter_test.dart';

void main() async {
  test("Doctor info test", () async {
    bool expected = true;
    var adminservice = adminServices();
    var response = await adminservice.getalldoctor();
    var resBody = jsonDecode(jsonDecode(response.toString()));
    bool received = resBody["success"];
    expect(expected, received);
  });
}
