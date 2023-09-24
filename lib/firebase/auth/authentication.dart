// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:travelwise/components/app_toast.dart';

class AppAuth {
  GlobalKey<State> _keyLoader = GlobalKey<State>();
  Future<User?> _createUserWithEmailAndPassword(
      String email, String password, BuildContext context) async {
    try {
      showLoaderDialog(context);
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      AppToastmsg.appToastMeassage('Failed to create user');
      print('Failed to create user: ${e.message}');
      return null;
    } finally {
      Navigator.of(_keyLoader.currentContext!, rootNavigator: true).pop();
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
    DateTime birthDay,
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

  void register(String email, String password, String fullname,
      DateTime birthDay, BuildContext context) async {
    User? user =
        await _createUserWithEmailAndPassword(email, password, context);
    DateTime date = DateTime.now();
    if (user != null) {
      await _uploadUsernameToFirestore(
          user, fullname, email, date, '', '', '', birthDay);
      AppToastmsg.appToastMeassage('User registered successfully!');
    }
  }

  Future login(String email, String password, BuildContext context) async {
    try {
      showLoaderDialog(context);
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
    } finally {
      Navigator.of(_keyLoader.currentContext!, rootNavigator: true).pop();
    }
  }

  Future<void> signOut(BuildContext context) async {
    try {
      showLoaderDialog(context);
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      print("Error: $e");
    } finally {
      Navigator.of(_keyLoader.currentContext!, rootNavigator: true).pop();
    }
  }

  void showLoaderDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        _keyLoader = GlobalKey<State>();
        return AlertDialog(
          key: _keyLoader,
          content: const IntrinsicHeight(
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                children: [
                  SizedBox(height: 10),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      CircularProgressIndicator(),
                      SizedBox(width: 20),
                      Text(
                        "Loading...",
                        style: TextStyle(fontSize: 17),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
