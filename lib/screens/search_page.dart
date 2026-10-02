import 'package:flutter/material.dart';

import 'package:movie_app/api/tmdb.dart';
import 'package:movie_app/widgets/paged_movie_list.dart';
import 'package:movie_app/widgets/movie_search_bar.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocus = FocusNode();

  // Letzter Suchbegriff, null solange noch nicht gesucht wurde.
  String? _query;

  // Zählt jede abgeschickte Suche, damit auch derselbe Begriff neu lädt.
  int _searchCount = 0;

  @override
  void initState() {
    super.initState();
    // Beim Öffnen der App direkt ins Suchfeld. Erst nach dem ersten Frame,
    // sonst öffnet Android beim App-Start die Tastatur nicht.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _searchFocus.requestFocus();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocus.dispose();
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
                focusNode: _searchFocus,
                onSubmitted: (value) {
                  // Bei leerer Eingabe (oder nur Leerzeichen) nicht suchen.
                  if (value.trim().isEmpty) return;

                  setState(() {
                    _query = value.trim();
                    _searchCount++;
                  });
                },
                onClear: () {
                  _searchController.clear();
                },
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: _query == null
                  ? const SizedBox.shrink()
                  // Neuer Key bei jeder Suche: Die Liste beginnt wieder bei Seite 1.
                  : PagedMovieList(
                      key: ValueKey(_searchCount),
                      loadPage: (page) => tmdb.searchMovies(_query!, page: page),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
