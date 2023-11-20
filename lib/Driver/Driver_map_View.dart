// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MapSample extends StatefulWidget {
  const MapSample({Key? key}) : super(key: key);

  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
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

    await userRef.child(uid.toString()).once().then((DatabaseEvent value) {
      print("map check" + value.snapshot.value.toString());
      var data = value.snapshot.value;
      data as Map;
      print(data["Bus"]);
      if (data["Bus"] != null) {
        print("c" + data["Bus"]["Bus_Numb"].toString());

        // _markers.add(Marker(
        //     markerId: MarkerId("2"),
        //     position: LatLng(data["Bus"]["latitude"],data["Bus"]["longitude"]),
        //     infoWindow: InfoWindow(title: "My Current location 1")));
        //     setState(() {

        //     });
      }
    });
  }

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(22.9483339, 67.0536799),
    zoom: 14.4746,
  );

  // static const CameraPosition _kLake = CameraPosition(
  //     bearing: 192.8334901395799,
  //     target: LatLng(37.43296265331129, -122.08832357078792),
  //     tilt: 59.440717697143555,
  //     zoom: 19.151926040649414);

  // ignore: prefer_final_fields
  List<Marker> _markers = <Marker>[
    Marker(
        markerId: MarkerId("1"),
        position: LatLng(27.9483339, 67.0536799),
        infoWindow: InfoWindow(title: "My Current location"))
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
