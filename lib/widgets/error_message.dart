import 'package:flutter/material.dart';
import 'package:movie_app/style/colors.dart';

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
            color: AppColors.text,
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}
