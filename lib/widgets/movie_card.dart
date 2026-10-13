import 'package:flutter/material.dart';
import 'package:movie_app/style/colors.dart';
import 'package:movie_app/api/tmdb.dart';
import 'package:movie_app/models/movie.dart';
import 'package:movie_app/widgets/star_rating.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;

  const MovieCard({
    super.key,
    required this.movie,
  });

  Widget _getImageFromNetwork(String? imagePath) {
    if (imagePath != null) {
      return Image.network(
        tmdb.imageUrl(imagePath, 'w185'),
        fit: BoxFit.cover,
      );
    } else {
      return Container(
        color: AppColors.surface,
        child: const Icon(
          Icons.movie_outlined,
          color: AppColors.hint,
        ),
      );
    }
  }

  /// Poster mit dezentem grauem Rahmen.
  Widget _framedPoster() {
    // Rahmen liegt über dem Bild (foreground).
    return DecoratedBox(
      position: DecorationPosition.foreground,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.border, width: 1),
      ),
      child: AspectRatio(
        aspectRatio: 2 / 3,
        child: _getImageFromNetwork(movie.posterPath),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
      child: Card(
        elevation: 0,
        margin: const EdgeInsets.all(0),
        color: Colors.transparent,
        child: Row(
          children: [
            SizedBox(
              height: 90,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: _framedPoster(),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movie.title,
                    // Lange Titel gehen in die zweite Zeile, danach "...".
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: AppColors.text,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Text(
                        movie.releaseDate == ""
                            ? "N/A"
                            : DateTime.parse(movie.releaseDate).year.toString(),
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      const Spacer(),
                      StarRating(
                        rating: movie.voteAverage,
                        showMaxRating: false,
                        iconSize: 18,
                        textSize: 14,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
