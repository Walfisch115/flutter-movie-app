import 'package:flutter/material.dart';

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

class MovieDetailsPage extends StatelessWidget {
  const MovieDetailsPage({
    super.key,
    required this.id,
  });

  final int id;

  /// Abstand zwischen den Abschnitten (Handlung, Streaming, Besetzung).
  static const double _sectionSpacing = 24;

  String _formatRuntime(int runtime) {
    final hours = runtime ~/ 60;
    final minutes = runtime % 60;
    return '${hours == 0 ? '' : '$hours Std. '}$minutes Min.';
  }

  /// Erscheinungsjahr, z. B. "2023", oder leer, wenn unbekannt.
  String _year(String releaseDate) {
    if (releaseDate == '') return '';
    return '${DateTime.parse(releaseDate).year}';
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
      backgroundColor: const Color.fromARGB(255, 31, 29, 43),
      body: FutureBuilder(
        future: tmdb.getMovieDetails(id),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return ErrorMessage(error: snapshot.error);
          }

          if (snapshot.hasData && snapshot.connectionState == ConnectionState.done) {
            final backdropPath = snapshot.data!.backdropPath;

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
                          backdropPath: snapshot.data!.backdropPath,
                          title: snapshot.data!.title,
                          rating: snapshot.data!.voteAverage,
                          year: _year(snapshot.data!.releaseDate),
                        ),
                        const SizedBox(height: 16),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Column(
                            children: [
                              // Angaben als kleine Boxen über der Handlung:
                              // erst [3 Std.] [FSK 12], darunter die Genres.
                              if (_infoParts(snapshot.data!).isNotEmpty)
                                _badgeRow(_infoParts(snapshot.data!)),
                              if (_infoParts(snapshot.data!).isNotEmpty &&
                                  snapshot.data!.genres.isNotEmpty)
                                const SizedBox(height: 8),
                              if (snapshot.data!.genres.isNotEmpty)
                                _badgeRow(snapshot.data!.genres),
                              const SizedBox(height: _sectionSpacing),
                              const SectionTitle('Handlung'),
                              const SizedBox(height: 12),
                              Story(
                                text: snapshot.data!.overview,
                              ),
                              const SizedBox(height: _sectionSpacing),
                              const SectionTitle('Streaming'),
                              const SizedBox(height: 12),
                              Streaming(
                                streamingLogos: snapshot.data!.streamingLogos,
                              ),
                              const SizedBox(height: _sectionSpacing),
                              const SectionTitle('Besetzung und Crew'),
                              const SizedBox(height: 12),
                              Credits(
                                credits: snapshot.data!.credits,
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
