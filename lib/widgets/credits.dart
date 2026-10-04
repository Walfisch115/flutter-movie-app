import 'package:flutter/material.dart';
import 'package:movie_app/style/colors.dart';

import 'package:movie_app/api/tmdb.dart';
import 'package:movie_app/models/person.dart';

/// Besetzung und Crew als Liste: rundes Foto links, Name und Rolle rechts.
/// Zuerst sind nur wenige Personen sichtbar, der Rest lässt sich ausklappen.
class Credits extends StatefulWidget {
  const Credits({
    super.key,
    required this.credits,
  });

  final List<Person> credits;

  @override
  State<Credits> createState() => _CreditsState();
}

class _CreditsState extends State<Credits> {
  /// Sichtbar, solange die Liste eingeklappt ist.
  static const int _collapsedCount = 5;

  /// Höchstens so viele Personen beim Ausklappen. TMDB liefert oft 50 und mehr.
  static const int _maxPeople = 15;

  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final credits = widget.credits;

    if (credits.isEmpty) {
      return const Align(
        alignment: Alignment.centerLeft,
        child: Text(
          'Keine Informationen.',
          style: TextStyle(
            color: AppColors.textSecondary,
            fontSize: 16,
          ),
        ),
      );
    }

    final allPeople = credits.take(_maxPeople).toList();
    final shownPeople =
        _expanded ? allPeople : allPeople.take(_collapsedCount).toList();

    // Ausklappen lohnt sich nur, wenn es mehr Personen gibt als sichtbar sind.
    final canExpand = allPeople.length > _collapsedCount;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final person in shownPeople)
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Row(
              children: [
                ClipOval(
                  child: SizedBox.square(
                    dimension: 48,
                    child: _photo(person.profilePath),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        person.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: AppColors.text,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        person.role,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: AppColors.textMuted,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        if (canExpand)
          TextButton(
            onPressed: () => setState(() => _expanded = !_expanded),
            style: TextButton.styleFrom(
              foregroundColor: AppColors.accent,
              // Kein Mindestmaß, sonst entsteht über dem Text viel Leerraum.
              padding: const EdgeInsets.symmetric(vertical: 4),
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: Text(_expanded ? 'Weniger anzeigen' : 'Alle anzeigen'),
          ),
      ],
    );
  }

  /// Foto der Person oder ein Platzhalter, wenn TMDB keins hat.
  Widget _photo(String? path) {
    if (path == null) {
      return Container(
        color: AppColors.surface,
        child: const Icon(
          Icons.person_outline,
          color: AppColors.hint,
        ),
      );
    }

    return Image.network(
      tmdb.imageUrl(path, 'w185'),
      fit: BoxFit.cover,
    );
  }
}
