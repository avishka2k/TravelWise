import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyMap(),
    );
  }
}

class MyMap extends StatefulWidget {
  @override
  _MyMapState createState() => _MyMapState();
}

class _MyMapState extends State<MyMap> {
  late GoogleMapController mapController;

  final LatLng _center = const LatLng(37.7749, -122.4194);

  Set<Marker> _markers = Set<Marker>();

  Future<Uint8List> getBytesFromNetworkImage(String imageUrl) async {
    final ByteData data =
        await NetworkAssetBundle(Uri.parse(imageUrl)).load("");
    return data.buffer.asUint8List();
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;

    getBytesFromNetworkImage('https://picsum.photos/200/300')
        .then((Uint8List markerIcon) {
      setState(() {
        _markers.add(
          Marker(
            markerId: MarkerId('customMarker'),
            position: _center,
            icon: BitmapDescriptor.fromBytes(markerIcon),
          ),
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: _center,
          zoom: 11.0,
        ),
        markers: _markers,
      ),
    );
  }
}
