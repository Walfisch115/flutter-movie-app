import 'package:flutter/material.dart';

import 'package:movie_app/widgets/genre_item.dart';

class Genre extends StatelessWidget {
  const Genre({
    super.key,
    required this.genre,
  });

  final List<dynamic> genre;

  _genreToList(List<dynamic> genre) {
    List<Widget> genreList = [];
    for (var element in genre) {
      genreList.add(GenreItem(name: element['name']));
    }
    return genreList;
  }

  @override
  Widget build(context) {
    return Row(
      children: [
        Expanded(
          child: Wrap(
            spacing: 8.0,
            runSpacing: 8.0,
            direction: Axis.horizontal,
            children: _genreToList(genre),
          ),
        ),
      ],
    );
  }
}
