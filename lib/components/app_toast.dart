import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:travelwise/app_data.dart';

class AppToastmsg {
  static void appToastMeassage(String msg) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: AppColors.dark,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
}
