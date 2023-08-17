import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:movie_app/api/api_key.dart';
import 'package:movie_app/models/movie_detail.dart';
import 'package:movie_app/widgets/icon_feature.dart';
import 'package:movie_app/widgets/story.dart';
import 'package:movie_app/widgets/streaming.dart';
import 'package:movie_app/widgets/genre.dart';
import 'package:movie_app/widgets/header.dart';

class MovieDetailsPage extends StatelessWidget {
  const MovieDetailsPage({
    super.key,
    required this.id,
  });

  final int id;

  Future<MovieDetail> _fetchMovie() async {
    final response = await http.get(
      Uri.https(
        "api.themoviedb.org",
        "/3/movie/$id",
        {
          "api_key": ApiKey.apiKey,
          "language": "de",
          "append_to_response": "watch/providers",
        },
      ),
    );

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      return MovieDetail.fromJson(jsonData);
    } else {
      throw Exception('Failed to load movie');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 31, 29, 43),
      body: FutureBuilder(
        future: _fetchMovie(),
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
                          text: snapshot.data!.getRuntime,
                          icon: Icons.schedule_rounded,
                          iconSize: 18,
                        ),
                        const SizedBox(height: 12),
                        IconFeature(
                          text: snapshot.data!.getReleaseDate,
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
                        const SizedBox(
                          height: 8,
                        ),
                        Streaming(
                          streamingProviders: snapshot.data!.watchProvider,
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
