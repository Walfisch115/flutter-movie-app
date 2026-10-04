import 'package:flutter/material.dart';
import 'package:movie_app/style/colors.dart';
import 'package:expandable_text/expandable_text.dart';

class Story extends StatelessWidget {
  const Story({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    if (text.isEmpty) {
      return const Align(
        alignment: Alignment.centerLeft,
        child: Text(
          'Für diesen Film gibt es noch keine Beschreibung.',
          style: TextStyle(
            color: AppColors.textSecondary,
            fontSize: 16,
          ),
        ),
      );
    }

    return ExpandableText(
      text,
      expandText: 'mehr',
      collapseText: 'weniger',
      maxLines: 5,
      linkColor: AppColors.accent,
      linkEllipsis: false,
      animation: true,
      style: const TextStyle(
        color: AppColors.textSecondary,
        fontSize: 16,
        height: 1.5,
      ),
    );
  }
}
