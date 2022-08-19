import 'dart:convert';

import 'package:app/ApiServices/adminServices.dart';
import 'package:app/Screens/AdminSection/AdminDashboard.dart';
import 'package:app/Screens/AdminSection/UpdateDoctorScreen.dart';
import 'package:app/URL/constraints.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DoctorInfo extends StatefulWidget {
  const DoctorInfo({Key? key}) : super(key: key);

  @override
  _DoctorInfoState createState() => _DoctorInfoState();
}

class _DoctorInfoState extends State<DoctorInfo> {
  getdoctorData() async {
    try {
      var adminservice = adminServices();
      var response = await adminservice.getalldoctor();
      return response;
    } catch (e) {
      print(e);
    }
  }

  removedoctordata(String id) async {
    try {
      var adminservice = adminServices();
      var response = await adminservice.removedoctorinfo(id);
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
            width: MediaQuery
                .of(context)
                .size
                .width,
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 10.0, bottom: 10),
                  child: Text("Available Doctors",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                ),
                Expanded(
                  child: FutureBuilder(
                    future: getdoctorData(),
                    builder:
                        (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                      if (snapshot.hasData) {
                        dynamic data = jsonDecode(
                            jsonDecode(snapshot.data.toString()))["data"];
                        return Padding(
                          padding: const EdgeInsets.only(left: 12.0, right: 12),
                          child: SizedBox(
                          
                            width: MediaQuery
                                .of(context)
                                .size
                                .width,
                            child: GridView.builder(
                          gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 200,
                              childAspectRatio: 20 / 20,
                              crossAxisSpacing: 20,
                              mainAxisSpacing: 20),
                            itemCount: data.length,
                            itemBuilder: (BuildContext ctx, index) {
                              return SizedBox(
                                  child: Card(
                                    child: Column(
                                      children: [
                                        Container(
                                          width: 80,
                                          height: 80,
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  image: NetworkImage(
                                                      BASE_URL +
                                                          data[index][
                                                          "doctorimage"]),
                                                  fit: BoxFit.fill)),
                                        ),
                                        Text(
                                          data[index]["doctorname"],
                                          style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(left:15.0, right: 15),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children:  [
                                              IconButton(
                                                  color: Colors.green,
                                                  icon: Icon(Icons.edit),
                                                  onPressed: () async {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (BuildContext
                                                            context) =>
                                                            UpdateDoctorScreen(doctorid: data[index]["_id"],)));
                                                    }


                                              ),
                                              IconButton(
                                                  color: Colors.red,
                                                  icon: Icon(Icons.delete),
                                                  onPressed: () async {
                                                    var response = json.decode(
                                                        await removedoctordata(
                                                            data[index]["_id"]));
                                                    if (response["success"] ==
                                                        true) {
                                                      Fluttertoast.showToast(
                                                          msg: "Doctor info removed",
                                                          toastLength:
                                                          Toast.LENGTH_SHORT,
                                                          gravity:
                                                          ToastGravity.BOTTOM,
                                                          timeInSecForIosWeb: 1,
                                                          backgroundColor:
                                                          Colors.deepPurple,
                                                          textColor: Colors
                                                              .white);
                                                      Navigator.pop(context);
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (
                                                                  BuildContext
                                                                  context) =>
                                                              const AdminDashboard()));
                                                    }

                                                    if (response["success"] ==
                                                        false) {
                                                      print('faef');
                                                      Fluttertoast.showToast(
                                                          msg:
                                                          'Product not removed',
                                                          toastLength:
                                                          Toast.LENGTH_SHORT,
                                                          gravity:
                                                          ToastGravity.BOTTOM,
                                                          timeInSecForIosWeb: 1,
                                                          backgroundColor:
                                                          Colors.deepPurple,
                                                          textColor: Colors
                                                              .white);
                                                    }
                                                  })
                                            ],
                                          ),
                                        ),

                                      ],
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.circular(10.0),
                                    ),
                                    elevation: 10,
                                    margin: EdgeInsets.all(10),
                                  ));
                            })
                          ),
                        );
                      } else {
                        return const Center(
                            child: Text(
                              'No product',
                              textScaleFactor: 3,
                              style: TextStyle(color: Colors.black),
                            ));
                      }
                    },
                  ),
                ),
              ],


            ),
          ),
        ));
  }
}
