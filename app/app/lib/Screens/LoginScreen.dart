import 'dart:convert';
import 'dart:math';

import 'package:app/ApiServices/userServices.dart';
import 'package:app/Screens/DashboardScreen.dart';
import 'package:app/Screens/RegisterScreen.dart';
import 'package:app/URL/constraints.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import 'AdminSection/AdminDashboard.dart';
import 'HomeScreen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  String email = "";
  String password = "";

  bool isSeen = true;

  loginData() async {
    try {
      var body = {
        "email": email,
        "password": password,
      };
      var userservice=await userServices();
      var response = await userservice.login(body);
      return response;


    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Container(

              padding: const EdgeInsets.all(20),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Image.asset("assets/images/fair.png",
                          height: 50, width: 60, fit: BoxFit.contain),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 20.0),
                      child: Text("Login Here",
                          style: TextStyle(
                              color: Colors.blue,
                              fontSize: 25,
                              fontWeight: FontWeight.bold)),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Form(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: const [
                              Icon(
                                Icons.email,
                                color: Colors.blue,
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text("Email Address",
                                    style: TextStyle(
                                        color: Colors.blue,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600)),
                              ),
                            ],
                          ),
                          TextFormField(
                            style: const TextStyle(color: Colors.black),
                            controller: emailController,
                            onChanged: (value) {
                              email = value;
                            },

                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(
                                    left: 10.0, right: 5, top: 30, bottom: 10),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: const BorderSide(
                                        color: Colors.blue, width: 1)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: const BorderSide(
                                        color: Colors.blue, width: 1))),
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: const [
                              Icon(
                                Icons.lock,
                                color: Colors.blue,
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text("Password",
                                    style: TextStyle(
                                        color: Colors.blue,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold)),
                              ),
                            ],
                          ),

                         TextFormField(
                              style: TextStyle(color: Colors.black),
                              controller: passwordController,
                              obscureText: isSeen,
                              onChanged: (value) {
                                password = value;
                              },
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.only(
                                    left: 10.0, right: 5, top: 30, bottom: 10),
                                suffixIcon: IconButton(
                                  icon: Icon(isSeen
                                      ? Icons.visibility
                                      : Icons.visibility_off, color: Colors.blue,),
                                  onPressed: () {
                                    setState(() {
                                      isSeen = !isSeen;
                                    });
                                  },
                                  color: Colors.black,
                                ),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: const BorderSide(
                                        color: Colors.blue, width: 1)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: const BorderSide(
                                        color: Colors.blue, width: 1)),
                              ),
                            ),

                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 50,
                            width: 100,
                            child: ElevatedButton(
                                onPressed: () async {
                                  if(email=="admin@gmail.com" && password=="admin"){
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => AdminDashboard()));

                                  }else{
                                    var response = await loginData();
                                    var res = json.decode(response);
                                    userid=res["userId"];

                                    if (res["success"] == true) {
                                      Fluttertoast.showToast(
                                          msg: 'Login Successful',
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.BOTTOM,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: Colors.deepPurple,
                                          textColor: Colors.black);
                                      Navigator.pop(context);
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  HomeScreen()));
                                    }
                                    if(res["success"]==false){
                                      Fluttertoast.showToast(
                                          msg: 'Invalid Login',
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.BOTTOM,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: Colors.deepPurple,
                                          textColor: Colors.white);

                                    }
                                  }

                                },
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                    Colors.cyan.shade400,
                                  ),

                                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10.0),

                                        )
                                    ),
                                ),
                                child: const Text("Login",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18))),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        const Text("Create an account?",
                            style: TextStyle(color: Colors.black)),
                        InkWell(
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const RegisterScreen()),
                          ),
                          child: const Text("Register here",
                              style: TextStyle(
                                color: Colors.red,
                              )),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Image.asset("assets/images/login.png",
                          height: 200, width: 200, fit: BoxFit.contain),
                    ),
                  ],
                ),
              )),
        ));
  }
}
