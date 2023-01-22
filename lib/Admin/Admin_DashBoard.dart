// import 'package:drawer_nav/Services.dart';
// ignore_for_file: prefer_const_constructors

import 'package:bus_tracking_app/Admin/Add_Driver.dart';
import 'package:bus_tracking_app/Admin/Driver_List.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Login/loginScreen.dart';



class AdminHome extends StatefulWidget {
 

  @override
  _AdminHomeState createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  
  @override
  Widget build(BuildContext context) {
     return MaterialApp(
      debugShowCheckedModeBanner: false,
        home: Scaffold(
     appBar: AppBar(
        iconTheme: IconThemeData(color: Color.fromARGB(255, 11, 1, 102)),
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text("Driver Detail" ,style: TextStyle(fontSize: 22,
              fontWeight: FontWeight.bold
              ,color: Color.fromARGB(255, 6, 2, 233),),)),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
                child: Container(
              width: 300.0,
              height: 500.0,
              decoration: BoxDecoration(
                  image: DecorationImage(
                image: AssetImage(
                    "images/st2.jfif"),
                // fit: BoxFit.cover
              )),
              child: Center(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // IconButton(
                  //   icon: Icon((Icons.supervised_user_circle_rounded)),
                  //   color: Colors.white,
                  //   iconSize: 60,
                  //   onPressed: () {},
                  // ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Text(
                      //   ("User"),
                      //   style: TextStyle(color: Color.fromARGB(255, 219, 25, 51),fontSize: 30),
                      // ),
                      // Text(
                      //   ("User@gmail.com"),
                      //   style: TextStyle(color: Colors.white),
                      // )
                    ],
                  )
                ],
              )),
            )),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  color: Colors.white,
                  child: (Row(
                    children: <Widget>[
                      // ...
                      Expanded(
                        child: Column(
                          children: <Widget>[
                         
                            Divider(color: Colors.black)
                          ],
                        ),
                      )
                    ],
                  )),
                ),

                GestureDetector(onTap:(){
                  // Navigator.pop(context);
                  // Navigator.push(
                  //   context, 
                  //   MaterialPageRoute(builder: (context)=>Home()));
                },
                child:  ListTile(
                  leading:   IconButton(
                    icon: Icon((Icons.home)),
                    color: Color.fromARGB(255, 57, 1, 129),
                    iconSize: 30,
                    onPressed: () {},
                  ),
                  title: Text("Driver")
                
                ),
                ),

                
               
                 GestureDetector(onTap:(){
                  Navigator.pop(context);
                  Navigator.push(
                    context, 
                    MaterialPageRoute(builder: (context)=>AddDriver()));
                },
                child:  ListTile(
                  leading:   IconButton(
                    icon: Icon((Icons.bus_alert_sharp)),
                     color: Color.fromARGB(255, 57, 1, 129),
                    onPressed: () {

                    },
                  ),
                  title: Text("Add Driver")
                
                ),
                ),
                 
                // ListTile(
                //   leading:   IconButton(
                //     icon: Icon((Icons.app_blocking_rounded)),
                //     color: Colors.red,
                //     iconSize: 30,
                //     onPressed: () {},
                //   ),
                //   title: Text("About")
                
                // ),

                 ListTile(
                  leading:   IconButton(
                    icon: Icon((Icons.settings_sharp)),
                     color: Color.fromARGB(255, 57, 1, 129),
                    iconSize: 30,
                    onPressed: () {},
                  ),
                  title: Text("Setting")
                
                ),
                   GestureDetector(
                    onTap: () async {
                       final prefs =
                                    await SharedPreferences.getInstance();
                                prefs.clear();
                                // ignore: use_build_context_synchronously
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => BHLoginScreen()));
                    },
                     child: ListTile(
                                     leading:   IconButton(
                      icon: Icon((Icons.login_outlined)),
                        color: Color.fromARGB(255, 57, 1, 129),
                      iconSize: 30,
                      onPressed: () {},
                                     ),
                                     title: Text("Log Out")
                                   
                                   ),
                   ),
                

               
              ],
            ),
            // GestureDetector(onTap: (){},child:ListTile(title:Text("hello"))),  //GestureDetector used for Drawer move one page to other
          ],
        ),
      ),
        body:Center(
          child:SingleChildScrollView(
            child: Column(
              
                
              children: [
              SizedBox(height: 50,),
              
                DriverList(),
              ],
            ),
          )
          //  Text(("Home Page !"),style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.purple)
          //  ,)
           )

    ));
   
  }
}

