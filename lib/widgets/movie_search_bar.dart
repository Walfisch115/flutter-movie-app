import 'package:flutter/material.dart';
import 'package:movie_app/style/colors.dart';

class MovieSearchBar extends StatelessWidget {
  const MovieSearchBar({
    super.key,
    required this.textController,
    this.focusNode,
    required this.onClear,
    required this.onSubmitted,
  });

  final TextEditingController textController;
  final FocusNode? focusNode;
  final VoidCallback onClear;
  final Function(String)? onSubmitted;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textController,
      focusNode: focusNode,
      onSubmitted: onSubmitted,
      onTapOutside: (event) {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      style: const TextStyle(color: AppColors.text),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(16),
        hintText: 'Suchen...',
        hintStyle: const TextStyle(
          color: AppColors.hint,
        ),
        prefixIcon: const Icon(
          Icons.search_rounded,
          color: AppColors.hint,
        ),
        suffixIcon: IconButton(
          onPressed: onClear,
          icon: const Icon(
            Icons.clear_rounded,
            color: AppColors.hint,
          ),
        ),
        filled: true,
        fillColor: AppColors.surface,
        // Dünner, dezenter Rahmen im Ruhezustand.
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
            color: AppColors.border,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
            color: AppColors.accent,
          ),
        ),
      ),
    );
  }
}
