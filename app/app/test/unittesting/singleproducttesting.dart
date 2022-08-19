import 'dart:convert';
import 'package:app/ApiServices/adminServices.dart';
import 'package:flutter_test/flutter_test.dart';

void main() async {
  test("Get single product data", () async {
    bool expected = true;
    var adminservice = adminServices();
    var response = await adminservice.getsingleproductservice("621ce6e8d249b119d299aa68");
    var resBody = jsonDecode(
        jsonDecode(response.toString()));
    bool received = resBody["success"];
    expect(expected, received);
  });
}