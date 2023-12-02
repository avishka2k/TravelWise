import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import '../../constants.dart';

class SampleMap extends StatefulWidget {
  const SampleMap({super.key});

  @override
  State<SampleMap> createState() => _SampleMapState();
}

class _SampleMapState extends State<SampleMap> {
  final Completer<GoogleMapController> _controller = Completer();
  static const LatLng sourceLocation =
      LatLng(6.564735742274157, 80.10231009397853);
  static const LatLng destination = LatLng(6.556959899115021, 80.1062838534939);
  List<LatLng> polylineCoordinates = [];
  LocationData? currentLocation;
  BitmapDescriptor currentLocationIcon = BitmapDescriptor.defaultMarker;

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

    location.getLocation().then(
      (locationData) {
        setState(() {
          currentLocation = locationData;
        });
      },
    );

    location.onLocationChanged.listen((newLocation) {
      currentLocation = newLocation;
      _moveCameraToLocation(newLocation.latitude!, newLocation.longitude!);
      setState(() {});
    });
  }

  void _moveCameraToLocation(double latitude, double longitude) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(
      CameraUpdate.newLatLng(LatLng(latitude, longitude)),
    );
  }

  void getPolyPoint() async {
    PolylinePoints polylinePoints = PolylinePoints();

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      google_api_key,
      PointLatLng(sourceLocation.latitude, sourceLocation.longitude),
      PointLatLng(destination.latitude, destination.longitude),
    );
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) =>
          polylineCoordinates.add(LatLng(point.latitude, point.longitude)));
    }
    setState(() {});
  }

  void setCustomMarker() {
    BitmapDescriptor.fromAssetImage(
            ImageConfiguration.empty, "images/icons/boy-96.png")
        .then(
      (icon) {
        currentLocationIcon = icon;
        setState(() {});
      },
    );
  }

  @override
  void initState() {
    getCurrentLocation();
    getPolyPoint();
    setCustomMarker();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: currentLocation == null
          ? const Center(child: Text("Loading..."))
          : GoogleMap(
              initialCameraPosition: CameraPosition(
                // target: sourceLocation,
                target: LatLng(
                  currentLocation!.latitude!,
                  currentLocation!.longitude!,
                ),
                zoom: 13.5,
              ),
              polylines: {
                Polyline(
                  polylineId: const PolylineId('route'),
                  points: polylineCoordinates,
                  width: 5,
                  color: Colors.black,
                  endCap: Cap.roundCap,
                  startCap: Cap.roundCap,
                )
              },
              markers: {
                Marker(
                  markerId: const MarkerId('current'),
                  icon: currentLocationIcon,
                  infoWindow: const InfoWindow(
                    title: 'Avishka Prabath',
                  ),
                  position: LatLng(
                    currentLocation!.latitude!,
                    currentLocation!.longitude!,
                  ),
                ),
                const Marker(
                  markerId: MarkerId('source'),
                  position: sourceLocation,
                ),
                const Marker(
                  markerId: MarkerId('destination'),
                  position: destination,
                )
              },
              onMapCreated: (controller) {
                _controller.complete(controller);
              },
            ),
    );
  }
}
