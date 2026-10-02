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
  final String ageRating;
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
    required this.ageRating,
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

    // Altersfreigabe (FSK) in Deutschland, leer wenn unbekannt.
    final List countries = json['release_dates']?['results'] ?? [];
    final ageRatings = [
      for (var country in countries)
        if (country['iso_3166_1'] == 'DE')
          for (var release in country['release_dates'])
            if (release['certification'] != '')
              release['certification'] as String,
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
          // Werbe-Varianten wie "Netflix basic with Ads" weglassen,
          // sonst erscheint derselbe Dienst doppelt.
          .where((provider) =>
              !(provider['provider_name'] as String).contains('with Ads'))
          .map<String>((provider) => provider['logo_path'])
          .toList(),
      credits: credits,
      ageRating: ageRatings.isEmpty ? '' : ageRatings.first,
    );
  }
}
