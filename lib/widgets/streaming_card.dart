import 'package:flutter/material.dart';
import 'package:movie_app/api/tmdb.dart';

class StreamingCard extends StatelessWidget {
  const StreamingCard({
    super.key,
    required this.logoPath,
  });

  final String logoPath;

  @override
  Widget build(context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Image.network(
        tmdb.imageUrl(logoPath, 'original'),
        height: 48,
      ),
    );
  }
}
