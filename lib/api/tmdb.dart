import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:movie_app/api/api_key.dart';
import 'package:movie_app/models/movie.dart';
import 'package:movie_app/models/movie_detail.dart';

Future<List<Movie>> searchMovies(String query) async {
  List<Movie> movies = [];

  final response = await http.get(
    Uri.https(
      "api.themoviedb.org",
      "/3/search/movie",
      {
        "api_key": ApiKey.apiKey,
        "query": query,
        "language": "de",
      },
    ),
  );

  if (response.statusCode == 200) {
    final jsonData = jsonDecode(response.body);

    for (var eachMovie in jsonData["results"]) {
      final movie = Movie.fromJson(eachMovie);
      movies.add(movie);
    }
    return movies;
  } else {
    throw Exception('Failed to load movies');
  }
}

Future<MovieDetail> getMovieDetails(int id) async {
  final response = await http.get(
    Uri.https(
      "api.themoviedb.org",
      "/3/movie/$id",
      {
        "api_key": ApiKey.apiKey,
        "language": "de",
        "append_to_response": "watch/providers,credits",
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
