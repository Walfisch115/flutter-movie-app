import 'package:flutter/material.dart';

import 'package:movie_app/widgets/movie_title.dart';
import 'package:movie_app/widgets/gradient_poster.dart';
import 'package:movie_app/widgets/star_rating.dart';

class Header extends StatelessWidget {
  const Header({
    super.key,
    required this.imagePath,
    required this.title,
    required this.rating,
  });

  final String? imagePath;
  final String title;
  final num rating;

  Widget _getImageFromNetwork(context, imagePath) {
    if (imagePath != null) {
      return Stack(
        children: [
          GradientPoster(posterPath: imagePath!),
          Positioned.fill(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    MovieTitle(title: title),
                    const SizedBox(
                      height: 12,
                    ),
                    StarRating(
                      rating: rating,
                      showMaxRating: true,
                      maxRating: 10,
                      iconSize: 22,
                      textSize: 20,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      );
    } else {
      return Column(
        children: [
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 48, 16, 32),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  MovieTitle(title: title),
                  const SizedBox(
                    height: 12,
                  ),
                  StarRating(
                    rating: rating,
                    showMaxRating: true,
                    maxRating: 10,
                    iconSize: 22,
                    textSize: 20,
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return _getImageFromNetwork(context, imagePath);
  }
}
