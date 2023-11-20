// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class DriverList extends StatefulWidget {
  const DriverList({super.key});

  @override
  State<DriverList> createState() => _DriverListState();
}

class _DriverListState extends State<DriverList> {
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

  FirebaseAuth auth = FirebaseAuth.instance;

  getdata() async {
    driver = [];
    DatabaseReference userRef =
        await FirebaseDatabase.instance.reference().child('Drivers');

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

  delete_driver(String id, String email1, String password1) async {
    DatabaseReference userRef =
        await FirebaseDatabase.instance.reference().child('Drivers');

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

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        driver.length > 0
            ? Table(
                border: TableBorder.all(
                    width: 1, color: Color.fromARGB(255, 1, 111, 126)),
                columnWidths: const {
                    0: FlexColumnWidth(1.5),
                    // 1: FlexColumnWidth(1.5),
                    // 2: FlexColumnWidth(1.5),
                    // 3: FlexColumnWidth(1.5),
                    // 4: FlexColumnWidth(1.5),
                    // 5: FlexColumnWidth(1.5),
                    // 6: FlexColumnWidth(1.5),
                    1: FlexColumnWidth(1.5),
                    2: FlexColumnWidth(1.7),
                    3: FlexColumnWidth(1.5),
                  },
                children: [
                    TableRow(children: [
                      // Container(
                      //   margin: EdgeInsets.all(5),
                      //   padding: EdgeInsets.all(5),
                      //   child: Text(
                      //     'NO',
                      //     style: TextStyle(
                      //         fontSize: 12.0, fontWeight: FontWeight.bold),
                      //   ),
                      // ),
                      Container(
                        margin: EdgeInsets.all(5),
                        padding: EdgeInsets.all(5),
                        child: Text(
                          "Name",
                          style: TextStyle(
                              fontSize: 15.0, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(5),
                        padding: EdgeInsets.all(5),
                        child: Text(
                          "Email",
                          style: TextStyle(
                              fontSize: 15.0, fontWeight: FontWeight.bold),
                        ),
                      ),
                      // Container(
                      //   margin: EdgeInsets.all(5),
                      //   padding: EdgeInsets.all(5),
                      //   child: Text(
                      //     "Address",
                      //     style: TextStyle(
                      //         fontSize: 15.0, fontWeight: FontWeight.bold),
                      //   ),
                      // ),
                      Container(
                          margin: EdgeInsets.all(5),
                          padding: EdgeInsets.all(5),
                          child: Text(
                            "Contact",
                            style: TextStyle(
                                fontSize: 15.0, fontWeight: FontWeight.bold),
                          )),
                      Container(
                        margin: EdgeInsets.all(5),
                        padding: EdgeInsets.all(5),
                        child: Text(
                          "password",
                          style: TextStyle(
                              fontSize: 15.0, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(5),
                        padding: EdgeInsets.all(5),
                        child: Text(
                          "View",
                          style: TextStyle(
                              fontSize: 15.0, fontWeight: FontWeight.bold),
                        ),
                      ),
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
                    backgroundColor: Color.fromARGB(255, 7, 219, 219),
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
                  return Column(
                    children: [
                      Table(
                          border: TableBorder.all(
                              width: 1, color: Color(0xff778789)),
                          columnWidths: const {
                            0: FlexColumnWidth(1.5),
                            // 1: FlexColumnWidth(1.5),
                            1: FlexColumnWidth(1.5),
                            2: FlexColumnWidth(1.7),
                            3: FlexColumnWidth(1.5),
                            // 5: FlexColumnWidth(1.5),
                          },
                          children: [
                            TableRow(children: [
                              // Container(
                              //   margin: EdgeInsets.all(5),
                              //   padding: EdgeInsets.all(5),
                              //   child: Text(
                              //     '${(index + 1).toString()}',
                              //     style: TextStyle(fontSize: 12.0),
                              //   ),
                              // ),
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
                              // Container(
                              //   margin: EdgeInsets.all(5),
                              //   padding: EdgeInsets.all(5),
                              //   child: Text(
                              //     driver[index]["address"],
                              //     style: TextStyle(fontSize: 12.0),
                              //   ),
                              // ),
                              Container(
                                margin: EdgeInsets.all(5),
                                padding: EdgeInsets.all(5),
                                child: Text(
                                  driver[index]["Contact_No"],
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
                                    delete_driver(
                                        driver[index]["userUid"],
                                        driver[index]["email"],
                                        driver[index]["password"]);
                                  },
                                ),
                              ),
                              // Text("25", style: TextStyleOutput(fontSize: 12.0),),
                            ]),
                          ]),
                    ],
                  );
                }),
                // child: Text("Call"),
              )
            : Text(""),
      ],
    );
  }
}

class $ {}
