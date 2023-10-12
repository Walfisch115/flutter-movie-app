import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_app/models/movie_detail.dart';

class WatchlistNotifier extends StateNotifier<List<MovieDetail>> {
  WatchlistNotifier() : super([]);

  bool toggleWatchlistStatus(MovieDetail movie) {
    bool onWatchlist = false;

    for (var element in state) {
      if (element.id == movie.id) {
        onWatchlist = true;
      }
    }

    if (onWatchlist) {
      state = state.where((element) => element.id != movie.id).toList();
      return false;
    } else {
      state = [movie, ...state];
      return true;
    }
  }
}

final watchlistProvider = StateNotifierProvider<WatchlistNotifier, List<MovieDetail>>((ref) {
  return WatchlistNotifier();
});
