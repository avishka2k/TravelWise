import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<Map<String, dynamic>> getUserData() async {
  User? user = FirebaseAuth.instance.currentUser;
  DocumentSnapshot<Map<String, dynamic>> userData =
      await FirebaseFirestore.instance.collection('users').doc(user!.uid).get();

  if (userData.exists) {
    return {
      'email': userData['email'],
      'fullname': userData['fullname'],
      'address': userData['address'],
      'gender': userData['gender'],
      'phoneNumber': userData['phoneNumber'],
      'birthDay': userData['birthDay'],
    };
  } else {
    return {};
  }
}
