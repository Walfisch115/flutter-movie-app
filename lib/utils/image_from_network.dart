import 'package:flutter/material.dart';

Widget getImageFromNetwork(String? imagePath, String resolution) {
  if (imagePath != null) {
    return Image.network(
      "https://image.tmdb.org/t/p/$resolution$imagePath",
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
