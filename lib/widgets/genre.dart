import 'package:flutter/material.dart';

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

class GenreItem extends StatelessWidget {
  const GenreItem({
    super.key,
    required this.name,
  });

  final String name;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(6),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
        color: const Color.fromARGB(255, 37, 40, 54),
        child: Text(
          name,
          style: const TextStyle(
            color: Color.fromARGB(255, 211, 211, 218),
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}
