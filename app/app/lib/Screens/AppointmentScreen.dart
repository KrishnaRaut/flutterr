import 'dart:convert';

import 'package:app/ApiServices/appointmentServices.dart';
import 'package:app/Screens/BookingScreen.dart';
import 'package:app/URL/constraints.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AppointmentScreen extends StatefulWidget {
  final String doctoridappointment;

  const AppointmentScreen({required this.doctoridappointment});


  @override
  _AppointmentScreenState createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
  final appointmentnameController = TextEditingController();
  final appointmenttimeController = TextEditingController();
  final appointmentdateController = TextEditingController();
  TimeOfDay selectedTime = TimeOfDay.now();
  String date = "";
  DateTime selectedDate = DateTime.now();

  String appointmentname = "";

  registerAppointment() async {
    try {
      var body = {
        "appointmentname": appointmentname,
        "appointmenttime": selectedTime.toString(),
        "appointmentdate": selectedDate.toString(),
        "doctorid": widget.doctoridappointment,
        "userid":userloginid
      };

      var appointmentservice = await appointmentServices();
      var response = await appointmentservice.addappointment(body);
      print(response);
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
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Image.asset("assets/images/appointment.png",
                      height: 50, width: 60, fit: BoxFit.contain),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 10.0),
                  child: Text("Add appointment Info",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                ),
                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 4, top: 8.0),
                  child: TextFormField(
                    style: const TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                    controller: appointmentnameController,
                    onChanged: (value) {
                      appointmentname = value;
                    },
                    decoration: InputDecoration(
                      hintText: "Enter your full name",
                      hintStyle: const TextStyle(
                          color: Colors.grey),
                      contentPadding: EdgeInsets.all(10.0),
                      enabledBorder: UnderlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide:
                              const BorderSide(color: Colors.black, width: 6)),
                      focusedBorder: UnderlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide:
                              const BorderSide(color: Colors.black, width: 6)),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ElevatedButton(
                      onPressed: () {
                        _selectTime(context);
                      },
                      child: Text("Choose Time"),
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.blue),
                      ),
                    ),
                    Text("${selectedTime.hour}:${selectedTime.minute}"),
                  ],
                )),
                const SizedBox(
                  height: 30,
                ),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      ElevatedButton(
                        onPressed: () {
                          _selectDate(context);
                        },
                        child: Text("Choose Date"),
                        style: ButtonStyle(
                          backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.blue),
                        ),
                      ),
                      Text(
                          "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}")
                    ],
                  ),
                ),
                const SizedBox(
                  height: 180,
                ),
                SizedBox(
                  width: 200,
                  height: 40,
                  child: ElevatedButton(
                      onPressed: () async {
                        var response = await registerAppointment();
                        var res = json.decode(response);

                        if (res["success"] == true) {
                          Fluttertoast.showToast(
                              msg: 'Registered successfully',
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.deepPurple,
                              textColor: Colors.white);
                          Navigator.pop(context);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => BookingScreen()));
                        }
                        if (res["success"] == false) {
                          Fluttertoast.showToast(
                              msg: 'Invalid Appointment',
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.deepPurple,
                              textColor: Colors.white);
                        }
                      },
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.deepPurple),
                      ),
                      child: const Text(
                        "Add Details",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _selectTime(BuildContext context) async {
    final TimeOfDay? timeOfDay = await showTimePicker(
      context: context,
      initialTime: selectedTime,
      initialEntryMode: TimePickerEntryMode.dial,
    );
    if (timeOfDay != null && timeOfDay != selectedTime) {
      setState(() {
        selectedTime = timeOfDay;
        print(selectedTime);
      });
    }
  }

  _selectDate(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2010),
      lastDate: DateTime(2025),
    );
    if (selected != null && selected != selectedDate) {
      setState(() {
        selectedDate = selected;
      });
    }
  }
}
