import 'dart:convert';
import 'package:app/ApiServices/adminServices.dart';
import 'package:flutter_test/flutter_test.dart';

void main() async {
  test("Get single doctor data", () async {
    bool expected = true;
    var adminservice = adminServices();
    var response = await adminservice.getsingledoctorservice("621cfc7063a88ec28776b18d");
    var resBody = jsonDecode(
        jsonDecode(response.toString()));
    bool received = resBody["success"];
    expect(expected, received);
  });
}