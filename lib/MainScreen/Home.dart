// ignore_for_file: prefer_const_constructors

import 'package:bus_tracking_app/MainScreen/Bus_Detail.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List Bus_List = [];

  @override
  void initState() {
    super.initState();
    All_Bus();
  }

  All_Bus() async {
    DatabaseReference userRef =
        await FirebaseDatabase.instance.reference().child('Drivers');

    userRef.once().then((value) {
      print(value.snapshot.value);
      var Data = value.snapshot.value as Map;
      for (var i in Data.values) {
        Bus_List.add(i);
        // print(i);

      }
      setState(() {});
      print("call" + Data.values.length.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bus Timing With Route",style: TextStyle( 
          fontSize: 25,
              fontWeight: FontWeight.bold,
          color: Color.fromARGB(255, 6, 2, 233),)),
         backgroundColor: Colors.white,
        elevation: 30,
        
        automaticallyImplyLeading: false,
        centerTitle: true,
        shadowColor: Color.fromARGB(255, 219, 219, 219),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(10),
          child:

          Bus_List.length> 0 ? 
          
           ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: Bus_List.length,
              itemBuilder: ((context, index) {
                // print(Bus_List[index]["Bus"]);
                return GestureDetector(
                    onTap: () {
                             
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  BusDriver_Detial(Bus_List[index])));
                    },
                    child: Bus_List[index]["Bus"]!=null && Bus_List[index]["Bus"]["latitude"] != null ?
                         Card(
                          elevation: 20,
                          child: ListTile(
                        //  leading: Icon(Icons.bus_alert_sharp,color: Colors.red,size: 30,),
                        
                         
                          leading:   Column(
                                children: [
                                  Icon(Icons.bus_alert_sharp,color: Colors.red,size: 30,),
                                  SizedBox(height: 6,),
                                  Text("Time : ${Bus_List[index]["Bus"]["Bus_Time"].toString()}",style: TextStyle(
                                    fontSize: 15,fontWeight: FontWeight.bold,
                                  ),)
                                ],
                              ),
                           
                         
                         
                         title:   Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                            
                             Container(
                              // margin: EdgeInsets.all(5),
                              child: Text("Bus No # : ${Bus_List[index]["Bus"]["Bus_Numb"]}"
                              ,
                              style: TextStyle(
                                    fontSize: 16,fontWeight: FontWeight.bold,
                              ))),
                             Container(
                              //  margin: EdgeInsets.all(5),
                              child: Text("Bus Route # :  ${Bus_List[index]["Bus"]["Bus_Route"].toString()}"
                               ,
                              style: TextStyle(
                                    fontSize: 16,fontWeight: FontWeight.bold,
                              )
                              )),
                             
                           ],
                         ),
                         
                       
                       
                         
                       )
                        // )
                ):SizedBox());
                         
                          // ),
                // );
              })):

             Container(
              margin: EdgeInsets.all(50),
                // ignore: prefer_const_literals_to_create_immutables
                child:
                  Center(
                    child: SizedBox(
                      width: 100,
                      height:100,
                      child: CircularProgressIndicator(
                        backgroundColor: Color.fromARGB(255, 7, 219, 219),
                        strokeWidth: 10,
                       color: Color.fromARGB(255, 4, 2, 121),
                      ),
                    )),
                
              )
        ),
      ),
    );
  }
}