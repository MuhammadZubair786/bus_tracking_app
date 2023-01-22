// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

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

  getdata() async {
    DatabaseReference userRef =
        await FirebaseDatabase.instance.reference().child('Drivers');

    userRef.once().then((value) {
      print(value.snapshot.value);
      var Data = value.snapshot.value as Map;
      for (var i in Data.values) {
        driver.add(i);
        // print(i);

      }
      setState(() {});
      print("call" + Data.values.length.toString());
    });
  }


  delete_driver(String id)async{
     DatabaseReference userRef =
        await FirebaseDatabase.instance.reference().child('Drivers');
  }



  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        driver.length > 0
            ? Table(columnWidths: const {
                0: FlexColumnWidth(0.7),
                1: FlexColumnWidth(1.5),
                2: FlexColumnWidth(1.5),
                3: FlexColumnWidth(1.5),
                4: FlexColumnWidth(1.5),
                5: FlexColumnWidth(1.5),
              }, children: [
                TableRow(children: [
                  Container(
                    margin: EdgeInsets.all(5),
                    padding: EdgeInsets.all(5),
                    child: Text(
                      'S.NO',
                      style: TextStyle(
                          fontSize: 15.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(5),
                    padding: EdgeInsets.all(5),
                    child: Text(
                      "Name",
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(5),
                    padding: EdgeInsets.all(5),
                    child: Text(
                      "Email",
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(5),
                    padding: EdgeInsets.all(5),
                    child: Text(
                      "Address",
                      style: TextStyle(
                          fontSize: 15.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(5),
                    padding: EdgeInsets.all(5),
                    child: Text(
                      "Contact",
                      style: TextStyle(
                          fontSize: 15.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(5),
                    padding: EdgeInsets.all(5),
                    child: Text(
                      "Cnic",
                      style: TextStyle(
                          fontSize: 15.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                  // Text("25", style: TextStyleOutput(fontSize: 15.0),),
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
     driver.length>0?   ListView.builder(
          shrinkWrap: true,
          physics: BouncingScrollPhysics(),
          itemCount: driver.length,
          itemBuilder: ((context, index) {
            return Table(
                border: TableBorder.all(width: 1, color: Color(0xff778789)),
                columnWidths: const {
                  0: FlexColumnWidth(0.7),
                  1: FlexColumnWidth(1.5),
                  2: FlexColumnWidth(1.5),
                  3: FlexColumnWidth(1.5),
                  4: FlexColumnWidth(1.5),
                  5: FlexColumnWidth(1.5),
                },
                children: [
                  TableRow(children: [
                    Container(
                      margin: EdgeInsets.all(5),
                      padding: EdgeInsets.all(5),
                      child: Text(
                        '${(index + 1).toString()}',
                        style: TextStyle(fontSize: 15.0),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(5),
                      padding: EdgeInsets.all(5),
                      child: Text(
                        driver[index]["username"],
                        style: TextStyle(fontSize: 15.0),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(5),
                      padding: EdgeInsets.all(5),
                      child: Text(
                        driver[index]["email"],
                        style: TextStyle(fontSize: 15.0),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(5),
                      padding: EdgeInsets.all(5),
                      child: Text(
                        driver[index]["address"],
                        style: TextStyle(fontSize: 15.0),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(5),
                      padding: EdgeInsets.all(5),
                      child: Text(
                        driver[index]["Contact_No"],
                        style: TextStyle(fontSize: 15.0),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(5),
                      padding: EdgeInsets.all(5),
                      child: Text(
                        driver[index]["Cnic"],
                        style: TextStyle(fontSize: 15.0),
                      ),
                    ),
                    // Text("25", style: TextStyleOutput(fontSize: 15.0),),
                  ]),
                ]);
          }),
          // child: Text("Call"),
        ):Text(""),
      ],
    );
  }
}

class $ {}
