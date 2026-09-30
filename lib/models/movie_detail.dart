import 'package:movie_app/models/person.dart';

class MovieDetail {
  final int id;
  final String title;
  final String releaseDate;
  final String? backdropPath;
  final num voteAverage;
  final String overview;
  final int runtime;
  final List<String> genres;
  final List<String> streamingLogos;
  final List<Person> credits;

  MovieDetail({
    required this.id,
    required this.title,
    required this.releaseDate,
    required this.backdropPath,
    required this.voteAverage,
    required this.overview,
    required this.runtime,
    required this.genres,
    required this.streamingLogos,
    required this.credits,
  });

  factory MovieDetail.fromJson(Map<String, dynamic> json) {

    // Streaming-Anbieter (Flatrate) in Deutschland. Fehlt etwas, bleibt die Liste leer.
    final List flatrate =
        json['watch/providers']?['results']?['DE']?['flatrate'] ?? [];

    // Erst der Regisseur, dann die Schauspieler.
    final List crew = json['credits']['crew'];
    final List cast = json['credits']['cast'];

    final credits = [
      for (var member in crew)
        if (member['job'] == 'Director')
          Person(
            name: member['name'],
            role: 'Regisseur',
            profilePath: member['profile_path'],
          ),
      for (var actor in cast)
        Person(
          name: actor['name'],
          role: actor['character'],
          profilePath: actor['profile_path'],
        ),
    ];

    return MovieDetail(
      id: json['id'],
      title: json['title'],
      releaseDate: json['release_date'] ?? '',
      backdropPath: json['backdrop_path'],
      voteAverage: json['vote_average'] ?? 0,
      overview: json['overview'] ?? '',
      runtime: json['runtime'] ?? 0,
      genres: (json['genres'] as List)
          .map((genre) => genre['name'] as String)
          .toList(),
      streamingLogos: flatrate
          .map<String>((provider) => provider['logo_path'])
          .toList(),
      credits: credits,
    );
  }
}
