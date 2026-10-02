import 'package:flutter/material.dart';

class MovieSearchBar extends StatelessWidget {
  const MovieSearchBar({
    super.key,
    required this.textController,
    required this.onClear,
    required this.onSubmitted,
  });

  final TextEditingController textController;
  final VoidCallback onClear;
  final Function(String)? onSubmitted;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textController,
      onSubmitted: onSubmitted,
      onTapOutside: (event) {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      style: const TextStyle(color: Color(0xfff1f1f5)),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(16),
        hintText: 'Suchen...',
        hintStyle: const TextStyle(
          color: Color.fromARGB(255, 105, 105, 116),
        ),
        prefixIcon: const Icon(
          Icons.search_rounded,
          color: Color.fromARGB(255, 105, 105, 116),
        ),
        suffixIcon: IconButton(
          onPressed: onClear,
          icon: const Icon(
            Icons.clear_rounded,
            color: Color.fromARGB(255, 105, 105, 116),
          ),
        ),
        filled: true,
        fillColor: const Color.fromARGB(255, 37, 40, 54),
        // Dünner, dezenter Rahmen im Ruhezustand.
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
            color: Color.fromARGB(255, 55, 58, 76),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
            color: Color.fromARGB(255, 18, 205, 217),
          ),
        ),
      ),
    );
  }
}
