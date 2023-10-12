import 'package:flutter/material.dart';
import 'package:movie_app/style/my_colors.dart';

class SectionHeading extends StatelessWidget {
  const SectionHeading({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          text,
          style: const TextStyle(
            color: MyColors.white,
            fontSize: 22,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
