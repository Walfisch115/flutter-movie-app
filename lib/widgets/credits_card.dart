import 'package:flutter/material.dart';

class CreditsCard extends StatelessWidget {
  const CreditsCard({
    super.key,
    required this.name,
    required this.role,
    required this.logoPath,
  });

  final String name;
  final String role;
  final String? logoPath;

  Widget _getImageFromNetwork(imagePath) {
    if (imagePath != null) {
      return Image.network(
        "https://image.tmdb.org/t/p/h632$imagePath",
        fit: BoxFit.cover,
      );
    } else {
      return Container(
        color: Colors.grey[700],
        child: const Icon(
          Icons.not_interested_rounded,
          color: Colors.grey,
        ),
      );
    }
  }

  @override
  Widget build(context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Container(
        width: 100,
        color: const Color.fromARGB(255, 37, 40, 54),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AspectRatio(
              aspectRatio: 2 / 3,
              child: _getImageFromNetwork(logoPath),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: Text(
                          name,
                          softWrap: false,
                          overflow: TextOverflow.fade,
                          style: const TextStyle(
                            color: Color.fromARGB(255, 211, 211, 218),
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          role,
                          softWrap: false,
                          overflow: TextOverflow.fade,
                          style: const TextStyle(
                            color: Color.fromARGB(255, 211, 211, 218),
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
