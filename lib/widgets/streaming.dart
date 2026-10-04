import 'package:flutter/material.dart';
import 'package:movie_app/style/colors.dart';

import 'package:movie_app/widgets/streaming_card.dart';

class Streaming extends StatelessWidget {
  const Streaming({
    super.key,
    required this.streamingLogos,
  });

  final List<String> streamingLogos;

  @override
  Widget build(context) {
    const grey = AppColors.textSecondary;

    if (streamingLogos.isEmpty) {
      return const Align(
        alignment: Alignment.centerLeft,
        child: Text(
          'Bei keinem Streaming-Dienst im Abo',
          style: TextStyle(color: grey, fontSize: 16),
        ),
      );
    }

    // Align: Die äußere Column der Seite zentriert sonst die Liste.
    return Align(
      alignment: Alignment.centerLeft,
      child: Wrap(
        spacing: 12,
        runSpacing: 12,
        children: streamingLogos
            .map((logoPath) => StreamingCard(logoPath: logoPath))
            .toList(),
      ),
    );
  }
}
