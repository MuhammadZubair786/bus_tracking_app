// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class DriverReg extends StatefulWidget {
  const DriverReg({super.key});

  @override
  State<DriverReg> createState() => _DriverRegState();
}

class _DriverRegState extends State<DriverReg> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Driver Register",style: TextStyle(
          fontSize: 30,
          fontFamily: "Nenostyle"),),
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
                  width: MediaQuery.of(context).size.width,
                  // margin: EdgeInsets.all(10),
                  child: CircleAvatar(
                    radius: 120.0,
                    backgroundImage: AssetImage("images/driver.png"),
                    backgroundColor: Color.fromARGB(255, 3, 104, 55),
                    
                  ),
                ),
                SizedBox(height: 30,),
                
                MakeTextField("Enter Your Name",Icon(Icons.verified)),
                MakeTextField("Enter Bus Number",Icon(Icons.bus_alert_outlined)),
                MakeTextField("Enter Your Contact",Icon(Icons.phone)),
                MakeTextField("Enter Your Address",Icon(Icons.location_on)),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                      primary: Color.fromARGB(255, 1, 70, 10)),
                  child: Icon(Icons.upload_file_sharp)),
                // MakeTextField("Enter Your "),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                      primary: Color.fromARGB(255, 0, 134, 76)),
                  child: Text(
                    "Sign Up",
                    style: TextStyle(fontSize: 20, fontFamily: "ButtonMelian"),
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
