// ignore_for_file: depend_on_referenced_packages, prefer_const_constructors

import 'dart:async';

import 'package:bus_tracking_app/Driver/Driver_map_View.dart';
import 'package:bus_tracking_app/Login/loginscreen.dart';
import 'package:bus_tracking_app/components/colors.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Driver_Navigation extends StatefulWidget {
  const Driver_Navigation({super.key});

  @override
  State<Driver_Navigation> createState() => _Driver_NavigationState();
}

class _Driver_NavigationState extends State<Driver_Navigation> {
  Future _getLocationPermission() async {
    if (await Permission.locationWhenInUse.request().isGranted) {
      setState(() {
        PermissionStatus.granted;
      });
    } else if (await Permission.locationWhenInUse
        .request()
        .isPermanentlyDenied) {
      await openAppSettings();
    } else if (await Permission.locationWhenInUse.request().isDenied) {
      setState(() {
        PermissionStatus.denied;
      });
    }
  }

  Position? currentLocation;

  var time = "00:00";

  var status = false;

  var check = false;
  TextEditingController DriverContact = TextEditingController();
  TextEditingController busnumb = TextEditingController();
  TextEditingController busroute = TextEditingController();
  // TextEditingController Time = TextEditingController();
  TimeOfDay initialTime = TimeOfDay.now();

  Time_pick() async {
    DatePicker.showTime12hPicker(context, showTitleActions: true,
        onChanged: (date) {
      print('change $date in time zone ${date.timeZoneOffset.inHours}');
    }, onConfirm: (date) {
      print('confirm ${date.toString().substring(10, 16)}');

      setState(() {
        time = date.toString().substring(10, 16);
      });
    }, currentTime: DateTime.now());
  }

  List Listdata = [];

  checkdata() async {
    Listdata = [];
    final prefs = await SharedPreferences.getInstance();
    var uid = prefs.getString("Uid");
    DatabaseReference userRef =
        FirebaseDatabase.instance.reference().child('Drivers');

    await userRef.child(uid.toString()).once().then((DatabaseEvent value) {
      print(value.snapshot.value);
      var data = value.snapshot.value;
      data as Map;
      print(data["Bus"]);
      if (data["Bus"] != null) {
        print("c" + data["Bus"]["Bus_Numb"].toString());
        Listdata.add(data["Bus"]);
        check = true;
        // Listdata.add(data);

        setState(() {});
        print(Listdata);
        if (Listdata[0]["Status"] == "Active") {
          status = true;
        }
        setState(() {});
      } else {
        check = false;
        setState(() {});
      }
    });
  }

 

