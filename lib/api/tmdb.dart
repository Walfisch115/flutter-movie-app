import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:movie_app/api/api_key.dart';
import 'package:movie_app/models/movie.dart';
import 'package:movie_app/models/movie_detail.dart';

class TmdbApi {

  Future<List<Movie>> searchMovies(String query) async {

    final json = await _get('/3/search/movie', {'query': query});

    return (json['results'] as List)
        .map((movie) => Movie.fromJson(movie))
        .toList();
  }

  Future<MovieDetail> getMovieDetails(int id) async {
    
    final json = await _get('/3/movie/$id', {
      'append_to_response': 'watch/providers,credits',
    });

    return MovieDetail.fromJson(json);
  }

  /// Baut die URL für ein Bild, z. B. imageUrl('/abc.jpg', 'w185').
  /// [size] ist eine TMDB-Größe wie 'w185', 'w1280' oder 'original'.
  String imageUrl(String path, String size) {
    return 'https://image.tmdb.org/t/p/$size$path';
  }

  /// Schickt eine GET-Anfrage an TMDB und gibt die Antwort als Map zurück.
  ///
  /// [path] ist der Endpunkt, z. B. '/3/search/movie'.
  /// [params] sind die Query-Parameter, die nur für diese Anfrage gelten.
  Future<Map<String, dynamic>> _get(
    String path,
    Map<String, String> params,
  ) async {

    // URL zusammenbauen: Key und Sprache gelten immer, [params] kommen dazu.
    final uri = Uri.https('api.themoviedb.org', path, {
      'api_key': ApiKey.apiKey,
      'language': 'de',
      ...params,
    });

    // Anfrage senden, nach 10 Sekunden ohne Antwort wird abgebrochen.
    // Schlägt sie fehl (kein Netz, Timeout), gibt es eine lesbare Meldung.
    final http.Response response;
    try {
      response = await http.get(uri).timeout(const Duration(seconds: 10));
    } catch (_) {
      throw Exception('Keine Verbindung zum Server');
    }

    // Alles außer 200 (OK) ist ein Fehler, dann gibt es eine passende Meldung.
    if (response.statusCode != 200) {
      final message = switch (response.statusCode) {
        401 => 'API-Key ungültig',
        404 => 'Film nicht gefunden',
        429 => 'Zu viele Anfragen, bitte kurz warten',
        _ => 'Serverfehler ${response.statusCode}',
      };
      throw Exception(message);
    }

    // Antworttext (JSON-String) in eine Map umwandeln.
    return jsonDecode(response.body);
  }
}

final tmdb = TmdbApi();
