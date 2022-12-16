// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors

import 'package:bus_tracking_app/Screens/HomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class LoginClass extends StatefulWidget {
  const LoginClass({super.key});

  @override
  State<LoginClass> createState() => _LoginClassState();
}

class _LoginClassState extends State<LoginClass> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login",style: TextStyle(fontFamily: "ButtonMelian"),),
        backgroundColor: Color.fromARGB(255, 2, 135, 75),
        // centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: Color.fromARGB(255, 101, 223, 105),
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Container(
                  padding: EdgeInsets.all(1),
                  // margin: EdgeInsets.all(10),
                  child: CircleAvatar(
                    radius: 100.0,
                    backgroundImage: NetworkImage("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSFWzcuZ3SWOLcG0hXPjWQBAOe2ErMBUAkXNQ&usqp=CAU"),
                    backgroundColor: Colors.greenAccent,
                  ),
                ),
                SizedBox(height: 40,),
                
                // MakeTextField("Enter Your Name",Icon(Icons.verified)),
                // MakeTextField("Enter Your Roll No",Icon(Icons.receipt_long_outlined)),
        
                MakeTextField("Enter Your Email",Icon(Icons.email)),
                MakeTextField("Enter Your Password",Icon(Icons.password)),
                SizedBox(height: 10,),

                // ElevatedButton(
                //   onPressed: () {},
                //   style: ElevatedButton.styleFrom(
                //       primary: Color.fromARGB(255, 1, 70, 10)),
                //   child: Icon(Icons.upload_file_sharp)),
                // MakeTextField("Enter Your "),
                ElevatedButton(
                  
                  onPressed: () {
                    Navigator.push(context,MaterialPageRoute(builder: (context)=>HomeScreen()));
                  },
                  style: ElevatedButton.styleFrom(
                      primary: Color.fromARGB(255, 0, 134, 76)),
                  child: Text(
                    "Sign In",
                    style: TextStyle(fontSize: 25, fontFamily: "ButtonMelian"),
                  )),

        
              ],
            ),
          ),
        ),
      ),
    );
  }

    Container MakeTextField(String c1,Icon c2) {
    return Container(
      height: 80,
      child: Padding(
                padding: EdgeInsets.all(10),
                child: TextField(
                  
                  decoration: InputDecoration(
                    prefixIcon:
                 IconButton(onPressed: () {}, icon:c2),
            //  suffixIcon: IconButton(
            //    icon: Icon(Icons.arrow_drop_down_circle),
            //    onPressed: () {},
            //  ),
                    filled: true, //<-- SEE HERE
                    fillColor: Color.fromARGB(255, 225, 232, 229),
                      enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        style: BorderStyle.solid,
                        width: 1,color: Color.fromARGB(255, 58, 1, 202)
                      ),
                      
                        borderRadius: BorderRadius.circular(40)),
                       focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        style: BorderStyle.solid,
                        width: 1,color: Color.fromARGB(255, 58, 1, 202)
                      ),),
                    // labelText: 'User Name',
                    hintText: c1,
                  ),
                  
                  style: TextStyle(color: Colors.pinkAccent),
                ),
              ),
    );
  }
}
