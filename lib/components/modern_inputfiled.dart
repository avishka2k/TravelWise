import 'package:flutter/material.dart';
import 'package:travelwise/app_data.dart';

// ignore: must_be_immutable
class AppModernTextFormField extends StatelessWidget {
  TextEditingController? controller = TextEditingController();
  String hintText;
  bool readOnly;
  final onTap;
  TextInputType texttype;

  AppModernTextFormField(
      {super.key,
      this.controller,
      required this.hintText,
      this.readOnly = false,
      this.onTap,
      this.texttype = TextInputType.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: const Color.fromARGB(255, 199, 199, 199)),
        borderRadius: appBorderRadius,
      ),
      child: TextFormField(
        controller: controller,
        readOnly: readOnly,
        onTap: onTap,
        style: const TextStyle(fontSize: 16),
        keyboardType: texttype,
        decoration: InputDecoration(
          hintText: hintText,
          labelText: hintText,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 13,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
