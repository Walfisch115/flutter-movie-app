class MovieDetail {
  final int id;
  final String title;
  final String releaseDate;
  final String? backdropPath;
  final num voteAverage;
  final String overview;
  final int runtime;
  final List<dynamic> genre;
  final Map<String, dynamic> watchProvider;
  final Map<String, dynamic> credits;

  MovieDetail({
    required this.id,
    required this.title,
    required this.releaseDate,
    required this.backdropPath,
    required this.voteAverage,
    required this.overview,
    required this.runtime,
    required this.genre,
    required this.watchProvider,
    required this.credits,
  });

  factory MovieDetail.fromJson(Map<String, dynamic> json) {
    return MovieDetail(
      id: json['id'],
      title: json['title'],
      releaseDate: json['release_date'],
      backdropPath: json['backdrop_path'],
      voteAverage: json['vote_average'],
      overview: json['overview'],
      runtime: json['runtime'],
      genre: json['genres'],
      watchProvider: json['watch/providers'],
      credits: json['credits'],
    );
  }
}
