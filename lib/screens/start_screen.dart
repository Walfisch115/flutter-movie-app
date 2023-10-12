import 'package:flutter/material.dart';
import 'package:movie_app/style/my_colors.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Start Screen',
        style: TextStyle(
          fontSize: 24,
          color: MyColors.white,
        ),
      ),
    );
  }
}
