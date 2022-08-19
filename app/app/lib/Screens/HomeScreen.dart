import 'package:app/Screens/DashboardScreen.dart';
import 'package:app/Screens/ProfileScreen.dart';
import 'package:flutter/material.dart';

import 'AddtoCartScreen.dart';
import 'Doctor/DoctorScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  final List _children = [
    DashboardScreen(), AddtoCart(), DoctorScreen(), ProfileScreen()
  ];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex], // new
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped, // new
        currentIndex: _currentIndex,
        backgroundColor: Colors.white,// new
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Colors.blue,),
            title: Text('Home', style: TextStyle(color:Colors.black, fontSize:12,fontWeight: FontWeight.bold), ),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart, color: Colors.blue,),
            title: Text('Add to cart', style: TextStyle(color:Colors.black, fontSize:12,fontWeight: FontWeight.bold), ),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_hospital, color: Colors.blue,),
            title: Text('Doctor', style: TextStyle(color:Colors.black, fontSize:12,fontWeight: FontWeight.bold), ),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, color: Colors.blue,),
            title: Text('Profile', style: TextStyle(color:Colors.black, fontSize:12,fontWeight: FontWeight.bold), ),
          )
        ],
      ),
    );
  }
}
