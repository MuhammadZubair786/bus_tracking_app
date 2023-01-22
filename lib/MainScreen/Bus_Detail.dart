// ignore_for_file: prefer_const_constructors

import 'package:bus_tracking_app/MainScreen/Driver_Location.dart';
import 'package:bus_tracking_app/MainScreen/Speific_Driver.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class BusDriver_Detial extends StatefulWidget {
  var Listdata;
   BusDriver_Detial(this.Listdata);

  @override
  State<BusDriver_Detial> createState() => _BusDriver_DetialState(Listdata);
}

class _BusDriver_DetialState extends State<BusDriver_Detial> {
  var Listdata;
  _BusDriver_DetialState(this.Listdata);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      
      home: Scaffold(
         appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text("Bus & Driver Details" ,style: TextStyle(fontSize: 22,
              fontWeight: FontWeight.bold
              ,color: Color.fromARGB(255, 6, 2, 233),),)),
        body: SingleChildScrollView(
          child: ListView.builder(
            itemCount: 1,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: ((context, index) {
              return Card(
                elevation: 40,
                child: Container(
                  margin: EdgeInsets.all(10),
                  padding: EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        "images/new.png",
                        height: 260,
                        width: MediaQuery.of(context).size.width * 0.95,
                        fit: BoxFit.cover,
                        // ,color: Color.fromARGB(255, 19, 18, 18).withOpacity(0.2),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Bus Number : ${Listdata["Bus"]["Bus_Numb"]} ",
                        style:
                            TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Bus Time : ${Listdata["Bus"]["Bus_Time"]} ",
                        style:
                            TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Bus Route : ${Listdata["Bus"]["Bus_Route"]} ",
                        style:
                            TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "State: ${Listdata["Bus"]["Status"]} ",
                        style:
                            TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                       Text(
                        "Driver Name: ${Listdata["username"]} ",
                        style:
                            TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                       Text(
                        "Driver Email: ${Listdata["email"]} ",
                        style:
                            TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                        SizedBox(
                        height: 10,
                      ),
                       Row(
                         children: [
                           Text(
                            "Driver Contact: ${Listdata["Contact_No"]} ",
                            style:
                                TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                         SizedBox(
                        height: 10,
                      ),
                         ],
                       ),
                        SizedBox(
                        height: 10,
                      ),
                        Center(
                          child: ElevatedButton(
                            onPressed:(){
                              // print(Listdata["Bus"][""]);
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>DriverLocationSpefic(Listdata["Bus"])));
                            },
                          child: Text("View Location",
                          style:
                              TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                          ),
                        )
                     
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