  Future getlocation() async {
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  Timer? timer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getLocationPermission().whenComplete(() {
      getlocation().then((value) {
        setState(() {
          currentLocation = value;
        });
        print("call" + currentLocation.toString());
      });
    });
    checkdata();

    DatabaseReference userRef =
            FirebaseDatabase.instance.reference().child('Drivers');
   
      timer =
          Timer.periodic(Duration(seconds: 5), (Timer t) => update_location());
   
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  update_location() {
    _getLocationPermission().whenComplete(() {
      getlocation().then((value) async {
        // setState(() {
          currentLocation = value;
        // });

if(check==true){
        final prefs = await SharedPreferences.getInstance();
        var uid = prefs.getString("Uid");

        DatabaseReference userRef =
            FirebaseDatabase.instance.reference().child('Drivers');

        await userRef.child(uid.toString()).child("Bus").update({
          // "Driver_Contact":DriverCont,
          "longitude": currentLocation!.longitude,
          "latitude": currentLocation!.latitude,
        });
        print("call v" + currentLocation.toString());
      }
      else{
        print("No bus assign " );
      }
      });
    });
  }




  update_Status() async {
    final prefs = await SharedPreferences.getInstance();
    var uid = prefs.getString("Uid");

    DatabaseReference userRef =
        FirebaseDatabase.instance.reference().child('Drivers');

    await userRef.child(uid.toString()).child("Bus").update({
      // "Driver_Contact":DriverCont,

      "Status": "Active"
    });

    status = true;
    
      timer =
          Timer.periodic(Duration(seconds: 35), (Timer t) => update_location());
   

    checkdata();
  }

  Add_bus() async {
    // var Busname = busname.text;
    var BusNumb = busnumb.text;
    var BusRoute = busroute.text;
    var BusTime = time.toString();
    var DriverCont = DriverContact.text;

    if (BusRoute.length > 0 && BusRoute.length > 0 && BusNumb.length > 0) {
      print(currentLocation);
      print(currentLocation!.longitude);
      print(currentLocation!.speed);
      final prefs = await SharedPreferences.getInstance();
      var uid = prefs.getString("Uid");
      print("ok");

      DatabaseReference userRef =
          FirebaseDatabase.instance.reference().child('Drivers');

      await userRef.child(uid.toString()).child("Bus").update({
        // "Driver_Contact":DriverCont,
        "Bus_Numb": BusNumb,
        "Bus_Route": BusRoute,
        "Bus_Time": BusTime,
        "longitude": currentLocation!.longitude,
        "latitude": currentLocation!.latitude,
        "Speed": currentLocation!.speed,
        "Status": "Inactive"
      });

      Fluttertoast.showToast(
          msg: "Add Bus SuccessFully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 5,
          backgroundColor: Color.fromARGB(255, 30, 6, 121),
          textColor: Colors.white,
          fontSize: 16.0);

      checkdata();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            appBar: AppBar(
              backgroundColor: Color.fromARGB(255, 30, 6, 121),
              title: Text("SAU BUS TRACKER"),
              centerTitle: true,
            ),
            drawer: Drawer(
              child: ListView(
                children: [
                  DrawerHeader(
                      child: Container(
                    width: 300.0,
                    height: 500.0,
                    color: Color.fromARGB(255, 30, 6, 121),
                    child: Center(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: Icon((Icons.supervised_user_circle_rounded)),
                          color: Colors.white,
                          iconSize: 60,
                          onPressed: () {},
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              ("driver"),
                              style: TextStyle(color: Colors.white),
                            ),
                            Text(
                              ("driver@gmail.com"),
                              style: TextStyle(color: Colors.white),
                            )
                          ],
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
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MapSample()));
                          // Navigator.pop(context);
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(builder: (context)=>Home()));
                        },
                        child: ListTile(
                            leading: IconButton(
                              icon: Icon((Icons.home)),
                              color: Color.fromARGB(255, 30, 6, 121),
                              iconSize: 30,
                              onPressed: () {},
                            ),
                            title: Text("Home")),
                      ),

                      //  GestureDetector(onTap:(){
                      //   // Navigator.pop(context);
                      //   // Navigator.push(
                      //   //   context,
                      //   //   MaterialPageRoute(builder: (context)=>Services()));
                      // },
                      // child:  ListTile(
                      //   leading:   IconButton(
                      //     icon: Icon((Icons.home)),
                      //     color:Color.fromARGB(255, 30, 6, 121),
                      //     iconSize: 30,
                      //     onPressed: () {},
                      //   ),
                      //   title: Text("Services")

                      // ),
                      // ),
                      ListTile(
                          leading: IconButton(
                            icon: Icon((Icons.contact_page)),
                            color: Color.fromARGB(255, 30, 6, 121),
                            iconSize: 30,
                            onPressed: () {},
                          ),
                          title: Text("Contact")),
                      ListTile(
                          leading: IconButton(
                            icon: Icon((Icons.app_blocking_rounded)),
                            color: Color.fromARGB(255, 30, 6, 121),
                            iconSize: 30,
                            onPressed: () {},
                          ),
                          title: Text("About")),

                      ListTile(
                          leading: IconButton(
                            icon: Icon((Icons.settings_sharp)),
                            color: Color.fromARGB(255, 30, 6, 121),
                            iconSize: 30,
                            onPressed: () {},
                          ),
                          title: Text("Setting")),
                      GestureDetector(
                        onTap: () async {
                          final prefs = await SharedPreferences.getInstance();
                          prefs.clear();
                          // ignore: use_build_context_synchronously
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => BHLoginScreen()));
                        },
                        child: ListTile(
                            leading: IconButton(
                              icon: Icon((Icons.login_outlined)),
                              color: Color.fromARGB(255, 30, 6, 121),
                              iconSize: 30,
                              onPressed: () async {
                                final prefs =
                                    await SharedPreferences.getInstance();
                                prefs.clear();
                                // ignore: use_build_context_synchronously
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => BHLoginScreen()));
                              },
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
              child: Center(
                  child: check
                      ? Column(
                          // ignore: prefer_const_literals_to_create_immutables
                          children: [
                            // Text(
                            //   "Not  !",
                            //   style: TextStyle(
                            //       fontSize: 30,
                            //       fontWeight: FontWeight.bold,
                            //       color: Colors.purple),
                            // ),
                            ListView.builder(
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Image.asset(
                                          "images/new.png",
                                          height: 260,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.95,
                                          fit: BoxFit.cover,
                                          // ,color: Color.fromARGB(255, 19, 18, 18).withOpacity(0.2),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          "Bus Number : ${Listdata[0]["Bus_Numb"]} ",
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          "Bus Time : ${Listdata[0]["Bus_Time"]} ",
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          "Bus Route : ${Listdata[0]["Bus_Route"]} ",
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          "State: ${Listdata[0]["Status"]} ",
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        ElevatedButton(
                                            onPressed: () {
                                              update_Status();
                                            },
                                            child: Text("Runing State"))
                                      ],
                                    ),
                                  ),
                                );
                              }),
                            )
                          ],
                        )
                      : Column(
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              child: Text(
                                "Assign Bus",
                                style: TextStyle(
                                    color: Colors.purple, fontSize: 25),
                              ),
                            ),
                            // BuildTextField("Bus Name",Icons.phone_android,DriverContact),
                            SizedBox(
                              height: 10,
                            ),
                            BuildTextField(
                                "Bus Number", Icons.bus_alert, busnumb),
                            SizedBox(
                              height: 10,
                            ),
                            BuildTextField(
                                "Bus Route", Icons.bus_alert, busroute),
                            SizedBox(
                              height: 10,
                            ),
                            //   BuildTextField("Timing",Icons.bus_alert,busnumb),
                            //  SizedBox(height: 10,),
                            Container(
                              margin: EdgeInsets.only(left: 20, right: 20),
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 248, 245, 245),
                                  border: Border(
                                      bottom: BorderSide(
                                          width: 1,
                                          color: Color(0xff140967),
                                          style: BorderStyle.solid))),
                              child: IconButton(
                                  onPressed: () {
                                    Time_pick();
                                  },
                                  icon: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    // ignore: prefer_const_literals_to_create_immutables
                                    children: [
                                      Text(
                                        time.toString(),
                                        style: TextStyle(
                                            color: Color.fromARGB(
                                                255, 109, 109, 109)),
                                      ),
                                      Icon(
                                        Icons.timer_rounded,
                                        color: Color(0xff140967),
                                      )
                                    ],
                                  )),
                            ),
                            SizedBox(
                              height: 25,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.80,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.all(17),
                                  primary: Color(0xff140967),
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(20.0)),
                                ),
                                onPressed: () {
                                  Add_bus();
                                },
                                child: const Text(
                                  "Add Bus With Driver",
                                  style: TextStyle(
                                      color: whiteColor,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ],
                        )),
            )));
  }

  Container BuildTextField(
      String placeholder, IconData icn, TextEditingController data) {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20),
      child: TextFormField(
        controller: data,
        // focusNode: emailFocusNode,
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.next,
        // onFieldSubmitted: (value) {
        //   FocusScope.of(context)
        //       .requestFocus(passwordFocusNode);
        // },
        style: primaryTextStyle(),
        decoration: InputDecoration(
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xff140967))),
          focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xff140967))),
          labelText: placeholder,
          labelStyle: secondaryTextStyle(),
          suffixIcon: GestureDetector(
            onTap: () {
              setState(() {
                // _showPassword = !_showPassword;
              });
            },
            child: Icon(icn, color: Color(0xff140967), size: 20),
          ),
        ),
      ),
    );
  }
}
