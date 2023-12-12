// ignore_for_file: avoid_print

import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';

class GetUserLocation extends StatefulWidget {
  const GetUserLocation({Key? key}) : super(key: key);

  @override
  State<GetUserLocation> createState() => _GetUserLocationState();
}

class _GetUserLocationState extends State<GetUserLocation> {
  LocationData? currentLocation;
  late Timer locationUpdateTimer;

  void uploadLocation() async {
    if (currentLocation != null) {
      DatabaseReference ref =
          FirebaseDatabase.instance.ref("locations/aKMtrNWZTeStNCzYN506nB9QP563");

      await ref.set({
        "latitude": currentLocation!.latitude,
        "longitude": currentLocation!.longitude,
      });
    }
  }

  void getCurrentLocation() async {
    Location location = Location();

    bool serviceEnabled;
    PermissionStatus permissionGranted;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    try {
      LocationData locationData = await location.getLocation();
      setState(() {
        currentLocation = locationData;
        uploadLocation(); 
      });
    } catch (e) {
      print("Error getting location: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    getCurrentLocation();
    locationUpdateTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      getCurrentLocation();
    });
  }

  @override
  void dispose() {
    locationUpdateTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: currentLocation == null
          ? const Center(child: Text("Loading..."))
          : const Text('hiii'),
    );
  }
}
