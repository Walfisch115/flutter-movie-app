import 'package:flutter/material.dart';

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
        "https://image.tmdb.org/t/p/original$logoPath",
        height: 48,
      ),
    );
  }
}
