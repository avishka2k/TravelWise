import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:travelwise/firebase/fire_storage.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final DatabaseReference _locationRef =
      FirebaseDatabase.instance.ref().child('locations');

  String userId = 'aKMtrNWZTeStNCzYN506nB9QP563';

  User? user = FirebaseAuth.instance.currentUser;

  late StreamSubscription<Position> positionStream;
  late Marker userMarker;

  @override
  void initState() {
    super.initState();
   
    positionStream = Geolocator.getPositionStream().listen((Position position) {
      if (position != null) {
        updateFirebaseLocation(position.latitude, position.longitude);
      }
    });

    userMarker = Marker(
      markerId: MarkerId('user_location'),
      position: LatLng(0, 0), // Initialize with default position
      infoWindow: InfoWindow(title: 'User Location'),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
    );
  }

  void updateFirebaseLocation(double latitude, double longitude) {
    _locationRef.child(user!.uid).set({
      'latitude': latitude,
      'longitude': longitude,
    });
  }

  @override
  void dispose() {
    positionStream.cancel();
    super.dispose();
  }

 void listenForLocation(String userId) {
  _locationRef.child(userId).onValue.listen((event) {
    var snapshot = event.snapshot.value;
    if (snapshot != null) {
      double latitude = (snapshot as Map<String, dynamic>)['latitude'] ?? 0.0;
      double longitude = (snapshot)['longitude'] ?? 0.0;
      updateMap(latitude, longitude);
    }
  });
}

//   final FirebaseService _firebaseService = FirebaseService();
// double? latitude;
// double? longitude;
//    @override
//   void initState() {
//     super.initState();
//     _firebaseService.getMeterData().listen((event) {
//       if (event.snapshot.value != null) {
//         final data = event.snapshot.value;
//         setState(() {
//           latitude = data['latitude'] ?? 0.00;
//           longitude = data['longitude'] ?? 0.00;
//         });
//       }
//     }, onError: (error) {
//       // Handle Firebase errors here, e.g., print error message
//       print('Firebase Error: $error');
//     });
//   }


  late GoogleMapController _controller;

  void onMapCreated(GoogleMapController controller) {
    _controller = controller;
  }

  void updateMap(double latitude, double longitude) {
    CameraPosition position = CameraPosition(
      target: LatLng(latitude, longitude),
      zoom: 16.0,
    );
    _controller.animateCamera(CameraUpdate.newCameraPosition(position));
     setState(() {
      userMarker = userMarker.copyWith(
        positionParam: LatLng(latitude, longitude),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New App'),
      ),
      body: Center(
        child: GoogleMap(
          onMapCreated: onMapCreated,
          initialCameraPosition: const CameraPosition(
            target: LatLng(0, 0),
            zoom: 16.0,
          ),
          markers: {userMarker},
        ),
        
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Hello',
        child: const Icon(Icons.location_on),
      ),
    );
  }
}
