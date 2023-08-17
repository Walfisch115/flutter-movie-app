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

  Widget _showMaxRating(bool showMaxRating) {
    if (showMaxRating) {
      return Text(
        "/${maxRating.toString()}",
        style: const TextStyle(
          color: Color.fromARGB(255, 195, 195, 201),
          fontSize: 18,
        ),
      );
    } else {
      return const SizedBox.shrink();
    }
  }

  @override
  Widget build(context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          Icons.star_rounded,
          color: const Color.fromARGB(255, 18, 205, 217),
          size: iconSize,
        ),
        const SizedBox(
          width: 6,
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              rating.toStringAsFixed(1),
              style: TextStyle(
                color: const Color.fromARGB(255, 195, 195, 201),
                fontWeight: FontWeight.w500,
                fontSize: textSize,
              ),
            ),
            const SizedBox(
              width: 4,
            ),
            _showMaxRating(showMaxRating),
          ],
        ),
      ],
    );
  }
}
