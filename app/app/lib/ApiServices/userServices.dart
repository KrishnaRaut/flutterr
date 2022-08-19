
import 'package:app/URL/constraints.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class userServices {
  Future <dynamic> Register(body) async {
    try {
      var res =
      await http.post(Uri.parse(getregisterUrl),
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
  Future <dynamic> login(body) async {
    try {
      var res =
      await http.post(Uri.parse(getloginUrl),
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

  Future<dynamic> fetchprofile(String id) async {
    try {
      var res = await http.get(Uri.parse(getprofile+id));
      return json.encode(res.body);
    } catch (e) {
      print(e);
    }
  }
}