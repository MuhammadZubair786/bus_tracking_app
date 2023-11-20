// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:bus_tracking_app/Admin/Add_Driver.dart';
import 'package:bus_tracking_app/Admin/Admin_DashBoard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StudentList extends StatefulWidget {
  const StudentList({super.key});

  @override
  State<StudentList> createState() => _StudentListState();
}

class _StudentListState extends State<StudentList> {
  var driver = [];
  void initState() {
    super.initState();
    if (mounted) {
      setState(() {
        /* ... */
      });
    }
    getdata();
  }

  delete_student(String id, String email1, String password1) async {
    DatabaseReference userRef =
        await FirebaseDatabase.instance.reference().child('Students');

    print(id);
    AuthCredential credentials =
        EmailAuthProvider.credential(email: email1, password: password1);
    final userCredential =
        await FirebaseAuth.instance.signInWithCredential(credentials);
    final user = await FirebaseAuth.instance.currentUser!.delete();
    // print(user);
    await userRef.child(id.toString()).remove();

    setState(() {});

    getdata();
  }

  getdata() async {
    driver = [];
    DatabaseReference userRef =
        await FirebaseDatabase.instance.reference().child('Students');

    userRef.once().then((value) {
      print(value.snapshot.value);
      if (value.snapshot.value != null) {
        var Data = value.snapshot.value as Map;
        for (var i in Data.values) {
          driver.add(i);
          // print(i);
        }
        setState(() {});
        print("call" + Data.values.length.toString());
      }
    });
  }

