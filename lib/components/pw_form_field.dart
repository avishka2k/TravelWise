// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:travelwise/app_data.dart';

// ignore: must_be_immutable
class AppPwFormField extends StatefulWidget {
  TextEditingController? controller = TextEditingController();
  String fieldName;
  String hintText;
  final validator;

  AppPwFormField({
    super.key,
    this.controller,
    required this.fieldName,
    required this.hintText,
    this.validator,
  });

  @override
  State<AppPwFormField> createState() => _AppPwFormFieldState();
}

class _AppPwFormFieldState extends State<AppPwFormField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: appFieldPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 3),
            child: Text(
              widget.fieldName,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          TextFormField(
            validator: widget.validator,
            controller: widget.controller,
            obscureText: _obscureText,
            enableSuggestions: false,
            autocorrect: false,
            decoration: InputDecoration(
              hintText: widget.hintText,
              suffixIcon: IconButton(
                iconSize: 18,
                icon: Icon(
                    _obscureText ? Icons.visibility_off : Icons.visibility),
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
              ),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 20, horizontal: 18),
              border: OutlineInputBorder(
                borderSide: const BorderSide(width: 1.0),
                borderRadius: appBorderRadius,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
