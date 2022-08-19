import 'dart:convert';

import 'package:app/ApiServices/addtocartServices.dart';
import 'package:app/ApiServices/adminServices.dart';
import 'package:app/Screens/AddtoCartScreen.dart';
import 'package:app/Screens/HomeScreen.dart';
import 'package:app/URL/constraints.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SingleProductScreen extends StatefulWidget {
  final String productid;

  const SingleProductScreen({required this.productid});

  @override
  _SingleProductScreenState createState() => _SingleProductScreenState();
}

class _SingleProductScreenState extends State<SingleProductScreen> {

  getsingleproduct() async {
    try {
      var adminservice = adminServices();
      var response =
          await adminservice.getsingleproductservice(widget.productid);
      return response;
    } catch (e) {
      print(e);
    }
  }

  addtocart() async {
    try {
      var body = {
        "userid": userloginid,
        "productid": widget.productid,
      };
      var addtocartservice = addtocartServices();
      var response =
      await addtocartservice.addtocartservice(body);
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
          elevation: 0.5,
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
          child: FutureBuilder(
            future: getsingleproduct(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.hasData) {
                dynamic data =
                    jsonDecode(jsonDecode(snapshot.data.toString()))["data"];
                return SizedBox(
                    height: 600,
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        elevation: 15,
                        shadowColor: Colors.blueAccent,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(top: 10.0, bottom: 10),
                              child: Text("Product chosen",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold)),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 15.0, right: 8),
                              child: Container(
                                margin:
                                    const EdgeInsets.symmetric(vertical: 10.0),
                                width: 250,
                                height: 300,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            BASE_URL + data["productimage"]),
                                        fit: BoxFit.fill)),
                              ),
                            ),
                            const SizedBox(height: 30),
                            Text('${data["productname"]}',
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15)),
                            Text('Rs ${data["productprice"]}',
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 15)),
                            const SizedBox(height: 50),
                            IconButton(
                              onPressed: () async {
                                var response = await addtocart();
                                var res = json.decode(response);

                                if (res["success"] == true) {
                                  Fluttertoast.showToast(
                                      msg: 'Product added to your list',
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.deepPurple,
                                      textColor: Colors.white);
                                  Navigator.pop(context);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => HomeScreen()));
                                }
                                if (res["success"] == false) {
                                  Fluttertoast.showToast(
                                      msg: 'Already added in product list',
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.deepPurple,
                                      textColor: Colors.white);
                                }
                              },
                              icon: const Icon(
                                Icons.shopping_cart,
                                color: Colors.blue,
                                size: 40,
                              ),
                            )
                          ],
                        ),
                      ),
                    ));
              } else {
                return const Center(
                    child: Text(
                  'Error',
                  textScaleFactor: 3,
                  style: TextStyle(color: Colors.black),
                ));
              }
            },
          ),
        ));
  }
}
