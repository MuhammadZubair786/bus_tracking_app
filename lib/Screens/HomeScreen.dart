// ignore_for_file: prefer_const_constructors

import 'package:bus_tracking_app/Screens/LoginScreen.dart';
import 'package:bus_tracking_app/Screens/Tracking.dart';
import 'package:bus_tracking_app/Screens/bUS.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  int currentIndex=0;

  final tabs =[
     
     BustRacker(),
        TrackingScreen(),
     
      
          Container(
        height: 400,
        width: 800,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(('Profile Screen'),style: TextStyle(fontSize: 30),)
          ],
        ))
     
     

  ];





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabs[currentIndex],
      
        
      
      bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Colors.white,
            // fixedColor: Colors.purple,
            selectedItemColor: Colors.purple,
            unselectedItemColor: Colors.black,
            currentIndex: currentIndex,
            iconSize: 25,
            onTap: (int index) => {
              setState((() => {
              currentIndex=index
                
              }))},
            items: const [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.home_outlined,
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.notifications_active_outlined,
                ),
                label: 'Tracking',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.person_outline,
                ),
                label: 'Profile',
              ),
            ])
    );
  }

}