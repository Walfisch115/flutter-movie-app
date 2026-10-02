import 'package:flutter/material.dart';

class StarRating extends StatelessWidget {
  const StarRating({
    super.key,
    required this.rating,
    this.maxRating = 10,
    required this.iconSize,
    required this.textSize,
    required this.showMaxRating,
  });

  final num rating;
  final num maxRating;
  final double? iconSize;
  final double? textSize;

  final bool showMaxRating;

  @override
  Widget build(context) {
    // TMDB liefert 0, solange niemand den Film bewertet hat.
    final hasRating = rating > 0;

    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Ohne Bewertung nur "N/A", ohne Stern.
        if (hasRating) ...[
          Icon(
            Icons.star_rounded,
            color: const Color.fromARGB(255, 18, 205, 217),
            size: iconSize,
          ),
          const SizedBox(width: 6),
        ],
        Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              hasRating ? rating.toStringAsFixed(1) : 'N/A',
              style: TextStyle(
                color: const Color.fromARGB(255, 195, 195, 201),
                fontWeight: FontWeight.w500,
                fontSize: textSize,
              ),
            ),
            // Abstand nur, wenn auch "/10" folgt.
            if (showMaxRating && hasRating) ...[
              const SizedBox(width: 4),
              Text(
                '/$maxRating',
                style: TextStyle(
                  color: const Color.fromARGB(255, 195, 195, 201),
                  fontSize: textSize,
                ),
              ),
            ],
          ],
        ),
      ],
    );
  }
}
