import 'package:flutter/material.dart';
import 'package:movie_app/widgets/credits_card.dart';

class Credits extends StatelessWidget {
  const Credits({
    super.key,
    required this.credits,
  });

  final Map<String, dynamic> credits;

  _creditsToList(Map<String, dynamic> credits) {
    List<Widget> creditsList = [];

    for (var element in credits['crew']) {
      if (element['job'] == 'Director') {
        creditsList.add(
          CreditsCard(
            name: element['name'],
            role: 'Regisseur',
            logoPath: element['profile_path'],
          ),
        );
      }
    }

    for (var element in credits['cast']) {
      creditsList.add(
        CreditsCard(
          name: element['name'],
          role: element['character'],
          logoPath: element['profile_path'],
        ),
      );
    }

    return creditsList;
  }

  @override
  Widget build(BuildContext context) {
    return _creditsToList(credits).isEmpty
        ? Row(
            children: const [
              Text(
                'Keine Informationen.',
                style: TextStyle(
                  color: Color.fromARGB(255, 211, 211, 218),
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          )
        : SizedBox(
            height: 200,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: _creditsToList(credits).length,
              itemBuilder: (context, index) {
                return _creditsToList(credits)[index];
              },
              separatorBuilder: (context, index) {
                return const SizedBox(width: 12);
              },
            ),
          );
  }
}
