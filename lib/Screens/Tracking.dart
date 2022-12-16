// ignore_for_file: prefer_const_constructors

import 'package:bus_tracking_app/Screens/Home.dart';
import 'package:bus_tracking_app/Screens/LoginScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class TrackingScreen extends StatefulWidget {
  const TrackingScreen({super.key});

  @override
  State<TrackingScreen> createState() => _TrackingScreenState();
}

class _TrackingScreenState extends State<TrackingScreen> {



  

 List Bus_List =[
  {"Time":"7pm to 10pm ",
  "route":"Data 1 to data 2",

  },
  {"Time":"7pm ",
  "route":"Data 2 to data 3",

  },
  {"Time":"7pm ",
  "route":"Data 3 to data 4",

  },
  {"Time":"7pm to 10pm ",
  "route":"Data 1 to data 2",

  },
  {"Time":"7pm ",
  "route":"Data 2 to data 3",

  },
  {"Time":"7pm ",
  "route":"Data 3 to data 4",

  },
   {"Time":"7pm ",
  "route":"Data 2 to data 3",

  },
  {"Time":"7pm ",
  "route":"Data 3 to data 4",

  },
   {"Time":"7pm ",
  "route":"Data 2 to data 3",

  },
  {"Time":"7pm ",
  "route":"Data 3 to data 4",

  }
 ];



  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: SafeArea(
          child:Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
          child: Image.network("https://external-preview.redd.it/0ykEElItI4Pnj-i_XG4bwFUmOlPQvC_ZXvS7Mg7IXc4.jpg?auto=webp&s=cfe3b75dcb8397068d84e96f583baa58068d6517",
          fit: BoxFit.cover,
          ),
          )),
         
           
    );
  }
 

}