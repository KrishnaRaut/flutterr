


import 'package:app/Screens/AddtoCartScreen.dart';
import 'package:app/Screens/AdminSection/AddProduct.dart';
import 'package:app/Screens/AdminSection/AdminDashboard.dart';
import 'package:app/Screens/AdminSection/Doctorinfo.dart';
import 'package:app/Screens/Checkoutscreen.dart';
import 'package:app/Screens/DashboardScreen.dart';
import 'package:app/Screens/Doctor/DoctorProfileScreen.dart';
import 'package:app/Screens/HomeScreen.dart';
import 'package:app/Screens/LoginScreen.dart';
import 'package:app/Screens/RegisterScreen.dart';
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';

import 'AppointmentScreen.dart';
import 'BookingScreen.dart';


class SplashHome extends StatefulWidget {
  const SplashHome({Key? key}) : super(key: key);

  @override
  _SplashHomeState createState() => _SplashHomeState();
}

class _SplashHomeState extends State<SplashHome> {

  @override
  Widget build(BuildContext context){

    return Scaffold(
        body:
        Builder(
            builder: (context) {
              return Center(
                  child:
                  SplashScreen(
                      seconds: 3,
                      navigateAfterSeconds: LoginScreen(),
                      image: Image.asset("assets/images/logo.png",
                          height: 200, width: 200, fit: BoxFit.contain),
                      backgroundColor: Colors.white,
                      styleTextUnderTheLoader: new TextStyle(),
                      photoSize: 100.0,
                      loaderColor: Colors.red
                  )
              );
            }
        ));
  }
}
