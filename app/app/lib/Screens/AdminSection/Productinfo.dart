import 'dart:convert';

import 'package:app/ApiServices/adminServices.dart';
import 'package:app/URL/constraints.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'AdminDashboard.dart';

class ProductInfo extends StatefulWidget {
  const ProductInfo({Key? key}) : super(key: key);

  @override
  _ProductInfoState createState() => _ProductInfoState();
}

class _ProductInfoState extends State<ProductInfo> {
  getproductData() async {
    try {
      var adminservice = adminServices();
      var response = await adminservice.getallproduct();
      return response;
    } catch (e) {
      print(e);
    }
  }

  removeproductdata(String id) async {
    try {
      var adminservice = adminServices();
      var response = await adminservice.removeproductinfo(id);
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
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 10.0, bottom: 10),
              child: Text("Available products",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold)),
            ),
            Expanded(
              child: FutureBuilder(
                future: getproductData(),
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.hasData) {
                    dynamic data = jsonDecode(
                        jsonDecode(snapshot.data.toString()))["data"];
                    return Padding(
                      padding: const EdgeInsets.only(left: 12.0, right: 12),
                      child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithMaxCrossAxisExtent(
                                      maxCrossAxisExtent: 200,
                                      childAspectRatio: 20 / 20,
                                      crossAxisSpacing: 20,
                                      mainAxisSpacing: 20),
                              itemCount: data.length,
                              itemBuilder: (BuildContext ctx, index) {
                                return SizedBox(
                                    child: Card(
                                  child: Column(
                                    children: [
                                      Container(
                                        width: 80,
                                        height: 80,
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: NetworkImage(BASE_URL +
                                                    data[index]
                                                        ["productimage"]),
                                                fit: BoxFit.fill)),
                                      ),
                                      Text(
                                        data[index]["productname"],
                                        style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black),
                                      ),
                                      Padding(
                                          padding: const EdgeInsets.only(
                                              left: 15.0, right: 15),
                                          child: IconButton(
                                              color: Colors.red,
                                              icon: Icon(Icons.delete),
                                              onPressed: () async {
                                                var response = json.decode(
                                                    await removeproductdata(
                                                        data[index]["_id"]));
                                                if (response["success"] ==
                                                    true) {
                                                  Fluttertoast.showToast(
                                                      msg:
                                                          "Product info removed",
                                                      toastLength:
                                                          Toast.LENGTH_SHORT,
                                                      gravity:
                                                          ToastGravity.BOTTOM,
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
                                                              const AdminDashboard()));
                                                }

                                                if (response["success"] ==
                                                    false) {
                                                  print('faef');
                                                  Fluttertoast.showToast(
                                                      msg:
                                                          'Product not removed',
                                                      toastLength:
                                                          Toast.LENGTH_SHORT,
                                                      gravity:
                                                          ToastGravity.BOTTOM,
                                                      timeInSecForIosWeb: 1,
                                                      backgroundColor:
                                                          Colors.deepPurple,
                                                      textColor: Colors.white);
                                                }
                                              })),
                                    ],
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  elevation: 10,
                                  margin: EdgeInsets.all(10),
                                ));
                              })),
                    );
                  } else {
                    return const Center(
                        child: Text(
                      'No product',
                      textScaleFactor: 3,
                      style: TextStyle(color: Colors.black),
                    ));
                  }
                },
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
