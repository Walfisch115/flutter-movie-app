import 'package:flutter/material.dart';
import 'package:expandable_text/expandable_text.dart';

class Story extends StatelessWidget {
  const Story({
    super.key,
    required this.text,
  });

  final String text;

  Widget _checkText(text) {
    if (text != '') {
      return ExpandableText(
        text,
        expandText: 'mehr',
        collapseText: 'weniger',
        maxLines: 5,
        linkColor: const Color.fromARGB(255, 18, 205, 217),
        linkEllipsis: false,
        animation: true,
        style: const TextStyle(
          color: Color.fromARGB(255, 211, 211, 218),
          fontSize: 16,
          height: 1.5,
        ),
      );
    } else {
      return Row(
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
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return _checkText(text);
  }
}
