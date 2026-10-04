import 'package:flutter/material.dart';
import 'package:movie_app/style/colors.dart';

import 'package:movie_app/api/tmdb.dart';
import 'package:movie_app/models/movie.dart';
import 'package:movie_app/screens/movie_details_page.dart';
import 'package:movie_app/widgets/error_message.dart';
import 'package:movie_app/widgets/movie_card.dart';

/// Zeigt eine Liste von Filmen und lädt beim Scrollen automatisch
/// die nächste Seite nach.
///
/// [loadPage] lädt eine Seite (beginnend bei 1), z. B.
/// `(page) => tmdb.searchMovies('Bond', page: page)`.
class PagedMovieList extends StatefulWidget {
  const PagedMovieList({
    super.key,
    required this.loadPage,
  });

  final Future<MoviePage> Function(int page) loadPage;

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

    return ListView.builder(
      // Ein Eintrag mehr für den Ladekreis bzw. die Fehlermeldung am Ende.
      itemCount: _movies.length + (_hasMore || _error != null ? 1 : 0),
      itemBuilder: (context, index) {
        if (index == _movies.length) {
          if (_error != null) {
            return ErrorMessage(error: _error);
          }

          // Das Ende der Liste ist sichtbar: nächste Seite laden.
          _loadNextPage();
          return const Padding(
            padding: EdgeInsets.all(16),
            child: Center(child: CircularProgressIndicator()),
          );
        }

        final movie = _movies[index];
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MovieDetailsPage(id: movie.id),
              ),
            );
          },
          child: MovieCard(movie: movie),
        );
      },
    );
  }
}
