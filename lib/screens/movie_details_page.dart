import 'package:flutter/material.dart';
import 'package:movie_app/style/colors.dart';

import 'package:movie_app/api/tmdb.dart';
import 'package:movie_app/models/movie_detail.dart';
import 'package:movie_app/widgets/story.dart';
import 'package:movie_app/widgets/streaming.dart';
import 'package:movie_app/widgets/header.dart';
import 'package:movie_app/widgets/credits.dart';
import 'package:movie_app/widgets/blurred_background.dart';
import 'package:movie_app/widgets/error_message.dart';
import 'package:movie_app/widgets/info_badge.dart';
import 'package:movie_app/widgets/section_title.dart';

class MovieDetailsPage extends StatefulWidget {
  const MovieDetailsPage({
    super.key,
    required this.id,
  });

  final int id;

  @override
  State<MovieDetailsPage> createState() => _MovieDetailsPageState();
}

class _MovieDetailsPageState extends State<MovieDetailsPage> {
  late final Future<MovieDetail> _movie;

  @override
  void initState() {
    super.initState();
    // Einmal laden und merken. Stünde der Aufruf in build, ginge bei jedem
    // Neuaufbau der Seite (z. B. Drehen des Handys) eine neue Anfrage raus.
    _movie = tmdb.getMovieDetails(widget.id);
  }

  /// Abstand zwischen den Abschnitten (Handlung, Streaming, Besetzung).
  static const double _sectionSpacing = 24;

  String _formatRuntime(int runtime) {
    final hours = runtime ~/ 60;
    final minutes = runtime % 60;
    return '${hours == 0 ? '' : '$hours Std. '}$minutes Min.';
  }

  /// Steht der Film in Deutschland noch aus und ist der Termin bekannt,
  /// z. B. "Ab 12.03.2027 im Kino" oder "Ab 12.03.2027 im Stream",
  /// sonst das Erscheinungsjahr.
  /// Leer, wenn nichts bekannt ist.
  String _release(MovieDetail movie) {
    final german = movie.germanRelease;
    if (german != null && german.isAfter(DateTime.now())) {
      final day = german.day.toString().padLeft(2, '0');
      final month = german.month.toString().padLeft(2, '0');
      final where = movie.germanReleaseInCinema ? 'im Kino' : 'im Stream';
      return 'Ab $day.$month.${german.year} $where';
    }

    if (movie.releaseDate == '') return '';
    return '${DateTime.parse(movie.releaseDate).year}';
  }

  /// Laufzeit und FSK als einzelne Angaben. Fehlende Angaben fallen weg.
  List<String> _infoParts(MovieDetail movie) {
    return [
      if (movie.runtime > 0) _formatRuntime(movie.runtime),
      if (movie.ageRating != '') 'FSK ${movie.ageRating}',
    ];
  }

  /// Eine Zeile mit kleinen Boxen, bricht bei Bedarf um.
  Widget _badgeRow(List<String> parts) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: [for (final part in parts) InfoBadge(part)],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: FutureBuilder(
        future: _movie,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return ErrorMessage(error: snapshot.error);
          }

          if (snapshot.hasData && snapshot.connectionState == ConnectionState.done) {
            final movie = snapshot.data!;
            final backdropPath = movie.backdropPath;
            final infoParts = _infoParts(movie);

            // Bis zu zwei Genres stehen mit in der Zeile von Laufzeit und FSK
            // (was nicht passt, bricht um). Ab drei bekommen sie eine eigene.
            final badgeRows = movie.genres.length >= 3
                ? [infoParts, movie.genres]
                : [
                    [...infoParts, ...movie.genres],
                  ];
            final shownRows =
                badgeRows.where((row) => row.isNotEmpty).toList();

            return Stack(
              fit: StackFit.expand,
              children: [
                // Weichgezeichnetes Backdrop als Hintergrund der ganzen Seite.
                if (backdropPath != null)
                  Positioned.fill(
                    child: BlurredBackground(imagePath: backdropPath),
                  ),
                // Inhalt nur im sicheren Bereich. Status- und Navigationsleiste
                // zeigen weiter den Hintergrund, der Inhalt scrollt nicht darunter.
                SafeArea(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Header(
                          backdropPath: movie.backdropPath,
                          title: movie.title,
                          rating: movie.voteAverage,
                          release: _release(movie),
                        ),
                        const SizedBox(height: 16),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Column(
                            children: [
                              // Angaben als kleine Boxen über der Handlung:
                              // [3 Std.] [FSK 12], darunter die Genres.
                              for (var i = 0; i < shownRows.length; i++) ...[
                                if (i > 0) const SizedBox(height: 8),
                                _badgeRow(shownRows[i]),
                              ],
                              const SizedBox(height: _sectionSpacing),
                              const SectionTitle('Handlung'),
                              const SizedBox(height: 12),
                              Story(
                                text: movie.overview,
                              ),
                              const SizedBox(height: _sectionSpacing),
                              const SectionTitle('Streaming'),
                              const SizedBox(height: 12),
                              Streaming(
                                streamingLogos: movie.streamingLogos,
                              ),
                              const SizedBox(height: _sectionSpacing),
                              const SectionTitle('Besetzung und Crew'),
                              const SizedBox(height: 12),
                              Credits(
                                credits: movie.credits,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ],
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
