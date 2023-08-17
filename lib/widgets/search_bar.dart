import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({
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
    return Material(
      elevation: 16,
      shadowColor: Colors.black,
      color: Colors.transparent,
      child: TextField(
        controller: textController,
        onSubmitted: onSubmitted,
        onTapOutside: (event) {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        style: const TextStyle(color: Color(0xfff1f1f5)),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(16),
          hintText: 'Suche...',
          hintStyle: const TextStyle(
            color: Color.fromARGB(255, 105, 105, 116),
          ),
          prefixIcon: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.search_rounded,
              color: Color.fromARGB(255, 105, 105, 116),
            ),
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
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(
              color: Colors.transparent,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(
              color: Color.fromARGB(255, 18, 205, 217),
            ),
          ),
        ),
      ),
    );
  }
}
