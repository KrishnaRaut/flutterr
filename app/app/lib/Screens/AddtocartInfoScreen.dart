import 'dart:convert';

import 'package:app/ApiServices/addtocartServices.dart';
import 'package:app/Screens/HomeScreen.dart';
import 'package:app/URL/constraints.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddtocartInfo extends StatefulWidget {
  final int productprice;

  const AddtocartInfo({required this.productprice});

  @override
  _AddtocartInfoState createState() => _AddtocartInfoState();
}

class _AddtocartInfoState extends State<AddtocartInfo> {
  final creditcardController = TextEditingController();
  final addressController = TextEditingController();

  String name = "";
  String price = "";
  String creditcarddetails = "";
  String address ="";



  checkoutData() async {
    try {
      var body = {
        "userid": userloginid,
        "price": widget.productprice,
        "creditcarddetails": creditcarddetails,
        "address":address
      };

      var addtocartservice = await addtocartServices();
      var response = await addtocartservice.Detailscheckoutservice(body);
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
                      child: Text("Details",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold)),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Image.asset("assets/images/addtocarticon.png",
                          height: 60, width: 60, fit: BoxFit.fill),
                    ),
                    Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(
                              top: 5.0, bottom: 10),
                          child: Text("Total price: ",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold)),
                        ),
                        Text(widget.productprice.toString(),
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Form(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 4, top: 8.0),
                            child: TextFormField(
                              style: const TextStyle(
                                  color: Colors.black, fontWeight: FontWeight.bold),
                              controller: creditcardController,
                              onChanged: (value) {
                                creditcarddetails = value;
                              },
                              decoration: InputDecoration(
                                hintText: "Enter Credit Card details",
                                hintStyle: const TextStyle(
                                    color: Colors.grey, fontWeight: FontWeight.bold),
                                contentPadding: EdgeInsets.all(10.0),
                                prefixIcon: const Icon(
                                  Icons.credit_card,
                                  color: Colors.blue,
                                ),
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
                            height: 40,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 4, top: 8.0),
                            child: TextFormField(
                              style: const TextStyle(
                                  color: Colors.black, fontWeight: FontWeight.bold),
                              controller: addressController,
                              onChanged: (value) {
                                address = value;
                              },
                              decoration: InputDecoration(
                                hintText: "Enter order address",
                                hintStyle: const TextStyle(
                                    color: Colors.grey, fontWeight: FontWeight.bold),
                                contentPadding: EdgeInsets.all(10.0),
                                prefixIcon: const Icon(
                                  Icons.credit_card,
                                  color: Colors.blue,
                                ),
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
                        ],
                      ),
                    ),
                    Image.asset("assets/images/creditcard.png",
                        height: 300, width: 400, fit: BoxFit.fill),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                              onPressed: () async {
                                var response = await checkoutData();
                                var res = json.decode(response);
                                print(res);
                                if(res["success"]==true){
                                  Fluttertoast.showToast(
                                      msg: 'Purchase successful',
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

                                if(res["success"]==false){
                                  Fluttertoast.showToast(
                                      msg: 'Unsuccessful purhase',
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
                                  Colors.deepPurple,
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
                  ],
                ),
              )),
        ));
  }
}
