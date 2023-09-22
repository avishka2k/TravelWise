import 'package:flutter/material.dart';

class AppPrimaryBtn extends StatelessWidget {
  Function() onPressed;
  String btnText;
  AppPrimaryBtn({
    super.key,
    required this.onPressed,
    required this.btnText,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: onPressed,
            style: ButtonStyle(
              fixedSize: MaterialStateProperty.all<Size>(
                const Size.fromHeight(50.0),
              ),
            ),
            child: Text(
              btnText,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ),
      ],
    );
  }
}
