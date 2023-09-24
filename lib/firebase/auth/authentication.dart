// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:travelwise/components/app_toast.dart';

class AppAuth {
  Future<User?> _createUserWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      AppToastmsg.appToastMeassage('Failed to create user');
      print('Failed to create user: ${e.message}');
      return null;
    }
  }

  Future<void> _uploadUsernameToFirestore(
    User user,
    String fullname,
    String email,
    DateTime joinDate,
    String address,
    String gender,
    String phoneNumber,
    String birthDay,
  ) async {
    try {
      await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
        'fullname': fullname,
        'email': email,
        'address': address,
        'joinDate': joinDate,
        'gender': 'Male',
        'phoneNumber': phoneNumber,
        'birthDay': birthDay,
        'profileUrl': '',
      });
    } catch (e) {
      AppToastmsg.appToastMeassage('Failed to upload data');
      print('Failed to upload username: $e');
    }
  }

  void register(String email, String password, String fullname) async {
    User? user = await _createUserWithEmailAndPassword(email, password);
    DateTime date = DateTime.now();
    if (user != null) {
      await _uploadUsernameToFirestore(
          user, fullname, email, date, '', '', '', '');
      AppToastmsg.appToastMeassage('User registered successfully!');
    }
  }

  Future login(String email, String password) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        AppToastmsg.appToastMeassage('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        AppToastmsg.appToastMeassage('Wrong password provided for that user.');
      }
    }
  }
}
