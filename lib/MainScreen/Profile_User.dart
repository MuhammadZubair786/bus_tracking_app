// ignore_for_file: prefer_typing_uninitialized_variables, non_constant_identifier_names, camel_case_types, prefer_const_constructors, avoid_unnecessary_containers, sized_box_for_whitespace, prefer_is_empty

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:nb_utils/nb_utils.dart';

class User_Detail extends StatefulWidget {


  @override
  State<User_Detail> createState() => _User_DetailState();
}

class _User_DetailState extends State<User_Detail> {
  var user_Data=[];

  void initState(){
    super.initState();
    getProfile();
  }

  getProfile() async {
    user_Data=[];
     final prefs = await SharedPreferences.getInstance();
     var uid = prefs.getString("Uid");
     print(uid);

      DatabaseReference userRef =
        FirebaseDatabase.instance.reference().child('Students');
        await userRef.child(uid.toString()).once().then((value) {
      print(value.snapshot.value);
      user_Data.add(value.snapshot.value);
      setState(() {
        
      });
      });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text("User Profile Details" ,style: TextStyle(fontSize: 22,
              fontWeight: FontWeight.bold
              ,color: Color.fromARGB(255, 6, 2, 233),),)),
      body: SafeArea(
        child:
        user_Data.length!=0?
         Container(
          margin: EdgeInsets.all(20),
          height: MediaQuery.of(context).size.height*0.5,
          child: Card(
            elevation: 30,
            
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width *0.27,
                  child: Image.asset(
                          "images/std.png",
                          height:MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width ,
                          fit: BoxFit.fill,
                          // ,color: Color.fromARGB(255, 19, 18, 18).withOpacity(0.2),
                        ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 80),
                  width: MediaQuery.of(context).size.width*0.55,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      Text("Name # ${user_Data[0]["username"].toString()}",style: TextStyle(fontSize: 18,color: Color.fromARGB(255, 2, 38, 68)),),
                      Text("Reg No #  ${user_Data[0]["Year"].toString()}",style: TextStyle(fontSize: 18,color: Color.fromARGB(255, 2, 38, 68)),),
                      Text("Contact No # ${user_Data[0]["Phone_Number"].toString()}",style: TextStyle(fontSize: 18,color: Color.fromARGB(255, 2, 38, 68)),),
                      
                      Text("Email #  ${user_Data[0]["email"].toString()}",style: TextStyle(fontSize: 18,color: Color.fromARGB(255, 2, 38, 68)),),
                      Text("Password #  ${user_Data[0]["password"].toString()}",style: TextStyle(fontSize: 18,color: Color.fromARGB(255, 2, 38, 68)),),
                     
                    ],
                  ),
                ),
              ],
            ),
    
          ),
        ):
        Center(
                    child: SizedBox(
                      width: 50,
                      height:50,
                      child: CircularProgressIndicator(
                        backgroundColor: Color.fromARGB(255, 7, 219, 219),
                        strokeWidth: 10,
                       color: Color.fromARGB(255, 4, 2, 121),
                      ),
                    ))
        ,
    
      ),
    );
  }
}