import 'package:flutter/material.dart';

import 'package:movie_app/models/movie.dart';
import 'package:movie_app/style/my_colors.dart';
import 'package:movie_app/widgets/star_rating.dart';
import 'package:movie_app/utils/image_from_network.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;

  const MovieCard({
    super.key,
    required this.movie,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.all(0),
      color: Colors.transparent,
      child: Row(
        children: [
          SizedBox(
            height: 100,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: AspectRatio(
                aspectRatio: 2 / 3,
                child: getImageFromNetwork(movie.posterPath, 'w185'),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  movie.title,
                  softWrap: false,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: MyColors.white,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Text(
                      movie.releaseDate == ""
                          ? "N/A"
                          : DateTime.parse(movie.releaseDate).year.toString(),
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: MyColors.darkerWhite,
                      ),
                    ),
                    const Spacer(),
                    StarRating(
                      rating: movie.voteAverage,
                      showMaxRating: false,
                      iconSize: 20,
                      textSize: 16,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
