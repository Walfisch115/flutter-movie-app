import 'package:flutter/material.dart';
import 'package:movie_app/style/colors.dart';

import 'package:movie_app/api/tmdb.dart';
import 'package:movie_app/models/movie.dart';
import 'package:movie_app/screens/movie_details_page.dart';
import 'package:movie_app/widgets/error_message.dart';
import 'package:movie_app/widgets/movie_card.dart';
import 'package:movie_app/widgets/movie_poster_tile.dart';

/// Zeigt Filme als Liste oder Poster-Raster und lädt beim Scrollen
/// automatisch die nächste Seite nach.
///
/// [loadPage] lädt eine Seite (beginnend bei 1), z. B.
/// `(page) => tmdb.searchMovies('Bond', page: page)`.
class PagedMovieList extends StatefulWidget {
  const PagedMovieList({
    super.key,
    required this.loadPage,
    this.grid = false,
    this.header,
  });

  final Future<MoviePage> Function(int page) loadPage;

  /// true: Poster-Raster mit drei Spalten, false: Liste mit Karten.
  final bool grid;

  /// Optional, z. B. eine Überschrift. Scrollt mit dem Inhalt mit.
  final Widget? header;

  @override
  State<PagedMovieList> createState() => _PagedMovieListState();
}

class _PagedMovieListState extends State<PagedMovieList> {
  final List<Movie> _movies = [];
  int _page = 0;
  bool _hasMore = true;
  bool _isLoading = false;
  Object? _error;

  @override
  void initState() {
    super.initState();
    _loadNextPage();
  }

  Future<void> _loadNextPage() async {
    // Nicht doppelt laden, während schon eine Anfrage läuft.
    if (_isLoading) return;
    _isLoading = true;

    try {
      final result = await widget.loadPage(_page + 1);
      if (!mounted) return;

      setState(() {
        _page++;
        _movies.addAll(result.movies);
        // Weitere Seiten gibt es, solange wir nicht bei der letzten sind.
        // TMDB liefert höchstens 500 Seiten.
        _hasMore = _page < result.totalPages && _page < 500;
      });
    } catch (error) {
      if (!mounted) return;

      setState(() {
        _error = error;
        _hasMore = false;
      });
    } finally {
      _isLoading = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    // Fehler, bevor überhaupt etwas geladen wurde.
    if (_movies.isEmpty && _error != null) {
      return ErrorMessage(error: _error);
    }

    // Erste Seite lädt noch: Ladekreis in der Mitte statt oben in der Liste.
    if (_movies.isEmpty && _hasMore) {
      return const Center(child: CircularProgressIndicator());
    }

    // Fertig geladen, aber nichts gefunden.
    if (_movies.isEmpty && !_hasMore) {
      return const Center(
        child: Text(
          'Keine Ergebnisse',
          style: TextStyle(
            color: AppColors.text,
            fontSize: 18,
          ),
        ),
      );
    }

    // Ladekreis oder Fehlermeldung unter dem letzten Film?
    final hasFooter = _hasMore || _error != null;

    // Poster-Raster: Überschrift, Raster und Ladekreis scrollen gemeinsam.
    if (widget.grid) {
      return CustomScrollView(
        slivers: [
          if (widget.header != null)
            SliverToBoxAdapter(child: widget.header),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverGrid.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                // Kacheln im Seitenverhältnis der Poster.
                childAspectRatio: 2 / 3,
              ),
              itemCount: _movies.length,
              itemBuilder: (context, index) {
                final movie = _movies[index];
                return GestureDetector(
                  onTap: () => _openDetails(movie),
                  child: MoviePosterTile(movie: movie),
                );
              },
            ),
          ),
          // Als SliverList, damit der Ladekreis erst gebaut wird (und
          // nachlädt), wenn er in die Nähe des sichtbaren Bereichs kommt.
          if (hasFooter)
            SliverList.builder(
              itemCount: 1,
              itemBuilder: (context, index) => _footer(),
            ),
          const SliverToBoxAdapter(child: SizedBox(height: 16)),
        ],
      );
    }

    final header = widget.header;
    final extra = (header != null ? 1 : 0);

    return ListView.builder(
      // Extra Platz unter dem letzten Film (jede Karte hat selbst 12 unten).
      padding: const EdgeInsets.only(bottom: 4),
      // Plus Überschrift oben und Ladekreis bzw. Fehlermeldung unten.
      itemCount: extra + _movies.length + (hasFooter ? 1 : 0),
      itemBuilder: (context, index) {
        if (header != null && index == 0) return header;
        index -= extra;

        if (index == _movies.length) return _footer();

        final movie = _movies[index];
        return GestureDetector(
          onTap: () => _openDetails(movie),
          child: MovieCard(movie: movie),
        );
      },
    );
  }

  /// Unter dem letzten Film: Fehlermeldung oder Ladekreis. Wird nur gebaut,
  /// wenn das Ende der Liste sichtbar wird.
  Widget _footer() {
    if (_error != null) return ErrorMessage(error: _error);

    // Das Ende ist sichtbar: nächste Seite laden.
    _loadNextPage();
    return const Padding(
      padding: EdgeInsets.all(16),
      child: Center(child: CircularProgressIndicator()),
    );
  }

  void _openDetails(Movie movie) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MovieDetailsPage(id: movie.id),
      ),
    );
  }
}
