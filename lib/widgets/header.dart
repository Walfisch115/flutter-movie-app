import 'package:flutter/material.dart';
import 'package:movie_app/widgets/movie_title.dart';
import 'package:movie_app/widgets/gradient_backdrop.dart';

/// Kopfbereich der Detailseite: Backdrop als Karte mit Titel,
/// Rating und Jahr unten links.
class Header extends StatelessWidget {
  const Header({
    super.key,
    required this.backdropPath,
    required this.title,
    required this.rating,
    required this.year,
  });

  final String? backdropPath;
  final String title;
  final num rating;

  /// Erscheinungsjahr, leer wenn unbekannt.
  final String year;

  @override
  Widget build(BuildContext context) {
    // TMDB liefert 0, solange niemand den Film bewertet hat.
    final hasRating = rating > 0;

    final titleAndGenres = Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MovieTitle(title: title),
        if (hasRating || year.isNotEmpty) ...[
          const SizedBox(height: 8),
          // z. B. "☆ 8.1 | 2023"
          Row(
            children: [
              if (hasRating) ...[
                const Icon(
                  Icons.star_outline_rounded,
                  color: Color.fromARGB(255, 211, 211, 218),
                  size: 18,
                ),
                const SizedBox(width: 4),
                Text(rating.toStringAsFixed(1), style: _infoStyle),
              ],
              if (hasRating && year.isNotEmpty) const _Divider(),
              if (year.isNotEmpty) Text(year, style: _infoStyle),
            ],
          ),
        ],
      ],
    );

    final path = backdropPath;

    // Ohne Bild: nur Titel, Rating und Jahr.
    if (path == null) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
        child: Align(
          alignment: Alignment.centerLeft,
          child: titleAndGenres,
        ),
      );
    }

    // Mit Bild: Karte mit Rand zum Bildschirm,
    // Titel, Rating und Jahr unten links auf dem Verlauf.
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
      child: Stack(
        children: [
          GradientBackdrop(backdropPath: path),
          Positioned(
            left: 16,
            right: 16,
            bottom: 16,
            child: titleAndGenres,
          ),
        ],
      ),
    );
  }
}

const _infoStyle = TextStyle(
  color: Color.fromARGB(255, 211, 211, 218),
  fontSize: 14,
);

/// Dünner senkrechter Strich zwischen den Einträgen.
class _Divider extends StatelessWidget {
  const _Divider();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1,
      height: 14,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      color: const Color.fromARGB(255, 105, 105, 116),
    );
  }
}
