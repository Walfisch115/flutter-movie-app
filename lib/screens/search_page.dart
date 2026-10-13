import 'package:flutter/material.dart';
import 'package:movie_app/style/colors.dart';

import 'package:movie_app/api/tmdb.dart';
import 'package:movie_app/widgets/paged_movie_list.dart';
import 'package:movie_app/widgets/section_title.dart';
import 'package:movie_app/widgets/movie_search_bar.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocus = FocusNode();

  // Letzter Suchbegriff. null, solange nicht gesucht wurde oder das Feld
  // leer ist. Dann zeigt die Seite die Trends der Woche.
  String? _query;

  // Zählt jede abgeschickte Suche, damit auch derselbe Begriff neu lädt.
  int _searchCount = 0;

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: MovieSearchBar(
                textController: _searchController,
                focusNode: _searchFocus,
                onSubmitted: (value) {
                  // Leere Eingabe (oder nur Leerzeichen): wieder die Trends.
                  if (value.trim().isEmpty) {
                    setState(() => _query = null);
                    return;
                  }

                  setState(() {
                    _query = value.trim();
                    _searchCount++;
                  });
                },
                onClear: () {
                  _searchController.clear();
                  // Mit dem X sofort zurück zu den Trends.
                  setState(() => _query = null);
                  // Direkt weitertippen können, Tastatur geht auf.
                  _searchFocus.requestFocus();
                },
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: _query == null
                  // Vor der ersten Suche: Trends der Woche als Poster-Raster.
                  ? PagedMovieList(
                      loadPage: (page) => tmdb.trendingMovies(page: page),
                      grid: true,
                      header: const Padding(
                        padding: EdgeInsets.fromLTRB(16, 0, 16, 12),
                        child: SectionTitle('Trends der Woche'),
                      ),
                    )
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
