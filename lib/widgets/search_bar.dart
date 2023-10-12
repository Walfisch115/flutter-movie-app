import 'package:flutter/material.dart';
import 'package:movie_app/style/my_colors.dart';

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
        style: const TextStyle(
          color: MyColors.darkerWhite,
        ),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(16),
          hintText: 'Suche...',
          hintStyle: const TextStyle(
            color: MyColors.grey,
          ),
          prefixIcon: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.search_rounded,
              color: MyColors.grey,
            ),
          ),
          suffixIcon: IconButton(
            onPressed: onClear,
            icon: const Icon(
              Icons.clear_rounded,
              color: MyColors.grey,
            ),
          ),
          filled: true,
          fillColor: MyColors.bluishGrey,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(
              color: Colors.transparent,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(
              color: MyColors.lightBlue,
            ),
          ),
        ),
      ),
    );
  }
}
