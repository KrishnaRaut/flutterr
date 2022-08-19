import 'dart:convert';

import 'package:app/ApiServices/addtocartServices.dart';
import 'package:app/ApiServices/adminServices.dart';
import 'package:app/Screens/Checkoutscreen.dart';
import 'package:app/Screens/HomeScreen.dart';
import 'package:app/URL/constraints.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddtoCart extends StatefulWidget {
  const AddtoCart({Key? key}) : super(key: key);

  @override
  _AddtoCartState createState() => _AddtoCartState();
}

class _AddtoCartState extends State<AddtoCart> {

  int productprice =0;
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

  removefromcart(String id) async {
    try {
      var addtocartservice = addtocartServices();
      var response = await addtocartservice.removefromcartitems(id);
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
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 20.0),
        child: FloatingActionButton.extended(
          onPressed: () {
            Navigator.of(context).pop();
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Checkoutscreen(productprice: productprice,)),
            );
          },
          label: const Text("Purchase"),
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
                child: Text("Cart Page",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold)),
              ),
              Image.asset("assets/images/shoppingcart.jpg",
                  height: 200, width: 400, fit: BoxFit.fill),
              const Padding(
                padding: EdgeInsets.only(top: 10.0, bottom: 10),
                child: Text("Your items",
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
                                  style:
                                  TextStyle(color: Colors.black),
                                ));
                            } else {
                              dynamic data = jsonDecode(
                                  jsonDecode(snapshot.data.toString()))["data"];
                              return GridView.builder(
                                  gridDelegate:
                                      const SliverGridDelegateWithMaxCrossAxisExtent(
                                          maxCrossAxisExtent: 200,
                                          childAspectRatio: 20 / 20,
                                          crossAxisSpacing: 20,
                                          mainAxisSpacing: 20),
                                  itemCount: data.length,
                                  itemBuilder: (BuildContext ctx, index) {
                                    return FutureBuilder(
                                      future: getproductdata(
                                          data[index]["productid"]),
                                      builder: (BuildContext context,
                                          AsyncSnapshot<dynamic> snapshot) {
                                        if (snapshot.hasData) {
                                          dynamic productdata = jsonDecode(
                                              jsonDecode(snapshot.data
                                                  .toString()))["data"];
                                          productprice+=int.parse(productdata["productprice"]);
                                          return SizedBox(
                                              child: Card(
                                            child: Column(
                                              children: [
                                                Container(
                                                  width: 80,
                                                  height: 80,
                                                  decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                          image: NetworkImage(
                                                              BASE_URL +
                                                                  productdata[
                                                                      "productimage"]),
                                                          fit: BoxFit.fill)),
                                                ),
                                                Text(
                                                  productdata["productname"],
                                                  style: const TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Colors.black),
                                                ),
                                                IconButton(
                                                  color: Colors.red,
                                                  icon: Icon(Icons.delete),
                                                  onPressed: () async {
                                                    var response = json.decode(
                                                        await removefromcart(
                                                            data[index]
                                                                ["_id"]));
                                                    print(response);

                                                    print(response["success"] ==
                                                        false);
                                                    if (response["success"] ==
                                                        true) {
                                                      Fluttertoast.showToast(
                                                          msg:
                                                              "Product removed",
                                                          toastLength: Toast
                                                              .LENGTH_SHORT,
                                                          gravity: ToastGravity
                                                              .BOTTOM,
                                                          timeInSecForIosWeb: 1,
                                                          backgroundColor:
                                                              Colors.deepPurple,
                                                          textColor:
                                                              Colors.white);
                                                      Navigator.pop(context);
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (BuildContext
                                                                      context) =>
                                                                  const HomeScreen()));
                                                    }

                                                    if (response["success"] ==
                                                        false) {
                                                      print('faef');
                                                      Fluttertoast.showToast(
                                                          msg:
                                                              'Product not removed',
                                                          toastLength: Toast
                                                              .LENGTH_SHORT,
                                                          gravity: ToastGravity
                                                              .BOTTOM,
                                                          timeInSecForIosWeb: 1,
                                                          backgroundColor:
                                                              Colors.deepPurple,
                                                          textColor:
                                                              Colors.white);
                                                    }
                                                  },
                                                )
                                              ],
                                            ),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                            ),
                                            elevation: 10,
                                            margin: EdgeInsets.all(10),
                                          ));
                                        } else {
                                          return const Center(
                                              child: Text(
                                            'No item added',
                                            textScaleFactor: 3,
                                            style:
                                                TextStyle(color: Colors.black),
                                          ));
                                        }
                                      },
                                    );
                                  });
                            }
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
