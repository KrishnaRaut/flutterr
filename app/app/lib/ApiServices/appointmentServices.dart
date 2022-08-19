import 'package:app/URL/constraints.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class appointmentServices {
  Future <dynamic> addappointment(body) async {
    try {
      var res =
      await http.post(Uri.parse(addtoappointmenturl),
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

  Future<dynamic> getallbookingtems(String id) async {
    try {
      var res = await http.get(Uri.parse(getallappointmenturl+id));
      return json.encode(res.body);
    } catch (e) {
      print(e);
    }
  }

  Future<dynamic> removefromappointment(String id) async {
    try {
      var res = await http.delete(Uri.parse(getremoveappointmenturl+id));
      return res.body;
    } catch (e) {
      print(e);
    }
  }

}
