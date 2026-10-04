import 'package:flutter/material.dart';
import 'package:movie_app/style/colors.dart';
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
      textAlign: TextAlign.start,
      style: const TextStyle(
        color: AppColors.text,
        fontWeight: FontWeight.w500,
        fontSize: 28,
        height: 1.3,
      ),
      maxLines: 2,
      minFontSize: 28,
      overflow: TextOverflow.ellipsis,
    );
  }
}
