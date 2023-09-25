import 'package:flutter/material.dart';

import 'package:movie_app/widgets/movie_list_builder.dart';
import 'package:movie_app/widgets/search_bar.dart';
import 'package:movie_app/api/tmdb.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  late Widget search;

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
                      future: searchMovies(value),
                    );
                  });
                },
                onClear: () {
                  _searchController.clear();
                },
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: search,
            ),
          ],
        ),
      ),
    );
  }
}
