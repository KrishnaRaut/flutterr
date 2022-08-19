import 'dart:convert';

import 'package:app/ApiServices/addtocartServices.dart';

import 'package:flutter_test/flutter_test.dart';

void main() async {
  test("Addtocart", () async {
    bool expected = true;
    var addtocartservice = addtocartServices();
    var body={
      "userid":"620e171d6692867d333df862",
      "productid":"621ce8e8d249b119d299aa87" //vitamin c id
    };
    var response = await addtocartservice.addtocartservice(body);
    var resBody = json.decode(
        response.toString());
    bool received = resBody["success"];
    expect(expected, received);
  });
}