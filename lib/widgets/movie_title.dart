import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

class MovieTitle extends StatelessWidget {
  const MovieTitle({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(context) {
    return AutoSizeText(
      title,
      textAlign: TextAlign.center,
      style: const TextStyle(
        color: Color.fromARGB(255, 241, 241, 245),
        fontWeight: FontWeight.w500,
        fontSize: 32,
        height: 1.3,
      ),
      maxLines: 2,
      minFontSize: 28,
      overflow: TextOverflow.ellipsis,
    );
  }
}
