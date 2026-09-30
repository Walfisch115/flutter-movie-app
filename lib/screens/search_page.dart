import 'package:flutter/material.dart';

import 'package:movie_app/models/movie.dart';
import 'package:movie_app/widgets/movie_list_builder.dart';
import 'package:movie_app/widgets/movie_search_bar.dart';
import 'package:movie_app/api/tmdb.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();

  // Ergebnis der letzten Suche, null solange noch nicht gesucht wurde.
  Future<List<Movie>>? _results;

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
              child: MovieSearchBar(
                textController: _searchController,
                onSubmitted: (value) {
                  // Bei leerer Eingabe (oder nur Leerzeichen) nicht suchen.
                  if (value.trim().isEmpty) return;

                  setState(() {
                    _results = tmdb.searchMovies(value.trim());
                  });
                },
                onClear: () {
                  _searchController.clear();
                },
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: _results == null
                  ? const SizedBox.shrink()
                  : MovieListBuilder(future: _results!),
            ),
          ],
        ),
      ),
    );
  }
}
