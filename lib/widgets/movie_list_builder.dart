import 'package:flutter/material.dart';

import 'package:movie_app/models/movie.dart';
import 'package:movie_app/screens/movie_details_page.dart';
import 'package:movie_app/widgets/error_message.dart';
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
        if (snapshot.hasError) {
          return ErrorMessage(error: snapshot.error);
        }

        if (snapshot.hasData && snapshot.connectionState == ConnectionState.done) {
          if (snapshot.data!.isEmpty) {
            return const Center(
              child: Text(
                'keine Ergebnisse',
                style: TextStyle(
                  color: Color.fromARGB(255, 241, 241, 245),
                  fontSize: 18,
                ),
              ),
            );
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MovieDetailsPage(
                          id: snapshot.data![index].id,
                        ),
                      ),
                    );
                  },
                  child: MovieCard(movie: snapshot.data![index]),
                );
              },
            );
          }
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
