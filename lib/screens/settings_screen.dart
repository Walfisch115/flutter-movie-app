import 'package:flutter/material.dart';
import 'package:movie_app/style/my_colors.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Settings Screen',
        style: TextStyle(
          fontSize: 24,
          color: MyColors.white,
        ),
      ),
    );
  }
}
