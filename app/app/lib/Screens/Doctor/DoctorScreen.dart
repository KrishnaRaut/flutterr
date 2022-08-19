import 'dart:convert';

import 'package:app/ApiServices/adminServices.dart';
import 'package:app/Screens/Doctor/DoctorProfileScreen.dart';
import 'package:app/URL/constraints.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class DoctorScreen extends StatefulWidget {
  const DoctorScreen({Key? key}) : super(key: key);

  @override
  _DoctorScreenState createState() => _DoctorScreenState();
}

class _DoctorScreenState extends State<DoctorScreen> {
  getdoctorData() async {
    try {
      var adminservice = adminServices();
      var response = await adminservice.getalldoctor();
      return response;
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Doctors",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: Icon(
              Icons.info,
              color: Colors.grey,
            ),
          )
        ],
      ),
      body: getBody(),
    );
  }

  getBody() {
    return SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(
                children: [
                  Expanded(
                      child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(50)),
                    child: const TextField(
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.search, color: Colors.grey),
                          border: InputBorder.none,
                          hintText: "Search",
                          hintStyle:
                              TextStyle(color: Colors.grey, fontSize: 17)),
                    ),
                  )),
                  SizedBox(
                    width: 5,
                  ),
                  const Icon(
                    Icons.filter_list_rounded,
                    color: Color(0xFF5856d6),
                    size: 35,
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 20,
              ),
              getDoctorList()
            ])));
  }

  getDoctorList() {
    return FutureBuilder(
        future: getdoctorData(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return Text('Error');
            case ConnectionState.waiting:
              return Text('Loading');
            default:
              if (snapshot.hasError) {
                return const Center(
                    child: Text(
                  'No doctor available',
                  textScaleFactor: 3,
                  style: TextStyle(color: Colors.black),
                ));
              } else {
                dynamic data =
                    jsonDecode(jsonDecode(snapshot.data.toString()))["data"];
                return StaggeredGridView.countBuilder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 4,
                  itemCount: data.length,
                  itemBuilder: (BuildContext context, int index) =>
                      GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DoctorProfileScreen(
                                    doctorid: data[index]["_id"],
                                  )));
                    },
                    child: Container(
                        margin: const EdgeInsets.all(5),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.1),
                              spreadRadius: 1,
                              blurRadius: 1,
                              offset:
                                  Offset(1, 1), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                                child: Container(
                              height: index.isEven ? 100 : 50,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  image: DecorationImage(
                                      image: NetworkImage(BASE_URL +
                                          data[index]["doctorimage"]),
                                      fit: BoxFit.cover)),
                            )),
                            const SizedBox(height: 10),
                            Text(
                              data[index]["doctorname"],
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              data[index]["doctorspeciality"],
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                          ],
                        )),
                  ),
                  staggeredTileBuilder: (int index) =>
                      new StaggeredTile.count(2, index.isEven ? 3 : 2),
                  mainAxisSpacing: 4,
                  crossAxisSpacing: 4,
                );
              }
          }
        });
  }
}
