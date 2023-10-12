import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:movie_app/models/movie_detail.dart';
import 'package:movie_app/providers/watchlist_provider.dart';
import 'package:movie_app/style/my_colors.dart';
import 'package:movie_app/utils/image_from_network.dart';

class WatchlistScreen extends ConsumerWidget {
  const WatchlistScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final watchlist = ref.watch(watchlistProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.darkBluishGrey,
        surfaceTintColor: Colors.transparent,
        title: const Text(
          'Watchlist',
          style: TextStyle(color: MyColors.darkerWhite),
        ),
        centerTitle: true,
        shape: const Border(
          bottom: BorderSide(
            color: MyColors.darkerWhite,
            width: 0.5,
          ),
        ),
      ),
      backgroundColor: MyColors.darkBluishGrey,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView.separated(
          itemCount: watchlist.length,
          itemBuilder: (context, index) {
            return ItemCard(
              movie: watchlist[index],
            );
          },
          separatorBuilder: (context, index) {
            return const SizedBox(
              height: 16,
            );
          },
        ),
      ),
    );
  }
}

class ItemCard extends StatelessWidget {
  const ItemCard({
    super.key,
    required this.movie,
  });

  final MovieDetail movie;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 120,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: AspectRatio(
              aspectRatio: 16 / 9,
              child: getImageFromNetwork(movie.backdropPath, 'w300'),
            ),
          ),
        ),
        const SizedBox(
          width: 16,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                movie.title,
                softWrap: false,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: MyColors.white,
                ),
              ),
              const SizedBox(
                height: 2,
              ),
              Text(
                movie.releaseDate == "" ? "N/A" : DateTime.parse(movie.releaseDate).year.toString(),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: MyColors.darkerWhite,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
