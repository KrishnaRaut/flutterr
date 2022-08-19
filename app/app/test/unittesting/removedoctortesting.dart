import 'dart:convert';

import 'package:app/ApiServices/addtocartServices.dart';
import 'package:app/ApiServices/adminServices.dart';

import 'package:flutter_test/flutter_test.dart';

void main() async {
  test("Removedoctor test", () async {
    bool expected = true;
    var adminservice = adminServices();
    var response = await adminservice.removedoctorinfo("621cfc7063a88ec28776b18d");
    var resBody = json.decode(
        response.toString());
    bool received = resBody["success"];
    expect(expected, received);
  });
}