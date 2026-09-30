import 'package:flutter/material.dart';

import 'package:movie_app/widgets/genre_item.dart';

class Genre extends StatelessWidget {
  const Genre({
    super.key,
    required this.genres,
  });

  final List<String> genres;

  @override
  Widget build(context) {
    return Row(
      children: [
        Expanded(
          child: Wrap(
            spacing: 8.0,
            runSpacing: 8.0,
            direction: Axis.horizontal,
            children: genres.map((name) => GenreItem(name: name)).toList(),
          ),
        ),
      ],
    );
  }
}
