import 'package:flutter/material.dart';

import 'package:movie_app/models/person.dart';
import 'package:movie_app/widgets/credits_card.dart';

class Credits extends StatelessWidget {
  const Credits({
    super.key,
    required this.credits,
  });

  final List<Person> credits;

  @override
  Widget build(BuildContext context) {
    if (credits.isEmpty) {
      return const Row(
        children: [
          Text(
            'Keine Informationen.',
            style: TextStyle(
              color: Color.fromARGB(255, 211, 211, 218),
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      );
    }

    return SizedBox(
      height: 200,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: credits.length,
        itemBuilder: (context, index) {
          final person = credits[index];
          return CreditsCard(
            name: person.name,
            role: person.role,
            logoPath: person.profilePath,
          );
        },
        separatorBuilder: (context, index) => const SizedBox(width: 12),
      ),
    );
  }
}
