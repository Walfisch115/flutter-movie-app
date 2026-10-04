import 'package:flutter/material.dart';

/// Bereits berechnete Farben pro Bild-URL. So wird jedes Bild nur einmal
/// ausgewertet, auch wenn die Karte beim Scrollen neu gebaut wird.
final Map<String, Future<Color>> _cache = {};

/// Hauptfarbe eines Bildes, als helle Variante für einen dunklen Hintergrund.
///
/// Nutzt [ColorScheme.fromImageProvider], das in Flutter eingebaut ist
/// (kein zusätzliches Paket nötig).
Future<Color> imageColor(String imageUrl) {
  return _cache.putIfAbsent(imageUrl, () async {
    final scheme = await ColorScheme.fromImageProvider(
      provider: NetworkImage(imageUrl),
      brightness: Brightness.dark,
    );
    return scheme.primary;
  });
}
