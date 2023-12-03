// import 'package:flutter/material.dart';
// import 'package:flutter_background_geolocation/flutter_background_geolocation.dart' as bg;

// class MyWidget extends StatefulWidget {
//   const MyWidget({super.key});

//   @override
//   State<MyWidget> createState() => _MyWidgetState();
// }

// class _MyWidgetState extends State<MyWidget> {
//   // Future<void> updateloc() async {
//   //   Timer.periodic(Duration(seconds: 3), (timer) async {
//   //     Position position = await Geolocator.getCurrentPosition(
//   //         desiredAccuracy: LocationAccuracy.high);
//   //     print(position.latitude);
//   //     print(position.longitude);
//   //   });
//   // }

  
//   @override
//   void initState() {
//     super.initState();

//     ////
//     // 1.  Listen to events (See docs for all 12 available events).
//     //

//     // Fired whenever a location is recorded
//     bg.BackgroundGeolocation.onLocation((bg.Location location) {
//       print('[location] - $location');
//     });

//     // Fired whenever the plugin changes motion-state (stationary->moving and vice-versa)
//     bg.BackgroundGeolocation.onMotionChange((bg.Location location) {
//       print('[motionchange] - $location');
//     });

//     // Fired whenever the state of location-services changes.  Always fired at boot
//     bg.BackgroundGeolocation.onProviderChange((bg.ProviderChangeEvent event) {
//       print('[providerchange] - $event');
//     });

//     ////
//     // 2.  Configure the plugin
//     //
//     bg.BackgroundGeolocation.ready(bg.Config(
//         desiredAccuracy: bg.Config.DESIRED_ACCURACY_HIGH,
//         distanceFilter: 10.0,
//         stopOnTerminate: false,
//         startOnBoot: true,
//         debug: true,
//         logLevel: bg.Config.LOG_LEVEL_VERBOSE
//     )).then((bg.State state) {
//       if (!state.enabled) {
//         ////
//         // 3.  Start the plugin.
//         //
//         bg.BackgroundGeolocation.start();
//       }
//     });
//   }



//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: Container(
//         child: Text('hiii'),
//       ),
//     );
//   }
// }
