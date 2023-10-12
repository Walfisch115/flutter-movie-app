import 'package:flutter/material.dart';

import 'package:movie_app/api/tmdb.dart';
import 'package:movie_app/widgets/movie_list_builder.dart';
import 'package:movie_app/widgets/search_bar.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  Widget search = const SizedBox.shrink();

  void _searchQuery(String query) {
    setState(() {
      search = MovieListBuilder(
        future: searchMovies(query),
      );
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: SearchBar(
                textController: _searchController,
                onClear: () {
                  _searchController.clear();
                },
                onSubmitted: _searchQuery,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Expanded(
              child: search,
            ),
          ],
        ),
      ),
    );
  }
}
