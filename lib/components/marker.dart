import 'package:flutter/material.dart';

class TextOnImage extends StatelessWidget {
   TextOnImage({
    super.key,
    required this.text,
  });
  final String text;
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Image(
          image: const AssetImage(
            "images/onb1.jpg",
          ),
          height: 15,
          width: 15,
        ),
        Text(
          text,
          style: TextStyle(color: Colors.black),
        )
      ],
    );
  }
}