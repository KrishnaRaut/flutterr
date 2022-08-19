import 'dart:convert';

import 'package:app/ApiServices/adminServices.dart';

import 'package:flutter_test/flutter_test.dart';


//this is dashboard info test

void main() async {
  test("Dashboard info test", () async {
    bool expected = true;
    var adminservice = adminServices();
    var response = await adminservice.getallproduct();
    var resBody = jsonDecode(
        jsonDecode(response.toString()));
    bool received = resBody["success"];
    expect(expected, received);
  });
}