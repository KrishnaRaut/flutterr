import 'dart:convert';

import 'package:app/ApiServices/adminServices.dart';
import 'package:app/Screens/AppointmentScreen.dart';
import 'package:app/Screens/DashboardScreen.dart';
import 'package:app/URL/constraints.dart';
import 'package:flutter/material.dart';

class DoctorProfileScreen extends StatefulWidget {
  final String doctorid;

  const DoctorProfileScreen({required this.doctorid});

  @override
  _DoctorProfileScreenState createState() => _DoctorProfileScreenState();
}

class _DoctorProfileScreenState extends State<DoctorProfileScreen> {
  getsingleddoctor() async {
    try {
      var adminservice = adminServices();
      var response =
      await adminservice.getsingledoctorservice(widget.doctorid);
      return response;
    } catch (e) {
      print(e);
    }
  }
  final bool disableButton = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Doctor's Profile",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        ),
      ),
      body: getBody(),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 60.0),
        child: FloatingActionButton.extended(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AppointmentScreen(doctoridappointment: widget.doctorid,)),
            );
          },
          label: const Text("Make an appointment"),
          backgroundColor: Colors.deepPurple,
          tooltip: 'Capture Picture',
          elevation: 5,
          splashColor: Colors.grey,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  getBody() {
    return FutureBuilder(
        future: getsingleddoctor(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            dynamic data =
            jsonDecode(jsonDecode(snapshot.data.toString()))["data"];
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text("Patient time 9:00am - 5:00pm",
                    style: TextStyle(fontSize: 13, color: Colors.green)),
                const SizedBox(
                  height: 25,
                ),
                Padding(
                  padding: const EdgeInsets.only(left:20.0, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(data["doctorname"],
                              style:
                                  TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            data["doctorspeciality"],
                            style: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            data["doctorhospital"],
                            style: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.bold),
                          ),

                        ],
                      ),
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.blue, width: 0),
                          // shape: BoxShape.circle,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.1),
                              spreadRadius: 1,
                              blurRadius: 1,
                              offset: Offset(1, 1), // changes position of shadow
                            ),
                          ],
                            image: DecorationImage(
                                image: NetworkImage(BASE_URL +
                                    data["doctorimage"]),
                                fit: BoxFit.cover)),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.star,
                      size: 18,
                      color: Colors.orangeAccent,
                    ),
                    const Icon(
                      Icons.star,
                      size: 18,
                      color: Colors.orangeAccent,
                    ),
                    const Icon(
                      Icons.star,
                      size: 18,
                      color: Colors.orangeAccent,
                    ),
                    const Icon(
                      Icons.star,
                      size: 18,
                      color: Colors.orangeAccent,
                    ),
                    Icon(
                      Icons.star,
                      size: 18,
                      color: Colors.grey.shade300,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Text("4.0 Out of 5.0",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
                SizedBox(
                  height: 3,
                ),
                const Text(
                  "340 Patients review",
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
                const SizedBox(
                  height: 25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: 80,
                      height: 45,
                      decoration: BoxDecoration(
                          color: Colors.blue.withAlpha(30),
                          borderRadius: BorderRadius.circular(30)),
                      child: const Icon(
                        Icons.videocam_rounded,
                        color: Colors.blue,
                        size: 25,
                      ),
                    ),
                    Container(
                      width: 80,
                      height: 45,
                      decoration: BoxDecoration(
                          color: Colors.blue.withAlpha(30),
                          borderRadius: BorderRadius.circular(30)),
                      child: const Icon(
                        Icons.call_end,
                        color: Colors.green,
                        size: 25,
                      ),
                    ),
                    Container(
                      width: 80,
                      height: 45,
                      decoration: BoxDecoration(
                          color: Colors.blue.withAlpha(30),
                          borderRadius: BorderRadius.circular(30)),
                      child: const Icon(
                        Icons.chat_rounded,
                        color: Colors.purple,
                        size: 25,
                      ),
                    ),
                  ],
                ),
                Card(
                  semanticContainer: true,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: Image.asset("assets/images/doctorbooking.jpg",
                      height: 250, width: 300, fit: BoxFit.contain),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  elevation: 5,
                  margin: EdgeInsets.all(10),
                ),
              ],
            );
          } else {
            return const Center(
                child: Text(
                  'Doctor unavailable',
                  textScaleFactor: 3,
                  style: TextStyle(color: Colors.black),
                ));
          }
        });


  }
}
