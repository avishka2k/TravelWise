import 'package:flutter/material.dart';

const EdgeInsets appPagePadding = EdgeInsets.only(left: 15, right: 15, top: 20);
const TextStyle appTextHeader1 = TextStyle(
    fontSize: 26, fontWeight: FontWeight.bold, color: Color(0xff222428));
const TextStyle appTextSubHeader =
    TextStyle(fontSize: 15, color: Color.fromARGB(255, 102, 102, 102));
const EdgeInsets appFieldPadding = EdgeInsets.only(bottom: 15);
BorderRadius appBorderRadius = BorderRadius.circular(5);

class AppColors {
  static const Color primary = Color(0xff3880FF);
  static const Color secondory = Color(0xffAA66CC);
  static const Color success = Color(0xff10DC60);
  static const Color info = Color(0xff33B5E5);
  static const Color warning = Color(0xffFFBB33);
  static const Color danger = Color(0xffF04141);
  static const Color light= Color(0xffE0E0E0);
  static const Color dark = Color(0xff222428);
  static const Color white = Color(0xffffffff);
  static const Color focus = Color(0xff434054);
  static const Color alt = Color(0xff794c8a);
  static const Color transparent = Colors.transparent;
}
