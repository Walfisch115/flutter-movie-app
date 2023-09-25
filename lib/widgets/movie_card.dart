import 'package:flutter/material.dart';
import 'package:movie_app/models/movie.dart';
import 'package:movie_app/widgets/star_rating.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;

  const MovieCard({
    super.key,
    required this.movie,
  });

  Widget _getImageFromNetwork(imagePath) {
    if (imagePath != null) {
      return Image.network(
        "https://image.tmdb.org/t/p/w185$imagePath",
        fit: BoxFit.cover,
      );
    } else {
      return Container(
        color: Colors.grey[700],
        child: const Icon(
          Icons.not_interested_rounded,
          color: Colors.grey,
        ),
      );
    }
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
              height: 100,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: AspectRatio(
                  aspectRatio: 2 / 3,
                  child: _getImageFromNetwork(movie.posterPath),
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
                      color: Color(0xFFF1F1F5),
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
                          color: Color(0xFFD3D3DA),
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
      ),
    );
  }
}
