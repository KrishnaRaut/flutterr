import 'dart:convert';

import 'package:app/ApiServices/addtocartServices.dart';

import 'package:flutter_test/flutter_test.dart';

void main() async {
  test("Removefromcart", () async {
    bool expected = true;
    var addtocartservice = addtocartServices();
    var response = await addtocartservice.removefromcartitems("620c949bafbfc061e84c1cab");
    var resBody = json.decode(
        response.toString());
    bool received = resBody["success"];
    expect(expected, received);
  });
}