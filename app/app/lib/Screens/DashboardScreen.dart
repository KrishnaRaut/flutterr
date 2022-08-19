import 'dart:convert';

import 'package:app/ApiServices/adminServices.dart';
import 'package:app/Screens/Doctor/DoctorScreen.dart';
import 'package:app/Screens/SingleProductScreen.dart';
import 'package:app/URL/constraints.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  getproductData() async {
    try {
      var adminservice = adminServices();
      var response = await adminservice.getallproduct();
      return response;
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                    gradient: const LinearGradient(
                        colors: [
                          Colors.purple,
                          Colors.pinkAccent,
                        ],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        tileMode: TileMode.clamp),
                    borderRadius: BorderRadius.circular(10)),
                padding: const EdgeInsets.all(8),
                margin: const EdgeInsets.all(10),
                width: MediaQuery.of(context).size.width,
                height: 150,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Unicare',
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          'Have a nice day!',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: Colors.white),
                        ),
                        Icon(Icons.tag_faces, color: Colors.white)
                      ],
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
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const DoctorScreen()));
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                            Colors.blue,
                          ),
                        ),
                        child: const Text("Make an appointment",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 15))),
                  ],
                ),
              ),
              Card(
                semanticContainer: true,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: Image.asset("assets/images/dashboard.jpg",
                    height: 300, width: 300, fit: BoxFit.contain),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                elevation: 5,
                margin: EdgeInsets.all(10),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, top: 10),
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  Image.asset("assets/images/product.png",
                      height: 50, width: 50, fit: BoxFit.contain),
                  const Text(
                    "Top Products",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ]),
              ),
              FutureBuilder(
                future: getproductData(),
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                      return Text('Error');
                    case ConnectionState.waiting:
                      return Text('Loading');
                    default:
                      if (snapshot.hasError) {
                        return const Center(
                            child: Text(
                          'No product available',
                          textScaleFactor: 3,
                          style: TextStyle(color: Colors.black),
                        ));
                      } else {
                        dynamic data = jsonDecode(
                            jsonDecode(snapshot.data.toString()))["data"];
                        return Padding(
                          padding: const EdgeInsets.only(left: 12.0, right: 12),
                          child: SizedBox(
                            height: 220,
                            width: MediaQuery.of(context).size.width,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: data.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Card(
                                  elevation: 15,
                                  shadowColor: Colors.blueAccent,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 15.0, right: 8),
                                        child: GestureDetector(
                                          onTap: () => Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    SingleProductScreen(
                                                      productid: data[index]
                                                          ["_id"],
                                                    )),
                                          ),
                                          child: Container(
                                            margin: const EdgeInsets.symmetric(
                                                vertical: 10.0),
                                            width: 150,
                                            height: 150,
                                            decoration: BoxDecoration(
                                                image: DecorationImage(
                                                    image: NetworkImage(
                                                        BASE_URL +
                                                            data[index][
                                                                "productimage"]),
                                                    fit: BoxFit.fill)),
                                          ),
                                        ),
                                      ),
                                      Text('${data[index]["productname"]}',
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 15)),
                                      Text('Rs ${data[index]["productprice"]}',
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 15)),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        );
                      }
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
