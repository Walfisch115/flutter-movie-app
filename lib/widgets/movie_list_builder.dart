import 'package:flutter/material.dart';

import 'package:movie_app/models/movie.dart';
import 'package:movie_app/screens/movie_details_screen.dart';
import 'package:movie_app/style/my_colors.dart';
import 'package:movie_app/widgets/message.dart';
import 'package:movie_app/widgets/movie_card.dart';

class MovieListBuilder extends StatelessWidget {
  const MovieListBuilder({
    super.key,
    required this.future,
  });

  final Future<List<Movie>> future;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data!.isEmpty) {
            return const Message(
              text: 'Keine Ergebnisse.',
            );
          } else {
            return ListView.separated(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MovieDetailsScreen(
                          id: snapshot.data![index].id,
                        ),
                      ),
                    );
                  },
                  child: MovieCard(
                    movie: Movie(
                      id: snapshot.data![index].id,
                      title: snapshot.data![index].title,
                      posterPath: snapshot.data![index].posterPath,
                      releaseDate: snapshot.data![index].releaseDate,
                      voteAverage: snapshot.data![index].voteAverage,
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return const SizedBox(
                  height: 12,
                );
              },
            );
          }
        }
        if (snapshot.hasError) {
          return const Message(
            text: 'Hoppla! Irgendwas ist schiefgelaufen.',
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(MyColors.lightBlue),
            ),
          );
        }
      },
    );
  }
}
