import 'package:flutter/material.dart';

class GradientPoster extends StatelessWidget {
  const GradientPoster({
    super.key,
    required this.posterPath,
  });

  final String posterPath;

  @override
  Widget build(context) {
    return AspectRatio(
      aspectRatio: 4 / 3,
      child: Container(
        foregroundDecoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.transparent,
              Color.fromARGB(255, 31, 29, 43),
            ],
            stops: [0.25, 1],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Image.network(
          "https://image.tmdb.org/t/p/w1280$posterPath",
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
