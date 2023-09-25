class Movie {
  final int id;
  final String title;
  final String releaseDate;
  final String? posterPath;
  final num voteAverage;

  Movie({
    required this.id,
    required this.title,
    required this.releaseDate,
    required this.posterPath,
    required this.voteAverage,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'],
      title: json['title'],
      releaseDate: json['release_date'],
      posterPath: json['poster_path'],
      voteAverage: json['vote_average'],
    );
  }
}