  // delete_driver(String id)async{
  //    DatabaseReference userRef =
  //       await FirebaseDatabase.instance.reference().child('Students');
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            appBar: AppBar(
                iconTheme:
                    IconThemeData(color: Color.fromARGB(255, 11, 1, 102)),
                backgroundColor: Colors.white,
                centerTitle: true,
                title: Text(
                  "Students Detail",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 30, 6, 121),
                  ),
                )),
            drawer: Drawer(
              child: ListView(
                children: [
                  DrawerHeader(
                      child: Container(
                    width: 300.0,
                    height: 500.0,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                      image: AssetImage("images/st2.jfif"),
                    )),
                    child: Center(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [],
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
                      GestureDetector(
                        onTap: () {
                          //
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AdminHome()));
                        },
                        child: ListTile(
                            leading: IconButton(
                              icon: Icon((Icons.bus_alert_rounded)),
                              color: Color.fromARGB(255, 57, 1, 129),
                              iconSize: 30,
                              onPressed: () {},
                            ),
                            title: Text("Driver")),
                      ),
                      GestureDetector(
                        onTap: () {
                          //
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => StudentList()));
                        },
                        child: ListTile(
                            leading: IconButton(
                              icon: Icon((Icons.person)),
                              color: Color.fromARGB(255, 57, 1, 129),
                              iconSize: 30,
                              onPressed: () {},
                            ),
                            title: Text("Student")),
                      ),
                      GestureDetector(
                        onTap: () {
                          //
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AddDriver()));
                        },
                        child: ListTile(
                            leading: IconButton(
                              icon: Icon((Icons.bus_alert_sharp)),
                              color: Color.fromARGB(255, 57, 1, 129),
                              onPressed: () {},
                            ),
                            title: Text("Add Driver")),
                      ),
                      GestureDetector(
                        onTap: () async {
                          final prefs = await SharedPreferences.getInstance();
                          prefs.clear();
                          // ignore: use_build_context_synchronously
                          // Navigator.pushReplacement(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => BHLoginScreen()));
                        },
                        child: ListTile(
                            leading: IconButton(
                              icon: Icon((Icons.login_outlined)),
                              color: Color.fromARGB(255, 57, 1, 129),
                              iconSize: 30,
                              onPressed: () {},
                            ),
                            title: Text("Log Out")),
                      ),
                    ],
                  ),
                  // GestureDetector(onTap: (){},child:ListTile(title:Text("hello"))),  //GestureDetector used for Drawer move one page to other
                ],
              ),
            ),
            body: SingleChildScrollView(
                child: Column(
              children: [
                Column(
                  children: [
                    driver.length > 0
                        ? Table(
                            border: TableBorder.all(
                                width: 1,
                                color: Color.fromARGB(255, 1, 111, 126)),
                            columnWidths: const {
                                0: FlexColumnWidth(1.5),
                                // 1: FlexColumnWidth(1.5),
                                // 2: FlexColumnWidth(1.5),
                                // 3: FlexColumnWidth(1.5),
                                // 4: FlexColumnWidth(1.5),
                                // 5: FlexColumnWidth(1.5),
                                // 6: FlexColumnWidth(1.5),
                                1: FlexColumnWidth(1.6),
                                2: FlexColumnWidth(1.7),
                                3: FlexColumnWidth(1.5),
                                4: FlexColumnWidth(2),
                              },
                            children: [
                                TableRow(children: [
                                  Container(
                                    margin: EdgeInsets.all(5),
                                    padding: EdgeInsets.all(5),
                                    child: Text(
                                      "Name",
                                      style: TextStyle(
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.all(5),
                                    padding: EdgeInsets.all(5),
                                    child: Text(
                                      "Email",
                                      style: TextStyle(
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.all(5),
                                    padding: EdgeInsets.all(5),
                                    child: Text(
                                      "Year",
                                      style: TextStyle(
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.all(5),
                                    padding: EdgeInsets.all(5),
                                    child: Text(
                                      "Contact",
                                      style: TextStyle(
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.all(5),
                                    padding: EdgeInsets.all(5),
                                    child: Text(
                                      'Password',
                                      style: TextStyle(
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Container(
                                      margin: EdgeInsets.all(5),
                                      padding: EdgeInsets.all(5),
                                      child: Icon(
                                          Icons.energy_savings_leaf_rounded)),

                                  // Text("25", style: TextStyleOutput(fontSize: 12.0),),
                                ])
                              ])
                        : Container(
                            margin: EdgeInsets.all(50),
                            // ignore: prefer_const_literals_to_create_immutables
                            child: Center(
                                child: SizedBox(
                              width: 100,
                              height: 100,
                              child: CircularProgressIndicator(
                                backgroundColor:
                                    Color.fromARGB(255, 7, 219, 219),
                                strokeWidth: 10,
                                color: Color.fromARGB(255, 4, 2, 121),
                              ),
                            )),
                          ),
                    driver.length > 0
                        ? ListView.builder(
                            shrinkWrap: true,
                            physics: BouncingScrollPhysics(),
                            itemCount: driver.length,
                            itemBuilder: ((context, index) {
                              return Table(
                                  border: TableBorder.all(
                                      width: 1, color: Color(0xff778789)),
                                  columnWidths: const {
                                    0: FlexColumnWidth(1.5),
                                    // 1: FlexColumnWidth(1.5),
                                    // 2: FlexColumnWidth(1.5),
                                    // 3: FlexColumnWidth(1.5),
                                    // 4: FlexColumnWidth(1.5),
                                    // 5: FlexColumnWidth(1.5),
                                    // 6: FlexColumnWidth(1.5),
                                    1: FlexColumnWidth(1.6),
                                    2: FlexColumnWidth(1.7),
                                    3: FlexColumnWidth(1.5),
                                    4: FlexColumnWidth(2),
                                  },
                                  children: [
                                    TableRow(children: [
                                      Container(
                                        margin: EdgeInsets.all(5),
                                        padding: EdgeInsets.all(5),
                                        child: Text(
                                          driver[index]["username"],
                                          style: TextStyle(fontSize: 12.0),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.all(5),
                                        padding: EdgeInsets.all(5),
                                        child: Text(
                                          driver[index]["email"],
                                          style: TextStyle(fontSize: 12.0),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.all(5),
                                        padding: EdgeInsets.all(5),
                                        child: Text(
                                          driver[index]["Year"],
                                          style: TextStyle(fontSize: 12.0),
                                        ),
                                      ),

                                      Container(
                                        margin: EdgeInsets.all(5),
                                        padding: EdgeInsets.all(5),
                                        child: Text(
                                          driver[index]["Phone_Number"],
                                          style: TextStyle(fontSize: 12.0),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.all(5),
                                        padding: EdgeInsets.all(5),
                                        child: Text(
                                          driver[index]["password"],
                                          style: TextStyle(fontSize: 12.0),
                                        ),
                                      ),
                                      Container(
                                          margin: EdgeInsets.all(5),
                                          padding: EdgeInsets.all(5),
                                          child: IconButton(
                                            // iconSize: 2,
                                            icon: const Icon(
                                              Icons.delete,
                                              color: Colors.red,
                                            ),

                                            // the method which is called
                                            // when button is pressed
                                            onPressed: () {
                                              delete_student(
                                                  driver[index]["userUid"],
                                                  driver[index]["email"],
                                                  driver[index]["password"]);
                                            },
                                          )),

                                      // Text("25", style: TextStyleOutput(fontSize: 12.0),),
                                    ]),
                                  ]);
                            }),
                            // child: Text("Call"),
                          )
                        : Text(""),
                  ],
                ),
              ],
            ))));

    //  Text(("Home Page !"),style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Colo
  }
}
