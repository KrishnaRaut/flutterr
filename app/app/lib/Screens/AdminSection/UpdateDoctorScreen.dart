import 'dart:convert';

import 'package:app/ApiServices/adminServices.dart';
import 'package:app/Screens/AdminSection/Doctorinfo.dart';
import 'package:app/URL/constraints.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class UpdateDoctorScreen extends StatefulWidget {
  final String doctorid;

  const UpdateDoctorScreen({required this.doctorid});

  @override
  _UpdateDoctorScreenState createState() => _UpdateDoctorScreenState();
}

class _UpdateDoctorScreenState extends State<UpdateDoctorScreen> {
  final doctornameController = TextEditingController();
  final doctorSpecialityController = TextEditingController();
  final doctorhospitalController = TextEditingController();

  String doctorname = "";
  String doctorspeciality = "";
  String doctorhospital = "";

  getsingleddoctor() async {
    try {
      var adminservice = adminServices();
      var response = await adminservice.getsingledoctorservice(widget.doctorid);
      return response;
    } catch (e) {
      print(e);
    }
  }

  updatedoctorData() async {
    try {
      print(doctorname);
      var body = {
        "doctorname": doctorname,
        "doctorspeciality": doctorspeciality,
        "doctorhospital": doctorhospital,
      };

      print(body);

      var adminservice = await adminServices();
      var response =
          await adminservice.updatedoctorprofile(widget.doctorid, body);
      return response;
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Update Doctor Info",
                    style: TextStyle(
                        color: Colors.blue,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
                    const SizedBox(
                      height: 30,
                    ),
                FutureBuilder(
                    future: getsingleddoctor(),
                    builder: (BuildContext context,
                        AsyncSnapshot<dynamic> snapshot) {

                      if (snapshot.hasData){
                        dynamic data = jsonDecode(
                            jsonDecode(snapshot.data.toString()))["data"];
                      doctorname=data["doctorname"];
                      doctorspeciality=data["doctorspeciality"];
                      doctorhospital=data["doctorhospital"];

                      return Column(
                        children: [
                          Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(
                                        BASE_URL + data["doctorimage"]),
                                    fit: BoxFit.fill)),
                          ),
                          TextFormField(
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                            controller: doctornameController,
                            onChanged: (value) {
                              doctorname = value;
                            },
                            decoration: InputDecoration(
                              hintText: data["doctorname"],
                              hintStyle: const TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold),
                              contentPadding: EdgeInsets.all(10.0),
                              prefixIcon: const Icon(
                                Icons.person,
                                color: Colors.blue,
                              ),
                              enabledBorder: UnderlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: const BorderSide(
                                      color: Colors.deepPurple, width: 6)),
                              focusedBorder: UnderlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: const BorderSide(
                                      color: Colors.deepPurple, width: 6)),
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 4, top: 8.0),
                            child: TextFormField(
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                              controller: doctorSpecialityController,
                              onChanged: (value) {
                                doctorspeciality = value;
                              },
                              decoration: InputDecoration(
                                hintText: data["doctorspeciality"],
                                hintStyle: const TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold),
                                contentPadding: EdgeInsets.all(10.0),
                                prefixIcon: const Icon(
                                  Icons.account_circle,
                                  color: Colors.blue,
                                ),
                                enabledBorder: UnderlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: const BorderSide(
                                        color: Colors.deepPurple, width: 6)),
                                focusedBorder: UnderlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: const BorderSide(
                                        color: Colors.deepPurple, width: 6)),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 4, top: 8.0),
                            child: TextFormField(
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                              controller: doctorhospitalController,
                              onChanged: (value) {
                                doctorhospital = value;
                              },
                              decoration: InputDecoration(
                                hintText: data["doctorhospital"],
                                hintStyle: const TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold),
                                contentPadding: EdgeInsets.all(10.0),
                                prefixIcon: const Icon(
                                  Icons.local_hospital,
                                  color: Colors.blue,
                                ),
                                enabledBorder: UnderlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: const BorderSide(
                                        color: Colors.deepPurple, width: 6)),
                                focusedBorder: UnderlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: const BorderSide(
                                        color: Colors.deepPurple, width: 6)),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 80,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                    onPressed: () async {
                                      var response = await updatedoctorData();
                                      var res = json.decode(response);

                                      if (res["success"] == true) {
                                        Fluttertoast.showToast(
                                            msg: 'Info updated successfully',
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.BOTTOM,
                                            timeInSecForIosWeb: 1,
                                            backgroundColor:
                                            Colors.deepPurple,
                                            textColor: Colors.white);
                                        Navigator.pop(context);
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    DoctorInfo()));
                                      }
                                      if (res["success"] == false) {
                                        Fluttertoast.showToast(
                                            msg: 'Invalid update',
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.BOTTOM,
                                            timeInSecForIosWeb: 1,
                                            backgroundColor:
                                            Colors.deepPurple,
                                            textColor: Colors.white);
                                      }
                                    },
                                    style: ButtonStyle(
                                      backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                        Colors.cyan.shade400,
                                      ),
                                      shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                            borderRadius:
                                            BorderRadius.circular(10.0),
                                          )),
                                    ),
                                    child: const Text("Update",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15))),
                              ],
                            ),
                          ),
                        ],
                      );}
                      else return Text("Loading");
                    }),
              ])),
        ),
      ),
    );
  }
}
