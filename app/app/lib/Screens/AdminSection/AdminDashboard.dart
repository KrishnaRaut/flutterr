import 'package:app/Screens/AdminSection/AddDoctor.dart';
import 'package:app/Screens/AdminSection/Doctorinfo.dart';
import 'package:app/Screens/AdminSection/Productinfo.dart';
import 'package:app/Screens/LoginScreen.dart';
import 'package:flutter/material.dart';

import 'AddProduct.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({Key? key}) : super(key: key);

  @override
  _AdminDashboardState createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 30,
              ),
              const Icon(
                Icons.settings,
                color: Colors.blue,
              ),
              const Padding(
                padding: EdgeInsets.only(top: 20.0),
                child: Text("Welcome Admin",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold)),
              ),
              const SizedBox(
                height: 80,
              ),
              SizedBox(
                width: 200,
                height: 100,
                child: ElevatedButton.icon(onPressed: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AddDoctor()));
                }, icon:  const Icon(
                  Icons.medical_services_outlined,
                  color: Colors.white,
                ),
                  style: ButtonStyle(
                    backgroundColor:
                    MaterialStateProperty.all<Color>(
                      Colors.blue,
                    ),
                    shape: MaterialStateProperty.all<
                        RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        )),
                  ),
                label: const Text("Add Doctor",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold
                    )),),
              ),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                width: 200,
                height: 100,
                child: ElevatedButton.icon(onPressed: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AddProduct()));
                }, icon:  const Icon(
                  Icons.production_quantity_limits,
                  color: Colors.white,
                ),
                  style: ButtonStyle(
                    backgroundColor:
                    MaterialStateProperty.all<Color>(
                      Colors.blue,
                    ),
                    shape: MaterialStateProperty.all<
                        RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        )),
                  ),
                  label: const Text("Add Product",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold
                      )),),
              ),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                width: 200,
                height: 50,
                child: ElevatedButton.icon(onPressed: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DoctorInfo()));
                }, icon:  const Icon(
                  Icons.person,
                  color: Colors.white,
                ),
                  style: ButtonStyle(
                    backgroundColor:
                    MaterialStateProperty.all<Color>(
                      Colors.amber,
                    ),
                    shape: MaterialStateProperty.all<
                        RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        )),
                  ),
                  label: const Text("Doctor Info",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold
                      )),),
              ),
              const SizedBox(
                height: 20,
              ),

              SizedBox(
                width: 200,
                height: 50,
                child: ElevatedButton.icon(onPressed: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ProductInfo()));
                }, icon:  const Icon(
                  Icons.shopping_cart,
                  color: Colors.white,
                ),
                  style: ButtonStyle(
                    backgroundColor:
                    MaterialStateProperty.all<Color>(
                      Colors.amber,
                    ),
                    shape: MaterialStateProperty.all<
                        RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        )),
                  ),
                  label: const Text("Product Info",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold
                      )),),
              ),
              const SizedBox(
                height: 20,
              ),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                width: 200,
                height: 50,
                child: ElevatedButton.icon(onPressed: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => LoginScreen()));
                }, icon:  const Icon(
                  Icons.logout,
                  color: Colors.white,
                ),
                  style: ButtonStyle(
                    backgroundColor:
                    MaterialStateProperty.all<Color>(
                      Colors.blue,
                    ),
                    shape: MaterialStateProperty.all<
                        RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        )),
                  ),
                  label: const Text("logout",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold
                      )),),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
