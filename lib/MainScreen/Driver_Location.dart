// ignore_for_file: prefer_const_constructors, unused_local_variable, non_constant_identifier_names

import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DriverLocation extends StatefulWidget {
  const DriverLocation({Key? key}) : super(key: key);

  @override
  State<DriverLocation> createState() => DriverLocationState();
}

class DriverLocationState extends State<DriverLocation> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

 @override
  void initState() {
    super.initState();
    check_Loc();
  }

  check_Loc() async {
    print("ok");
    final prefs = await SharedPreferences.getInstance();
    var uid = prefs.getString("Uid");
    DatabaseReference userRef =
        FirebaseDatabase.instance.reference().child('Drivers');

   await userRef.once().then((DatabaseEvent value) {
      print("map check"+value.snapshot.value.toString());
      var data = value.snapshot.value;
      data as Map;
      
      print(data.values.toList()[0]);
      for(var i=0;i<data.values.toList().length;i++){
        if(data.values.toList()[i]["Bus"]!=null){
        print("data"+data.values.toList()[i]["Bus"]["latitude"].toString());
        // if(data[i]["Bus"] !=null){
        //       print("c" + data[i]["Bus"].toString());
        _markers.add(Marker(
            markerId: MarkerId(data.values.toList()[i]["Bus"]["Bus_Numb"].toString()),
            position: LatLng(data.values.toList()[i]["Bus"]["latitude"],data.values.toList()[i]["Bus"]["longitude"]),
            infoWindow: InfoWindow(title:data.values.toList()[i]["Bus"]["Bus_Numb"].toString())));
            setState(() {
              
            });
        // }
      }
      }
     

        


      // }
    });
  }

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(25.4111712, 68.3604306),
    zoom: 14.4746,
  );


  // ignore: prefer_final_fields
  List<Marker> _markers = <Marker>[
    // Marker(
      
    //     markerId: MarkerId("1"),
    //     position: LatLng(27.9483339, 67.0536799),
    //     infoWindow: InfoWindow(title: "My Current location"))
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
            appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text("All Bus Track" ,style: TextStyle(fontSize: 22,
              fontWeight: FontWeight.bold
              ,color: Color.fromARGB(255, 6, 2, 233),),)),
        body: SafeArea(
          child: GoogleMap(
            mapType: MapType.normal,
            markers: Set<Marker>.of(_markers),
            initialCameraPosition: _kGooglePlex,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
          ),
        ),
        // floatingActionButton: FloatingActionButton.extended(
        //   onPressed: _goToTheLake,
        //   label: const Text('To the lake!'),
        //   icon: const Icon(Icons.directions_boat),
        // ),
      ),
    );
  }

  // Future<void> _goToTheLake() async {
  //   final GoogleMapController controller = await _controller.future;
  //   controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  // }
}
