import 'dart:convert';
import 'dart:math';

import 'package:app/ApiServices/userServices.dart';
import 'package:app/Screens/BookingScreen.dart';
import 'package:app/Screens/LoginScreen.dart';
import 'package:app/URL/constraints.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:shake/shake.dart';
import 'dart:async';
import 'package:proximity_sensor/proximity_sensor.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {


  getprofiledata() async {
    try {
      var userservice = userServices();
      var response = await userservice.fetchprofile(userloginid);
      return response;
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    ShakeDetector detector = ShakeDetector.autoStart(onPhoneShake: () {
      logout();
      // Do stuff on phone shake
    });

    ProximitySensor.events.listen((int event) {
      if (event == 1) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => BookingScreen()));
      }
      ;
    });
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
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "My profile",
                    style: TextStyle(
                        color: Colors.blue,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 20.0),
                  width: 100,
                  height: 100,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: AssetImage("assets/images/user.png"),
                          fit: BoxFit.cover)),
                ),
                FutureBuilder(
                    future: getprofiledata(),
                    builder: (BuildContext context,
                        AsyncSnapshot<dynamic> snapshot) {
                      if (snapshot.hasData) {
                        dynamic data = jsonDecode(
                            jsonDecode(snapshot.data.toString()))["data"];
                        print(data);
                        return Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: Text(data["email"],
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold)),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: Text(data["username"],
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ],
                        );
                      } else {
                        return Container();
                      }
                    }),
                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 20, left: 20.0, right: 20),
                  child: Row(
                    children: const [
                      Icon(
                        Icons.notifications,
                        color: Colors.blue,
                        size: 30,
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      Expanded(
                        child: Text(
                          'Notifications',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.blue,
                      )
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 20, left: 20.0, right: 20),
                  child: Row(
                    children: [
                      Icon(
                        Icons.book_outlined,
                        color: Colors.blue,
                        size: 30,
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const BookingScreen()),
                          ),
                          child: const Text("Bookings",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              )),
                        ),
                      ),
                      const Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.blue,
                      )
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 20, left: 20.0, right: 20),
                  child: Row(
                    children: const [
                      Icon(
                        Icons.wb_sunny,
                        color: Colors.blue,
                        size: 30,
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      Expanded(
                        child: Text(
                          'Apperance',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.blue,
                      )
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 20, left: 20.0, right: 20),
                  child: Row(
                    children: const [
                      Icon(
                        Icons.lock,
                        color: Colors.blue,
                        size: 30,
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      Expanded(
                        child: Text(
                          'Security and Privacy',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.blue,
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 20, left: 20.0, right: 20),
                  child: GestureDetector(
                    onTap: () => Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginScreen())),
                    child: Row(
                      children: [
                        Icon(
                          Icons.logout,
                          color: Colors.blue,
                          size: 30,
                        ),
                        SizedBox(
                          width: 12,
                        ),
                        Expanded(
                            child: TextButton(
                          onPressed: () => logout(),
                          child: Text(
                            "Logout",
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        )),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.blue,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void logout() async {
    // userid="";
    Fluttertoast.showToast(
        msg: 'Logged out!',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.deepPurple,
        textColor: Colors.white);
    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }
}
