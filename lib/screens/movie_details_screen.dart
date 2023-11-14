import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:movie_app/api/tmdb.dart';
import 'package:movie_app/models/movie_detail.dart';
import 'package:movie_app/providers/watchlist_provider.dart';
import 'package:movie_app/style/my_colors.dart';
import 'package:movie_app/widgets/icon_feature.dart';
import 'package:movie_app/widgets/section_heading.dart';
import 'package:movie_app/widgets/story.dart';
import 'package:movie_app/widgets/streaming.dart';
import 'package:movie_app/widgets/genre.dart';
import 'package:movie_app/widgets/header.dart';
import 'package:movie_app/widgets/credits.dart';
import 'package:movie_app/widgets/transparent_appbar.dart';

class MovieDetailsScreen extends ConsumerStatefulWidget {
  const MovieDetailsScreen({
    super.key,
    required this.id,
  });

  final int id;

  @override
  ConsumerState<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends ConsumerState<MovieDetailsScreen> {
  final ScrollController _scrollController = ScrollController();

  String _formatRuntime(int runtime) {
    int hours = runtime ~/ 60;
    int minutes = runtime % 60;
    return '${hours == 0 ? '' : '$hours Std. '}$minutes Min.';
  }

  String _formatReleaseDate(String releaseDate) {
    if (releaseDate != "") {
      var date = DateTime.parse(releaseDate);

      String day = date.day.toString();
      String month = date.month.toString();
      String year = date.year.toString();

      return '$day.$month.$year';
    } else {
      return 'N/A';
    }
  }

  late MovieDetail movie;
  bool wasLoaded = false;

  bool _isOnWatchlist(List<MovieDetail> list, MovieDetail movie) {
    bool onWatchlist = false;

    for (var element in list) {
      if (element.id == movie.id) {
        onWatchlist = true;
      }
    }
    return onWatchlist;
  }

  @override
  void initState() {
    getMovieDetails(widget.id).then((result) {
      setState(() {
        movie = result;
        wasLoaded = true;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (wasLoaded == true) {
      final watchlist = ref.watch(watchlistProvider);
      final isOnWatchlist = _isOnWatchlist(watchlist, movie);

      double screenWidth = MediaQuery.of(context).size.width;

      return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: TransparentAppBar(
          scrollController: _scrollController,
          title: movie.title,
          screenWidth: screenWidth,
          actions: [
            IconButton(
              onPressed: () {
                // maybe add snackbar
                // final wasAdded = ref.read(watchlistProvider.notifier).toggleWatchlistStatus(movie);
                ref.read(watchlistProvider.notifier).toggleWatchlistStatus(movie);
              },
              icon: Icon(
                isOnWatchlist ? Icons.star_rounded : Icons.star_outline_rounded,
              ),
            ),
          ],
        ),
        backgroundColor: const Color.fromARGB(255, 31, 29, 43),
        body: SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Header(
                imagePath: movie.backdropPath,
                title: movie.title,
                rating: movie.voteAverage,
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    Genre(genre: movie.genre),
                    const SizedBox(height: 16),
                    IconFeature(
                      text: _formatRuntime(movie.runtime),
                      icon: Icons.schedule_rounded,
                      iconSize: 18,
                    ),
                    const SizedBox(height: 12),
                    IconFeature(
                      text: _formatReleaseDate(movie.releaseDate),
                      icon: Icons.calendar_today_outlined,
                      iconSize: 16,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    const SectionHeading(
                      text: 'Handlung',
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Story(
                      text: movie.overview,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    const SectionHeading(
                      text: 'Streaming',
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Streaming(
                      streamingProviders: movie.watchProvider,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Column(
                  children: [
                    const SectionHeading(
                      text: 'Besetzung und Crew',
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Credits(
                      credits: movie.credits,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 16,
              ),
            ],
          ),
        ),
      );
    } else {
      return const Scaffold(
        backgroundColor: MyColors.darkBluishGrey,
        body: Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(MyColors.lightBlue),
          ),
        ),
      );
    }
  }
}
