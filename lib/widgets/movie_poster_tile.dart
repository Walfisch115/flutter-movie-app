import 'package:flutter/material.dart';
import 'package:movie_app/api/tmdb.dart';
import 'package:movie_app/models/movie.dart';
import 'package:movie_app/style/colors.dart';

/// Kachel für das Poster-Raster: nur das Poster.
class MoviePosterTile extends StatelessWidget {
  const MoviePosterTile({
    super.key,
    required this.movie,
  });

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    final posterPath = movie.posterPath;

    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: DecoratedBox(
        // Rahmen liegt über dem Bild, wie in der Suchliste.
        position: DecorationPosition.foreground,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.border),
        ),
        child: AspectRatio(
          aspectRatio: 2 / 3,
          child: posterPath == null
              ? Container(
                  color: AppColors.surface,
                  child: const Icon(
                    Icons.movie_outlined,
                    color: AppColors.hint,
                  ),
                )
              : Image.network(
                  tmdb.imageUrl(posterPath, 'w185'),
                  fit: BoxFit.cover,
                ),
        ),
      ),
    );
  }
}
