import 'package:flutter/material.dart';

class IconFeature extends StatelessWidget {
  const IconFeature({
    super.key,
    required this.text,
    required this.icon,
    required this.iconSize,
  });

  final String text;
  final IconData icon;
  final double iconSize;

  @override
  Widget build(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Icon(
          icon,
          color: const Color.fromARGB(255, 211, 211, 218),
          size: iconSize,
        ),
        const SizedBox(
          width: 8,
        ),
        Text(
          text,
          style: const TextStyle(
            color: Color.fromARGB(255, 211, 211, 218),
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}
