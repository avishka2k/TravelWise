import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travelwise/app_data.dart';
import 'package:travelwise/firebase/auth/auth_changes.dart';
import 'package:travelwise/firebase_options.dart';
import 'package:travelwise/screens/signup/signup.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
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
