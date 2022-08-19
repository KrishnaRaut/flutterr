import 'package:app/URL/constraints.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class adminServices {
  Future<dynamic> adddoctor(body) async {
    try {
      print(body);
      var request = http.MultipartRequest('POST', Uri.parse(getadddoctorUrl));
      request.fields['doctorname'] = body["doctorname"];
      request.fields['doctorspeciality'] = body["doctorspeciality"];
      request.fields['doctorhospital'] = body["doctorhospital"];

      request.files.add(
          await http.MultipartFile.fromPath('myfile', body["image"]!.path));

      var response = await request.send();
      final res = await http.Response.fromStream(response);
      return res.body;
    } catch (e) {
      print(e);
    }
  }

  Future<dynamic> addproduct(body) async {
    try {
      print(body);
      var request = http.MultipartRequest('POST', Uri.parse(getaddproductUrl));
      request.fields['productname'] = body["productname"];
      request.fields['productprice'] = body["productprice"];

      request.files.add(
          await http.MultipartFile.fromPath('myfile', body["image"]!.path));
      print(request);

      var response = await request.send();
      final res = await http.Response.fromStream(response);
      return res.body;
    } catch (e) {
      print(e);
    }
  }

  Future<dynamic> getallproduct() async {
    try {
      var res = await http.get(Uri.parse(getallproducturl));
      return json.encode(res.body);
    } catch (e) {
      print(e);
    }
  }

  Future<dynamic> getalldoctor() async {
    try {
      var res = await http.get(Uri.parse(getalldoctorurl));
      return json.encode(res.body);
    } catch (e) {
      print(e);
    }
  }

  Future<dynamic> getsingleproductservice(String id) async {
    try {
      var res = await http.get(Uri.parse(getsingleproducturl+id));
      return json.encode(res.body);
    } catch (e) {
      print(e);
    }
  }
  Future<dynamic> getsingledoctorservice(String id) async {
    try {
      var res = await http.get(Uri.parse(getsingledoctorUrl+id));
      return json.encode(res.body);
    } catch (e) {
      print(e);
    }
  }

  Future<dynamic> removedoctorinfo(String id) async {
    try {
      var res = await http.delete(Uri.parse(getremovedoctorurl+id));
      return res.body;
    } catch (e) {
      print(e);
    }
  }

  Future<dynamic> removeproductinfo(String id) async {
    try {
      var res = await http.delete(Uri.parse(getremoveproducturl+id));
      return res.body;
    } catch (e) {
      print(e);
    }
  }


  Future<dynamic> updatedoctorprofile(String id, body) async {
    try {
      var res =
      await http.put(Uri.parse(geteditdoctorurl+id),
          headers: {
            'Content-Type': 'application/json',
            "Accept": "application/json"
          },
          body: json.encode(body));
      print(res.body);
      return res.body;
    }
    catch (e) {
      print(e);
    }
  }

}
