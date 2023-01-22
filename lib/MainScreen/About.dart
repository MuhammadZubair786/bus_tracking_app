// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: AppBar(
              backgroundColor: Colors.white,
              centerTitle: true,
              // ignore: prefer_const_constructors
              title: Text(
                "About ",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold
                  // ignore: prefer_const_constructors
                  ,
                  color: Color.fromARGB(255, 6, 2, 233),
                ),
              )),
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: Text("Supervisor : Ms Farah Naveen",
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                ),
                SingleChildScrollView(
                  child: Row(
                    children: [
                      SizedBox(
                        height: 30,
                      ),
                      MakeCont(context,"images/img1.jpeg","Sooraj Hamirani","2K18/IT/172"),
                      MakeCont(context,"images/img2.jpeg","Santosh Kumar","2K18/IT/154"),
                      
                    ],
                  ),
                ),
                Row(
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    MakeCont(context,"images/img3.jpeg","Adresh Kumar","2K18/IT/15"),
                    MakeCont(context,"images/img4.jpeg","Shafaat Ali","2K18/IT/161"),
                    
                     
                  ],
                ),
              ],
            ),
          )),
    );
  }

  Container MakeCont(BuildContext context,String img,String name,String Rollno) {
    return Container(
                    margin: EdgeInsets.all(5),
                    
                    width: MediaQuery.of(context).size.width * 0.45,
                    // width: MediaQuery.of(context).size.width * 0.45,
                    height: MediaQuery.of(context).size.width * 0.48,
                    child: Card(
                     elevation: 10,
  shadowColor: Colors.green,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(12.0),
  ),
                      child: Column(
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          Image.asset(img,
                          height: 100,
                          ),
                          Text("Name : ${name}",style: TextStyle(fontWeight: FontWeight.bold),),
                          Text("Roll No : ${Rollno}",style: TextStyle(fontWeight: FontWeight.bold),)
                        ],
                      ),
                    ),
                  );
  }
}
