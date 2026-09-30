import 'package:flutter/material.dart';

class ErrorMessage extends StatelessWidget {
  const ErrorMessage({
    super.key,
    required this.error,
  });

  final Object? error;

  @override
  Widget build(BuildContext context) {
    // Aus 'Exception: API-Key ungültig' wird 'API-Key ungültig'.
    final message = error.toString().replaceFirst('Exception: ', '');

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Text(
          message,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Color.fromARGB(255, 241, 241, 245),
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}
