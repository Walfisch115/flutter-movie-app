import 'package:flutter/material.dart';

/// Kleine Box mit einer Angabe, z. B. "2023" oder "FSK 12".
/// Optional mit Icon vor dem Text.
class InfoBadge extends StatelessWidget {
  const InfoBadge(this.text, {super.key, this.icon});

  final String text;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    const color = Color.fromARGB(255, 211, 211, 218);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        // Halbtransparent, damit der weichgezeichnete Hintergrund durchscheint.
        color: const Color.fromARGB(40, 255, 255, 255),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, color: color, size: 16),
            const SizedBox(width: 4),
          ],
          Text(
            text,
            style: const TextStyle(
              color: color,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
