import 'package:flutter/material.dart';

/// Überschrift eines Abschnitts auf der Detailseite, z. B. "Handlung".
class SectionTitle extends StatelessWidget {
  const SectionTitle(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        style: const TextStyle(
          color: Color.fromARGB(255, 241, 241, 245),
          fontSize: 22,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
