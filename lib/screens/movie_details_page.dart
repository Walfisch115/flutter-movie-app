import 'package:flutter/material.dart';

import 'package:movie_app/api/tmdb.dart';
import 'package:movie_app/widgets/icon_feature.dart';
import 'package:movie_app/widgets/story.dart';
import 'package:movie_app/widgets/streaming.dart';
import 'package:movie_app/widgets/genre.dart';
import 'package:movie_app/widgets/header.dart';
import 'package:movie_app/widgets/credits.dart';

class MovieDetailsPage extends StatelessWidget {
  const MovieDetailsPage({
    super.key,
    required this.id,
  });

  final int id;

  String _formatRuntime(int runtime) {
    int hours = runtime ~/ 60;
    int minutes = runtime % 60;
    return '${hours == 0 ? '' : '$hours Std. '}$minutes Min.';
  }

  String _formatReleaseDate(String releaseDate) {
    if (releaseDate != "") {
      var date = DateTime.parse(releaseDate);

      String day = date.day.toString();
      String month = date.month.toString();
      String year = date.year.toString();

      return '$day.$month.$year';
    } else {
      return 'N/A';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 31, 29, 43),
      body: FutureBuilder(
        future: getMovieDetails(id),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.connectionState == ConnectionState.done) {
            return SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Header(
                    posterPath: snapshot.data!.backdropPath,
                    title: snapshot.data!.title,
                    rating: snapshot.data!.voteAverage,
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: [
                        Genre(genre: snapshot.data!.genre),
                        const SizedBox(height: 16),
                        IconFeature(
                          text: _formatRuntime(snapshot.data!.runtime),
                          icon: Icons.schedule_rounded,
                          iconSize: 18,
                        ),
                        const SizedBox(height: 12),
                        IconFeature(
                          text: _formatReleaseDate(snapshot.data!.releaseDate),
                          icon: Icons.calendar_today_outlined,
                          iconSize: 16,
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: const [
                            Text(
                              'Handlung',
                              style: TextStyle(
                                color: Color.fromARGB(255, 241, 241, 245),
                                fontSize: 22,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Story(
                          text: snapshot.data!.overview,
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: const [
                            Text(
                              'Streaming',
                              style: TextStyle(
                                color: Color.fromARGB(255, 241, 241, 245),
                                fontSize: 22,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Streaming(
                          streamingProviders: snapshot.data!.watchProvider,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Column(
                      children: [
                        Row(
                          children: const [
                            Text(
                              'Besetzung und Crew',
                              style: TextStyle(
                                color: Color.fromARGB(255, 241, 241, 245),
                                fontSize: 22,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Credits(
                          credits: snapshot.data!.credits,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
