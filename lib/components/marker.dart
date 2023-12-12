import 'package:flutter/material.dart';

class TextOnImage extends StatelessWidget {
  const TextOnImage({
    super.key,
    required this.text,
  });
  final String text;
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        const Image(
          image: AssetImage(
            "images/onb1.jpg",
          ),
          height: 15,
          width: 15,
        ),
        Text(
          text,
          style: const TextStyle(color: Colors.black),
        )
      ],
    );
  }
}
