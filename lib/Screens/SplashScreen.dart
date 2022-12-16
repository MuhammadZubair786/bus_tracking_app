import 'dart:async';

import 'package:bus_tracking_app/Screens/GetStarted.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 5),
        () => Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const GetStartedApp()))
            );
  }
   
   
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: [
            SizedBox(
              height:50,
              child: Container(
                child: Image.asset('images/splash.jpeg'),
                
                color: Color.fromARGB(255, 145, 233, 30),
                width: 100,
                
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  flex : 2,
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
      //                   Padding(
      //                     padding: const EdgeInsets.only(top : 50.0),
      //                     child: CircleAvatar(
      //                       backgroundColor: Colors.white,
      //                       radius: 50,
      //                       child: Column(
      //                         children: [
      // //                           Padding(
      // //                             padding: const EdgeInsets.only(top:20.0),
      // //                             child:  Image.asset('assets/new.jpeg',
      // //                             height: 60,
      // //                             fit: BoxFit.cover,
      // // ),
      // //                           ),
                               
      //                         ],
      //                       ),
                            
      //                     ),
      //                   ),
                        // Padding(padding: EdgeInsets.only(top:50)),
                        // Text("FlutKart",style: TextStyle(
                        //   color : Colors.white,
                        //   fontSize: 30,
                        //   fontWeight: FontWeight.bold

                        // ),)
                      ],
                    ),
                  )
                  ),
                  // Expanded(
                  //   flex: 2,
                  //   child: Column(
                  //     mainAxisAlignment: MainAxisAlignment.end,
                  //     children: [
                  //       CircularProgressIndicator(backgroundColor: Colors.yellow,),
                  //       Padding(padding: EdgeInsets.only(top:20)),
                  //       Text("ECOM APP \nFor EveryOne",style: TextStyle(
                  //         color:Colors.white,
                  //         fontSize: 20,
                  //         fontWeight: FontWeight.bold
                  //       ),)
                  //     ],
                  //   ))
              ],
            )
          ],

    )
    );
  }
}