// ignore_for_file: prefer_const_constructors, prefer_final_fields, avoid_print

import 'dart:async';
// import 'dart:math';
import 'dart:math' as math;

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:label_marker/label_marker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DriverLocationSpefic extends StatefulWidget {
  var Data;
  var Uid;
  DriverLocationSpefic(this.Data, this.Uid);
  // const DriverLocationSpefic({Key? key}) : super(key: key);

  @override
  State<DriverLocationSpefic> createState() =>
      DriverLocationSpeficState(Data, Uid);
}

class DriverLocationSpeficState extends State<DriverLocationSpefic> {
  var Data;
  var Uid;
  DriverLocationSpeficState(this.Data, this.Uid);
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  List<LatLng> polylineCoordinates = [];

  BitmapDescriptor markerIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor markerIcon2 = BitmapDescriptor.defaultMarker;

  void addCustomIcon() {
    BitmapDescriptor.fromAssetImage(
      ImageConfiguration(
          // size: GoogleM,
          ),
      'images/bus (1).png',
    ).then((icon) {
      setState(() {
        markerIcon = icon;
      });
    });
  }

  void addCustomIcon2() {
    BitmapDescriptor.fromAssetImage(
      ImageConfiguration(
          // size: GoogleM,
          ),
      'images/graduated.png',
    ).then((icon) {
      setState(() {
        markerIcon2 = icon;
      });
    });
  }

  final Set<Marker> _markers = {};
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
    gouser();

    getdata();

    addCustomIcon();

    addCustomIcon2();

    // startTimer();
  }

  //   Timer? timer;

  // var time_check = false;

  //  startTimer() {
  //     timer = Timer.periodic(const Duration(seconds: 60), (timer) {
  //       if (time_check== true) {
  //         cancelTimer();
  //       }
  //       else{
  //         // update_location();
  //          getdata();

  //       }
  //     });
  //   }

  // cancelTimer() {
  //   timer!.cancel();
  // }

  getdata() async {
    print("+++++++++++");
    DatabaseReference userRef =
        FirebaseDatabase.instance.reference().child('Drivers');

    await userRef.child(Uid).once().then((value) {
      // print(value.snapshot.value);
      var Datat = value.snapshot.value as Map;
      print(Datat["Bus"]["longitude"]);

      Data["longitude"] = Datat["Bus"]["longitude"];
      Data["latitude"] = Datat["Bus"]["latitude"];
    });

    await checkUserLoc();
  }

  void getPolyPoints() async {
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      "AIzaSyDQ2c_pOSOFYSjxGMwkFvCVWKjYOM9siow", // Your Google Map Key
      PointLatLng(latlng[0].latitude, latlng[0].longitude),
      PointLatLng(latlng[1].latitude, latlng[1].longitude),
    );
    if (result.points.isNotEmpty) {
      result.points.forEach(
        (PointLatLng point) => polylineCoordinates.add(
          LatLng(point.latitude, point.longitude),
        ),
      );
      // for (int i = 0; i < latlng.length; i++) {

      print("call");

      _polyline.add(Polyline(
          polylineId: PolylineId("Route"),
          visible: true,
          color: Color.fromARGB(255, 21, 155, 218),
          points: polylineCoordinates,
          width: 4));
      // }

      setState(() {});
    }
  }

  gouser() async {
    GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
        // on below line we have given positions of Location 5
        CameraPosition(
      target: latlng[0],
      zoom: 14,
    )));
    setState(() {});
  }

  checkUserLoc() async {
    await _getLocationPermission().whenComplete(() async {
      await getlocation().then((value) async {
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
            markerId: MarkerId("ID 1"),
            position: latlng[i],
            infoWindow: InfoWindow(
              title: "Your Location ".toString(),
              //  snippet: 'Bus No # ${Data["Bus_Numb"]}',
            )));
      } else {
        _markers.add(Marker(
            //  icon: markerIcon,
            markerId: MarkerId("ID 2"),
            position: latlng[i],
            infoWindow: InfoWindow(
              title: "Driver Location ".toString(),
              snippet: 'Bus No # ${Data["Bus_Numb"]}',
            )));

        // var data =  Geolocator.distanceBetween(latlng[0].latitude, latlng[0].longitude, latlng[1].latitude, latlng[1].longitude);
        // print(data);
        var lon1 = latlng[0].longitude * math.pi / 180;
        var lon2 = latlng[1].longitude * math.pi / 180;
        var lat1 = latlng[0].latitude * math.pi / 180;
        var lat2 = latlng[1].latitude * math.pi / 180;

        var dlon = lon2 - lon1;
        var dlat = lat2 - lat1;
        var a = math.pow(math.sin(dlat / 2), 2) +
            math.cos(lat1) * math.cos(lat2) * math.pow(math.sin(dlon / 2), 2);

        var c = 2 * math.asin(math.sqrt(a));

        // Radius of earth in kilometers. Use 3956
        // for miles
        var r = 6371;

        var chk = int.parse((c * r).toString().split(".")[0]);

        // calculate the result
        // ignore: prefer_interpolation_to_compose_strings
        print("Dtaa :" + (c * r).toString());
        math.Random random = math.Random();

        var _randomNumber1 = random.nextInt(50);
        var hours = 0;
        var minutes = 0;

        if (chk >= 100) {
          _randomNumber1 = _randomNumber1 + 120;
          // if(_randomNumber1>)
          hours = _randomNumber1 ~/ 60;
          minutes = _randomNumber1 % 60;
        } else if (chk < 50 && chk > 20) {
          _randomNumber1 = _randomNumber1 + 60;
          hours = _randomNumber1 ~/ 60;
          minutes = _randomNumber1 % 60;
        } else if (chk < 20 && chk > 10) {
          _randomNumber1 = 15;

          minutes = _randomNumber1 % 60;
        } else if (chk < 10 && chk > 5) {
          _randomNumber1 = 20;

          minutes = _randomNumber1 % 60;
        }
        //  else if(){}

        else {
          _randomNumber1 = 0;

          minutes = _randomNumber1 % 60;
        }

        _markers.addLabelMarker(LabelMarker(
            //  icon: markerIcon,+
            label:
                "Distance : ${(c * r).toString().split(".")[0]}km\nTime : ${hours == 0 ? "" : hours.toString() + "h"} $minutes  mins",
            markerId: MarkerId("gff"),
            position: LatLng(Data["latitude"], Data["longitude"]),
            backgroundColor: Color.fromARGB(255, 3, 116, 37)
            // infoWindow: InfoWindow(
            //   title: "Driver Location 2 ".toString(),
            //   snippet: 'Bus No # ${Data["Bus_Numb"]}',
            // ))
            ));
      }
      setState(() {});

      getPolyPoints();

      //  24.9480507  25.23456
      // 67.0536539  68.6573
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
  // List<Marker> _markers = <Marker>[];

  _willPopCallback() async {
    // await  cancelTimer();
    // ignore: use_build_context_synchronously
    return Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _willPopCallback(),
      child: Scaffold(
        appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => Navigator.of(context).pop(),
            ),
            backgroundColor: Colors.white,
            centerTitle: true,
            title: Text(
              "Bus Location",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 4, 2, 122),
              ),
            )),
        body: latlng.isNotEmpty
            ? SafeArea(
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
              )
            : Center(
                child: SizedBox(
                width: 50,
                height: 50,
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


// 25.392836,68.3672198 hyd
//25.3951721,68.36307smit

//25.392836,68.3672198
//25.4100074,68.385263
