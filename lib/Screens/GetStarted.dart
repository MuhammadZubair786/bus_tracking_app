// ignore_for_file: prefer_const_constructors

import 'package:bus_tracking_app/Screens/RegDriver.dart';
import 'package:bus_tracking_app/Screens/RegStudent.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class GetStartedApp extends StatefulWidget {
  const GetStartedApp({super.key});

  @override
  State<GetStartedApp> createState() => _GetStartedAppState();
}

class _GetStartedAppState extends State<GetStartedApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.topRight,
                colors: [
                  Color.fromARGB(255, 197, 243, 167),
                  Color.fromARGB(255, 174, 243, 127),
                  Color.fromARGB(255, 162, 247, 139),
                  Color.fromARGB(255, 197, 243, 167)
                ]),
          ),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.all(30),
                child: const CircleAvatar(
                  radius: 100,
                  backgroundImage: NetworkImage(
                      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS2j5GAl82jgNaN5LZs7KzRryeRVDTso2KjNg&usqp=CAU"),
                ),
              ),

              // ignore: avoid_unnecessary_containers
              Container(
                child: const Text(
                  "SAU BUS TRACKING",
                  style: TextStyle(
                      fontSize: 40,
                      color: Color.fromARGB(255, 33, 87, 2),
                      fontWeight: FontWeight.bold,
                      fontFamily: "Nenostyle"),
                ),
              ),
              SizedBox(
                height: 70,
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>DriverReg()));
                  },
                  style: ElevatedButton.styleFrom(
                      primary: Color.fromARGB(255, 0, 134, 76)),
                  child: Text(
                    "Register As Driver",
                    style: TextStyle(fontSize: 15, fontFamily: "ButtonMelian"),
                  )),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>StudentReg()));
                  },
                  style: ElevatedButton.styleFrom(
                      primary: Color.fromARGB(255, 0, 134, 76)),
                  child: Text(
                    "Register As Student",
                    style: TextStyle(fontSize: 15, fontFamily: "ButtonMelian"),
                  )), 
                  SizedBox(height: 35,),
                  Text(
                    "Already Have An Account ? Sign In",
                    style: TextStyle(fontSize: 15, fontFamily: "ButtonMelian",color: Color.fromARGB(255, 78, 77, 77)),
                  )          
                  
                   ],
          ),
        ),
      ),
    );
  }
}
