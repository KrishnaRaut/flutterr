import 'dart:convert';

import 'package:app/ApiServices/userServices.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import 'LoginScreen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  String username = "";
  String email = "";
  String password = "";

  bool isSeen = true;

  registerData() async {
    try {
      var body = {
        "username": username,
        "email": email,
        "password": password,
      };

      var userservice = await userServices();
      var response = await userservice.Register(body);
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
                    const Padding(
                      padding: EdgeInsets.only(top: 20.0),
                      child: Text("Create Account",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Image.asset("assets/images/logo.png",
                          height: 200, width: 200, fit: BoxFit.contain),
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
                                Icons.person,
                                color: Colors.blue,
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text("Username",
                                    style: TextStyle(
                                        color: Colors.blue,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold)),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: TextFormField(
                              style: const TextStyle(
                                  color: Colors.black,
                                  decoration: TextDecoration.none),
                              controller: usernameController,
                              onChanged: (value) {
                                username = value;
                              },
                              decoration: InputDecoration(
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
                          ),
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
                                        fontWeight: FontWeight.bold)),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 4, top: 8.0),
                            child: TextFormField(
                              style: const TextStyle(color: Colors.black),
                              controller: emailController,
                              onChanged: (value) {
                                email = value;
                              },
                              decoration: InputDecoration(
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
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0, left: 8),
                            child: TextFormField(
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
                                    icon: Icon(
                                      isSeen
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color: Colors.blue,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        isSeen = !isSeen;
                                      });
                                    }),
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
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                              onPressed: () async {
                                var response = await registerData();
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
                                          builder: (context) => LoginScreen()));
                                }
                                if (res["success"] == false) {
                                  Fluttertoast.showToast(
                                      msg: 'Invalid registration',
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.deepPurple,
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
                                  borderRadius: BorderRadius.circular(10.0),
                                )),
                              ),
                              child: const Text("Submit",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15))),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        const Text("Already have an account?",
                            style: TextStyle(color: Colors.black)),
                        InkWell(
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginScreen()),
                          ),
                          child: const Text("Login here.",
                              style: TextStyle(
                                color: Colors.red,
                              )),
                        ),
                      ],
                    )
                  ],
                ),
              )),
        ));
  }
}
