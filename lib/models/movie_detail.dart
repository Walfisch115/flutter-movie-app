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
    );
  }

  String get getReleaseDate {
    if (releaseDate != "") {
      // String locale = Localizations.localeOf(context).languageCode;
      // DateTime date = DateTime.parse(releaseDate);

      // String day = DateFormat.d(locale).format(date);
      // String month = DateFormat.MMMM(locale).format(date);
      // String year = DateFormat.y(locale).format(date);

      var date = DateTime.parse(releaseDate);

      String day = date.day.toString();
      String month = date.month.toString();
      String year = date.year.toString();

      return '$day.$month.$year';
    } else {
      return 'N/A';
    }
  }

  String get getRuntime {
    int hours = runtime ~/ 60;
    int minutes = runtime % 60;
    return '${hours == 0 ? '' : '$hours Std. '}$minutes Min.';
  }

  // String getFormattedDate(context) {
  //   String locale = Localizations.localeOf(context).toLanguageTag();
  //   DateTime parsedDate = DateTime.parse(releaseDate);

  //   String day = DateFormat.d(locale).format(parsedDate);
  //   String month = DateFormat.MMMM(locale).format(parsedDate);
  //   String year = DateFormat.y(locale).format(parsedDate);

  //   DateFormat outputFormat = DateFormat('dd. MMMM yyyy');
  //   String date = outputFormat.format(parsedDate);

  //   return '$day. $month $year';
  // }
}
