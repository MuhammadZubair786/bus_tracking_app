// ignore_for_file: prefer_const_constructors

import 'dart:async';
// import 'package:barberapp/screens/BHLoginScreen.dart';
// import 'package:nb_utils/nb_utils.dart';

import 'package:bus_tracking_app/Admin/Admin_DashBoard.dart';
import 'package:bus_tracking_app/Admin/Driver_List.dart';
import 'package:bus_tracking_app/Driver/Driver_Navigation.dart';
import 'package:bus_tracking_app/Login/GetStarted.dart';
import 'package:bus_tracking_app/Navigation/BottomNavbar.dart';
import 'package:bus_tracking_app/ONBORDINGSCREEN/onBordingScreen.dart';
import 'package:bus_tracking_app/Login/loginscreen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:barberapp/screens/BHWalkThroughScreen.dart';
// import 'package:barberapp/main.dart';

class BHSplashScreen extends StatefulWidget {
  static String tag = '/BHSplashScreen';

  @override
  BHSplashScreenState createState() => BHSplashScreenState();

}

class BHSplashScreenState extends State<BHSplashScreen> {
  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {

    final prefs = await SharedPreferences.getInstance();
    var check = prefs.getString("Login_User");
    print(check);
    if(check=="Student"){
      Timer(Duration(seconds: 5), () {
      
      Navigator.push(context, MaterialPageRoute(builder: (context)=>BottomNavBar()));
     
    });
    }
    else if(check=="Driver"){
 Timer(Duration(seconds: 5), () {
     
      Navigator.push(context, MaterialPageRoute(builder: (context)=>Driver_Navigation()));
     
    });
    }
      else if(check=="Admin"){
 Timer(Duration(seconds: 5), () {
     
      Navigator.push(context, MaterialPageRoute(builder: (context)=>AdminHome()));
     
    });
    }
    else{
      {
      Timer(Duration(seconds: 5), () {
      // finish(context);
      Navigator.push(context, MaterialPageRoute(builder: (context)=>BHLoginScreen()));
      // BHLoginScreen().launch(context);
      // BHDashedBoardScreen().launch(context);
    });
    }
    }
    
    
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.oragne,
      body: Container(
        constraints: BoxConstraints(
          maxHeight: double.infinity,
        ),
        decoration: BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          // ignore: prefer_const_literals_to_create_immutables
          colors: [
            Color.fromARGB(255, 255, 255, 255),
            Color.fromARGB(255, 255, 255, 255)          ],
        )),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment:CrossAxisAlignment.center,
          children: [
            
            Center(
              child: Image.asset(
                'images/SAUTransport.png',
                height: 550,
                width: 400,
                // color:
                //     Color.fromARGB(255, 185, 181, 181).withOpacity(0.9),
              ),
            ),
            // Text("SAU Transport Tracking System"
            //   ,style: TextStyle(fontSize: 22,
            //   fontWeight: FontWeight.bold
            //   ,color: Color.fromARGB(255, 4, 72, 128),),
            // )
          ],
        ),
      ),
    );
  }
}
