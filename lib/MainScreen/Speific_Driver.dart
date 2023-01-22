// ignore_for_file: prefer_const_constructors, prefer_final_fields

import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DriverLocationSpefic extends StatefulWidget {
  var Data;
  DriverLocationSpefic(this.Data);
  // const DriverLocationSpefic({Key? key}) : super(key: key);

  @override
  State<DriverLocationSpefic> createState() => DriverLocationSpeficState(Data);
}

class DriverLocationSpeficState extends State<DriverLocationSpefic> {
  var Data;
  DriverLocationSpeficState(this.Data);
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

      BitmapDescriptor markerIcon =BitmapDescriptor.defaultMarker;
      BitmapDescriptor markerIcon2 =BitmapDescriptor.defaultMarker;


      void addCustomIcon(){
         BitmapDescriptor.fromAssetImage(ImageConfiguration(
          // size: GoogleM,
         ),   'images/bus (1).png',)
         .then((icon){
          setState(() {
            markerIcon=icon;
          });

         })
         ;
      }

       void addCustomIcon2(){
         BitmapDescriptor.fromAssetImage(ImageConfiguration(
          // size: GoogleM,
         ),   'images/graduated.png',)
         .then((icon){
          setState(() {
            markerIcon2=icon;
          });

         })
         ;
      }

  // final Set<Marker> _markers = {};
  Position? currentLocation;
  final Set<Polyline> _polyline = {};

  CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(25.4111504, 68.3603602),
    zoom: 14.4746,
  );

  List<LatLng> latlng = [
    // LatLng(33.739045, 73.084488),
    // LatLng(33.569975, 72.635997456),
  ];

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

  @override
  void initState() {
    super.initState();
    addCustomIcon();
    addCustomIcon2();
    checkUserLoc();
    // check_Loc();

    // for (int i = 0; i < latlng.length; i++) {
    //   // print(latlng[i]);
    //   // _markers.add(Marker(
    //   //     markerId: MarkerId(Data["Bus_Numb"].toString()),
    //   //     position: latlng[i],
    //   //     infoWindow: InfoWindow(title:Data["Bus_Numb"].toString())));
    //   // setState(() {

    //   // });

    //   //     _polyline.add(Polyline(
    //   //   polylineId: PolylineId(i.toString()),
    //   //   visible: true,
    //   //   //latlng is List<LatLng>
    //   //   points: latlng,
    //   // //  points: latlng[i],

    //   //   color: Colors.blue,
    //   // ));

    // }
  }

  checkUserLoc() async {
    await _getLocationPermission().whenComplete(() async {
      await getlocation().then((value) {
        currentLocation = value;

        latlng
            .add(LatLng(currentLocation!.latitude, currentLocation!.longitude));
        latlng.add(LatLng(Data["latitude"], Data["longitude"]));

        setState(() {});
      });
    });
    for (int i = 0; i < latlng.length; i++) {
      print(latlng[i]);
      if (i == 0) {
        _markers.add(Marker(
          // icon: markerIcon2,
            markerId: MarkerId(latlng[i].toString()),
            position: latlng[i],
            infoWindow: InfoWindow(
              title: "Your Location ".toString(),
              //  snippet: 'Bus No # ${Data["Bus_Numb"]}',
            )));
          
      } else {
        _markers.add(Marker(
          //  icon: markerIcon,
            markerId: MarkerId(latlng[i].toString()),
            position: latlng[i],
            infoWindow: InfoWindow(
              title: "Driver Location ".toString(),
              snippet: 'Bus No # ${Data["Bus_Numb"]}',
            )));
      }

      _polyline.add(Polyline(
        polylineId: PolylineId(i.toString()),
        visible: true,
        //latlng is List<LatLng>
        points: latlng,

        color: Color.fromARGB(255, 8, 151, 8),
      ));
    }
  }

  Future getlocation() async {
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  check_Loc() async {
    print("ok");

    print(Data['latitude'].toString());

    _markers.add(Marker(
        markerId: MarkerId(Data["Bus_Numb"].toString()),
        position: LatLng(Data["latitude"], Data["longitude"]),
        infoWindow: InfoWindow(title: Data["Bus_Numb"].toString())));
    setState(() {});
  }

  // ignore: prefer_final_fields
  List<Marker> _markers = <Marker>[];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child:  Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.white,
            centerTitle: true,
            title: Text(
              "Bus Location",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 6, 2, 233),
              ),
            )),
        body: 
        latlng.isNotEmpty ?  SafeArea(
          child: GoogleMap(
            myLocationEnabled: true,
            mapType: MapType.normal,
            polylines: _polyline,
            markers: Set<Marker>.of(_markers),
            initialCameraPosition: _kGooglePlex,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
          ),
        ):Center(
                    child: SizedBox(
                      width: 50,
                      height:50,
                      child: CircularProgressIndicator(
                        backgroundColor: Color.fromARGB(255, 7, 219, 219),
                        strokeWidth: 10,
                       color: Color.fromARGB(255, 4, 2, 121),
                      ),
                    )),
        floatingActionButton: latlng.length != 0
            ? FloatingActionButton(
                onPressed: () async {
                  GoogleMapController controller = await _controller.future;
                  controller.animateCamera(CameraUpdate.newCameraPosition(
                      // on below line we have given positions of Location 5
                      CameraPosition(
                    target: latlng[0],
                    zoom: 14,
                  )));
                  setState(() {});
                },
                // on below line we have set icon for button
                child: Icon(Icons.location_disabled_outlined),
              )
            : Text(""),
      ),
    );
  }
}
