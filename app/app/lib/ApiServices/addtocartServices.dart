import 'package:app/URL/constraints.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class addtocartServices {
  Future <dynamic> addtocartservice(body) async {
    try {
      var res =
      await http.post(Uri.parse(addtocarturl),
          headers: {
            'Content-Type': 'application/json',
            "Accept": "application/json"
          },
          body: json.encode(body));
      return res.body;
    }
    catch (e) {
      print(e);
    }
  }


  Future<dynamic> getalladdtocartitems(String id) async {
    try {
      var res = await http.get(Uri.parse(getaddtocartitemsurl+id));
      return json.encode(res.body);
    } catch (e) {
      print(e);
    }
  }

  Future<dynamic> removefromcartitems(String id) async {
    try {
      var res = await http.delete(Uri.parse(getremovefromcarturl+id));
      return res.body;
    } catch (e) {
      print(e);
    }
  }

  Future <dynamic> Detailscheckoutservice(body) async {
    try {
      var res =
      await http.post(Uri.parse(getcheckoutdetailsurl),
          headers: {
            'Content-Type': 'application/json',
            "Accept": "application/json"
          },
          body: json.encode(body));
      return res.body;
    }
    catch (e) {
      print(e);
    }
  }

}
