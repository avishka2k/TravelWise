import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:travelwise/components/app_toast.dart';

User? user = FirebaseAuth.instance.currentUser;

Future<Map<String, dynamic>> getUserData() async {
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
      'profileUrl': userData['profileUrl'],
    };
  } else {
    return {};
  }
}

Future<void> updateUserBasic(
  String fullname,
  String gender,
  DateTime birthDay,
  String phoneNumber,
  String address,
  File? imageFile,
) async {
  try {
    if (imageFile != null) {
      File image = File(imageFile.path);

      final storageRef = FirebaseStorage.instance
          .ref()
          .child('images/users/${DateTime.now()}.png');

      // Upload the image to Firebase Storage
      UploadTask uploadTask = storageRef.putFile(image);
      TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});
      String imageUrl = await taskSnapshot.ref.getDownloadURL();
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user!.uid)
          .update({
        'profileUrl': imageUrl,
      });
    }

    // Update user data in Firestore
    await FirebaseFirestore.instance.collection('users').doc(user!.uid).update({
      'fullname': fullname,
      'gender': gender,
      'birthDay': birthDay,
      'phoneNumber': int.parse(phoneNumber),
      'address': address,
    });

    AppToastmsg.appToastMeassage('Update success');
  } catch (e) {
    if (e is FormatException) {
      AppToastmsg.appToastMeassage(
          '${e.message} (\'${e.source}\' is not a number)');
    } else {
      AppToastmsg.appToastMeassage('Error: $e');
    }
  }
}
