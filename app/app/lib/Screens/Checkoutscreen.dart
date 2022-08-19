import 'dart:convert';

import 'package:app/ApiServices/addtocartServices.dart';
import 'package:app/ApiServices/adminServices.dart';
import 'package:app/Screens/AddtocartInfoScreen.dart';
import 'package:app/Screens/HomeScreen.dart';
import 'package:app/URL/constraints.dart';
import 'package:flutter/material.dart';

class Checkoutscreen extends StatefulWidget {
  final int productprice;

  const Checkoutscreen({required this.productprice});

  @override
  _CheckoutscreenState createState() => _CheckoutscreenState();
}

class _CheckoutscreenState extends State<Checkoutscreen> {
  String item_count = "";
  final orderController = TextEditingController();
  final creditcardController = TextEditingController();



  getaddtocartdata() async {
    try {
      var addtocartservice = addtocartServices();
      var response = await addtocartservice.getalladdtocartitems(userloginid);
      return response;
    } catch (e) {
      print(e);
    }
  }

  getproductdata(String productid) async {
    try {
      var adminservice = adminServices();
      var response = await adminservice.getsingleproductservice(productid);
      return response;
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.5,
        backgroundColor: Colors.white,
        shadowColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen()),
            );
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.blue,
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 20.0),
        child: FloatingActionButton.extended(
          onPressed: () {
            Navigator.of(context).pop();
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddtocartInfo(productprice: widget.productprice,)),
            );
          },
          label: const Text("Confirm"),
          backgroundColor: Colors.deepPurple,
          tooltip: 'Capture Picture',
          elevation: 5,
          splashColor: Colors.grey,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: SafeArea(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 5.0, bottom: 10),
                child: Text("My Cart",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold)),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 400,
                  child: FutureBuilder(
                      future: getaddtocartdata(),
                      builder: (BuildContext context,
                          AsyncSnapshot<dynamic> snapshot) {
                        switch (snapshot.connectionState) {
                          case ConnectionState.none:
                            return Text('Error');
                          case ConnectionState.waiting:
                            return Text('Loading');
                          default:
                            if (snapshot.hasError) {
                              return const Center(
                                  child: Text(
                                'Loading',
                                textScaleFactor: 3,
                                style: TextStyle(color: Colors.black),
                              ));
                            } else {
                              dynamic data = jsonDecode(
                                  jsonDecode(snapshot.data.toString()))["data"];
                              item_count = data.length.toString();

                              return SizedBox(
                                child: Column(children: [
                                  Row(
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.only(
                                            top: 5.0, bottom: 10),
                                        child: Text("Total items:",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold)),
                                      ),
                                      Text(item_count,
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 300,
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height:260,
                                          child: ListView.builder(
                                            scrollDirection: Axis.vertical,
                                            itemCount: data.length,
                                            itemBuilder:
                                                (BuildContext context, int index) {
                                              return FutureBuilder(
                                                  future: getproductdata(
                                                      data[index]["productid"]),
                                                  builder: (BuildContext context,
                                                      AsyncSnapshot<dynamic>
                                                          snapshot) {
                                                    switch (
                                                        snapshot.connectionState) {
                                                      case ConnectionState.none:
                                                        return Text('Error');
                                                      case ConnectionState.waiting:
                                                        return Text('Loading');
                                                      default:
                                                        if (snapshot.hasError) {
                                                          return const Center(
                                                              child: Text(
                                                            'Loading',
                                                            textScaleFactor: 3,
                                                            style: TextStyle(
                                                                color: Colors.black),
                                                          ));
                                                        } else {
                                                          dynamic productdata =
                                                              jsonDecode(jsonDecode(
                                                                      snapshot.data
                                                                          .toString()))[
                                                                  "data"];



                                                          return Container(
                                                            margin:
                                                                const EdgeInsets.only(
                                                                    top: 5.0,
                                                                    left: 10,
                                                                    right: 10),
                                                            child: Card(
                                                              color: Colors.blue,
                                                              child: Row(
                                                                children: [
                                                                  Container(
                                                                    margin: const EdgeInsets
                                                                            .symmetric(
                                                                        vertical:
                                                                            10.0),
                                                                    width: 60,
                                                                    height: 50,
                                                                    decoration: BoxDecoration(
                                                                        image: DecorationImage(
                                                                            image: NetworkImage(BASE_URL +
                                                                                productdata[
                                                                                    "productimage"]),
                                                                            fit: BoxFit
                                                                                .cover)),
                                                                  ),
                                                                  Container(
                                                                    margin:
                                                                        const EdgeInsets
                                                                                .only(
                                                                            left:
                                                                                30.0),
                                                                    child: Column(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Text(
                                                                            productdata[
                                                                                "productname"],
                                                                            style: const TextStyle(
                                                                                color: Colors
                                                                                    .white,
                                                                                fontSize:
                                                                                    18,
                                                                                fontWeight:
                                                                                    FontWeight.bold)),
                                                                        Padding(
                                                                          padding: const EdgeInsets
                                                                                  .only(
                                                                              top: 5),
                                                                          child: Text(
                                                                              productdata[
                                                                                  "productprice"],
                                                                              style: const TextStyle(
                                                                                  color: Colors
                                                                                      .white,
                                                                                  fontSize:
                                                                                      10,
                                                                                  fontWeight:
                                                                                      FontWeight.normal)),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          );
                                                        }
                                                    }
                                                  });
                                            },
                                          ),
                                        ),

                                      ],
                                    ),
                                  ),

                                ]),
                              );
                            }
                        }
                      }),
                ),
              ),
              Expanded(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 100,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30.0),
                        topRight: Radius.circular(30.0),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black54,
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3), // changes position of shadow
                        )
                      ]),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children:[
                        const Padding(
                          padding: EdgeInsets.only(
                              top: 5.0, bottom: 10),
                          child: Text("Total price:",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold)),
                        ),
                        Text('RS ${widget.productprice.toString()}',
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold)),
                        // Padding(
                        //   padding: const EdgeInsets.only(left: 4, top: 8.0),
                        //   child: TextFormField(
                        //     style: const TextStyle(
                        //         color: Colors.black, fontWeight: FontWeight.bold),
                        //     controller: orderController,
                        //     // onChanged: (value) {
                        //     //   doctorname = value;
                        //     // },
                        //     decoration: InputDecoration(
                        //       hintText: "credit card info",
                        //       hintStyle: const TextStyle(
                        //           color: Colors.grey, fontWeight: FontWeight.bold),
                        //       contentPadding: EdgeInsets.all(10.0),
                        //       prefixIcon: const Icon(
                        //         Icons.person,
                        //         color: Colors.blue,
                        //       ),
                        //       enabledBorder: UnderlineInputBorder(
                        //           borderRadius: BorderRadius.circular(10.0),
                        //           borderSide:
                        //           const BorderSide(color: Colors.black, width: 6)),
                        //       focusedBorder: UnderlineInputBorder(
                        //           borderRadius: BorderRadius.circular(10.0),
                        //           borderSide:
                        //           const BorderSide(color: Colors.black, width: 6)),
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
