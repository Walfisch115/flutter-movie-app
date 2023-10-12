import 'package:flutter/material.dart';
import 'package:movie_app/style/my_colors.dart';

class Message extends StatelessWidget {
  const Message({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        text,
        style: const TextStyle(
          color: MyColors.darkerWhite,
          fontSize: 18,
        ),
      ),
    );
  }
}
