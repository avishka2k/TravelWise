import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as loc;
import 'package:permission_handler/permission_handler.dart';

class LocationBackground extends StatefulWidget {
  const LocationBackground({super.key});

  @override
  State<LocationBackground> createState() => _LocationBackgroundState();
}

class _LocationBackgroundState extends State<LocationBackground> {
  List<LatLng> polylineCoordinates = [];
  loc.LocationData? currentLocation;
  BitmapDescriptor currentLocationIcon = BitmapDescriptor.defaultMarker;

  void uploadLocation(loc.LocationData? currentLocation) async {
    User? user = FirebaseAuth.instance.currentUser;

    if (currentLocation != null) {
      DatabaseReference ref =
          FirebaseDatabase.instance.ref("locations/${user!.uid}");

      await ref.set({
        "latitude": currentLocation.latitude,
        "longitude": currentLocation.longitude,
      });
    }
  }

  void getCurrentLocation() async {
    loc.Location location = loc.Location();
    bool serviceEnabled;
    PermissionStatus permissionGranted;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = (await location.hasPermission()) as PermissionStatus;
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = (await location.requestPermission()) as PermissionStatus;
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    location.getLocation().then(
      (locationData) {
        setState(() {
          currentLocation = locationData;
        });
      },
    );

    location.onLocationChanged.listen((newLocation) {
      currentLocation = newLocation;
      uploadLocation(newLocation);
      setState(() {});
    });
  }


  String text = "Stop Service";
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Service App'),
        ),
        body: Column(
          children: [
            StreamBuilder<Map<String, dynamic>?>(
              stream: FlutterBackgroundService().on('update'),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                final data = snapshot.data!;
                String? device = data["device"];
                DateTime? date = DateTime.tryParse(data["current_date"]);
                return Column(
                  children: [
                    Text(device ?? 'Unknown'),
                    Text(date.toString()),
                  ],
                );
              },
            ),
            ElevatedButton(
              child: const Text("Foreground Mode"),
              onPressed: () {
                FlutterBackgroundService().invoke("setAsForeground");
              },
            ),
            ElevatedButton(
              child: const Text("Background Mode"),
              onPressed: () {
                FlutterBackgroundService().invoke("setAsBackground");
              },
            ),
            ElevatedButton(
              child: Text(text),
              onPressed: () async {
                final service = FlutterBackgroundService();
                var isRunning = await service.isRunning();
                if (isRunning) {
                  service.invoke("stopService");
                } else {
                  service.startService();
                }

                if (!isRunning) {
                  text = 'Stop Service';
                } else {
                  text = 'Start Service';
                }
                setState(() {});
              },
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: const Icon(Icons.play_arrow),
        ),
      ),
    );
  }
}

