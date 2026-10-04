import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:movie_app/style/colors.dart';
import 'package:movie_app/api/tmdb.dart';

/// Stark weichgezeichnetes Bild als Hintergrund der Seite.
/// Ein dunkler Verlauf darüber hält den Text lesbar.
class BlurredBackground extends StatelessWidget {
  const BlurredBackground({
    super.key,
    required this.imagePath,
  });

  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        ImageFiltered(
          imageFilter: ImageFilter.blur(sigmaX: 40, sigmaY: 40),
          child: Image.network(
            // Wird ohnehin unscharf, ein kleines Bild reicht.
            tmdb.imageUrl(imagePath, 'w300'),
            fit: BoxFit.cover,
          ),
        ),
        DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              // Hintergrundfarbe, oben durchscheinend, unten fast deckend.
              colors: [
                AppColors.background.withAlpha(110),
                AppColors.background.withAlpha(230),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
