import 'package:flutter/material.dart';

import 'package:movie_app/widgets/streaming_card.dart';

class Streaming extends StatelessWidget {
  const Streaming({
    super.key,
    required this.streamingLogos,
  });

  final List<String> streamingLogos;

  @override
  Widget build(context) {
    return Row(
      children: [
        Expanded(
          child: streamingLogos.isEmpty
              ? const Text(
                  'Nicht verfügbar.',
                  style: TextStyle(
                    color: Color.fromARGB(255, 211, 211, 218),
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                )
              : Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: streamingLogos
                      .map((logoPath) => StreamingCard(logoPath: logoPath))
                      .toList(),
                ),
        ),
      ],
    );
  }
}
