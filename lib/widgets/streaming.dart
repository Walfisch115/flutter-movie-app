import 'package:flutter/material.dart';
import 'package:movie_app/widgets/streaming_card.dart';

class Streaming extends StatelessWidget {
  const Streaming({
    super.key,
    required this.streamingProviders,
  });

  final Map<String, dynamic> streamingProviders;

  Widget _streamingProviders(Map<String, dynamic> streamingProviders) {
    List<Widget> providerList = [];

    Widget error = const Text(
      'Nicht verfügbar.',
      style: TextStyle(
        color: Color.fromARGB(255, 211, 211, 218),
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
    );

    if (streamingProviders['results'] != null) {
      if (streamingProviders['results']['DE'] != null) {
        if (streamingProviders['results']['DE']['flatrate'] != null) {
          for (var element in streamingProviders['results']['DE']['flatrate']) {
            providerList.add(
              StreamingCard(
                logoPath: element['logo_path'],
              ),
            );
          }
          return Expanded(
            child: Wrap(
              spacing: 12,
              runSpacing: 12.0,
              direction: Axis.horizontal,
              children: providerList,
            ),
          );
        } else {
          return error;
        }
      } else {
        return error;
      }
    } else {
      return error;
    }
  }

  @override
  Widget build(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            _streamingProviders(streamingProviders),
          ],
        )
      ],
    );
  }
}
