import 'package:flutter/material.dart';

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
