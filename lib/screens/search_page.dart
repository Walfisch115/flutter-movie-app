import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:movie_app/api/api_key.dart';
import 'package:movie_app/models/movie.dart';
import 'package:movie_app/widgets/movie_list_builder.dart';
import 'package:movie_app/widgets/search_bar.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  late List<Movie> futureMovies;

  late Widget search;

  Future<List<Movie>> _fetchMovies(String query) async {
    List<Movie> movies = [];

    final response = await http.get(
      Uri.https(
        "api.themoviedb.org",
        "/3/search/movie",
        {"api_key": ApiKey.apiKey, "query": query, "language": "de"},
        // "append_to_response": "watch/providers"
      ),
    );

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);

      for (var eachMovie in jsonData["results"]) {
        final movie = Movie.fromJson(eachMovie);
        movies.add(movie);
      }
      return movies;
      // search = MovieListBuilder(future: future);
    } else {
      throw Exception('Failed to load movies');
    }
  }

  @override
  void initState() {
    search = const SizedBox.shrink();
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 31, 29, 43),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: SearchBar(
                textController: _searchController,
                onSubmitted: (value) {
                  setState(() {
                    search = MovieListBuilder(
                      future: _fetchMovies(value),
                    );
                  });
                },
                onClear: () {
                  _searchController.clear();
                },
              ),
            ),
            const SizedBox(height: 8),
            // const SizedBox(height: 16),
            Expanded(
              child: search,
            ),
          ],
        ),
      ),
    );
  }
}
