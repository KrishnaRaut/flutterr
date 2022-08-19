import 'dart:convert';

import 'package:app/ApiServices/appointmentServices.dart';
import 'package:app/URL/constraints.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({Key? key}) : super(key: key);

  @override
  _BookingScreenState createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  getappointmentdata() async {
    try {
      var appointmentservice = appointmentServices();
      var response = await appointmentservice.getallbookingtems(userloginid);
      return response;
    } catch (e) {
      print(e);
    }
  }

  removefrombooking(String id) async {
    try {
      var appointmentservice = appointmentServices();
      var response = await appointmentservice.removefromappointment(id);
      return response;
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.blue,
          ),
        ),
      ),
      body: SafeArea(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 5.0, bottom: 10),
                child: Text("Appointment page",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold)),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 300,
                  child: FutureBuilder(
                      future: getappointmentdata(),
                      builder: (BuildContext context,
                          AsyncSnapshot<dynamic> snapshot) {
                        print(snapshot.hasData);
                        if (snapshot.hasData) {
                          dynamic data = jsonDecode(
                              jsonDecode(snapshot.data.toString()))["data"];
                          return GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithMaxCrossAxisExtent(
                                      maxCrossAxisExtent: 200,
                                      childAspectRatio: 20 / 32,
                                      crossAxisSpacing: 20,
                                      mainAxisSpacing: 20),
                              itemCount: data.length,
                              itemBuilder: (BuildContext ctx, index) {
                                return SizedBox(
                                    child: Card(
                                  child: Column(
                                    children: [
                                      Text(
                                        "Appointment no ${index + 1}",
                                        style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black),
                                      ),
                                      Image.asset(
                                          "assets/images/appointment.png",
                                          height: 50,
                                          width: 60,
                                          fit: BoxFit.contain),
                                      Text(
                                        data[index]["appointmentname"],
                                        style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black),
                                      ),
                                      Text(
                                        data[index]["appointmenttime"],
                                        style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black),
                                      ),
                                      Text(
                                        data[index]["appointmentdate"],
                                        style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black),
                                      ),
                                      IconButton(
                                        color: Colors.red,
                                        icon: Icon(
                                          Icons.delete,
                                          size: 40,
                                        ),
                                        onPressed: () async {
                                          var response = json.decode(
                                              await removefrombooking(
                                                  data[index]["_id"]));
                                          print(response);

                                          print(response["success"] == false);
                                          if (response["success"] == true) {
                                            Fluttertoast.showToast(
                                                msg: "Booking removed",
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
                                                    builder: (BuildContext
                                                            context) =>
                                                        const BookingScreen()));
                                          }

                                          if (response["success"] == false) {
                                            print('faef');
                                            Fluttertoast.showToast(
                                                msg: 'Booking removed',
                                                toastLength: Toast.LENGTH_SHORT,
                                                gravity: ToastGravity.BOTTOM,
                                                timeInSecForIosWeb: 1,
                                                backgroundColor:
                                                    Colors.deepPurple,
                                                textColor: Colors.white);
                                          }
                                        },
                                      )
                                    ],
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  elevation: 10,
                                  margin: EdgeInsets.all(10),
                                ));
                              });
                        } else if(snapshot.hasError){
                          return Container(
                            color: Colors.deepPurple,
                            child: const Center(
                                child: Text(
                              'No item added',
                              textScaleFactor: 3,
                              style: TextStyle(color: Colors.deepPurple),
                            )),
                          );
                        }else{
                          return Container(
                            color: Colors.deepPurple,
                            child: const Center(
                                child: Text(
                                  'No item added',
                                  textScaleFactor: 3,
                                  style: TextStyle(color: Colors.deepPurple),
                                )),
                          );
                        }
                      }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
