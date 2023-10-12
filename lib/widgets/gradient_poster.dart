import 'package:flutter/material.dart';
import 'package:movie_app/style/my_colors.dart';

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
              MyColors.darkBluishGrey,
            ],
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
