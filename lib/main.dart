import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:travelwise/app_data.dart';
import 'package:travelwise/background/background_location.dart';
import 'package:travelwise/firebase/auth/auth_changes.dart';
import 'package:travelwise/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeFirebase();
  await initializeService();
  await requestPermissions();

  runApp(const MyApp());
}

Future<void> initializeFirebase() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

Future<void> requestPermissions() async {
  Map<Permission, PermissionStatus> statuses = await [
    Permission.location,
  ].request();

  if (statuses[Permission.location] != PermissionStatus.granted) {
    // Handle the case where the permission is not granted
    print('Permission not granted!');
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TravelWise',
      theme: ThemeData(
        colorSchemeSeed: AppColors.dark,
        brightness: Brightness.light,
        textTheme: GoogleFonts.robotoTextTheme(Theme.of(context).textTheme),
        useMaterial3: true,
      ),
      home: AuthChanges(),
    );
  }
}
