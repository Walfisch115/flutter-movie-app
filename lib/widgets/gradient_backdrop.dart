import 'package:flutter/material.dart';
import 'package:movie_app/api/tmdb.dart';

/// Backdrop als quadratische Karte mit abgerundeten Ecken.
/// Unten wird das Bild dunkler, damit Text darauf lesbar ist.
class GradientBackdrop extends StatelessWidget {
  const GradientBackdrop({
    super.key,
    required this.backdropPath,
  });

  final String backdropPath;

  @override
  Widget build(context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: AspectRatio(
        aspectRatio: 1,
        child: Container(
          foregroundDecoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.transparent,
                Color.fromARGB(220, 0, 0, 0),
              ],
              // Verlauf beginnt erst in der Mitte des Bildes.
              stops: [0.45, 1.0],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Image.network(
            tmdb.imageUrl(backdropPath, 'w1280'),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
