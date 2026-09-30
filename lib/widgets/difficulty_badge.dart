import 'package:flutter/material.dart';
import '../models/difficulty.dart';

/// Renders an appetizing pill badge for a recipe's difficulty level,
/// optimized for high contrast in both Light and Dark modes.
class DifficultyBadge extends StatelessWidget {
  final Difficulty difficulty;
  final bool isCompact;

  const DifficultyBadge({
    super.key,
    required this.difficulty,
    this.isCompact = false,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final Color bgColor = isDark
        ? (difficulty == Difficulty.easy
            ? const Color(0xFF0B551F).withValues(alpha: 0.9)
            : (difficulty == Difficulty.medium
                ? const Color(0xFF4C1A00).withValues(alpha: 0.9)
                : const Color(0xFF5C0000).withValues(alpha: 0.9)))
        : (difficulty == Difficulty.easy
            ? const Color(0xFFA0F399).withValues(alpha: 0.95)
            : (difficulty == Difficulty.medium
                ? const Color(0xFFFFF3E0).withValues(alpha: 0.95)
                : const Color(0xFFFFDAD6).withValues(alpha: 0.95)));

    final Color fgColor = isDark
        ? (difficulty == Difficulty.easy
            ? const Color(0xFFA0F399)
            : (difficulty == Difficulty.medium
                ? const Color(0xFFFFB595)
                : const Color(0xFFFFB4AB)))
        : (difficulty == Difficulty.easy
            ? const Color(0xFF1B6D24)
            : (difficulty == Difficulty.medium
                ? const Color(0xFF835100)
                : const Color(0xFFBA1A1A)));

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isCompact ? 7 : 10,
        vertical: isCompact ? 3 : 5,
      ),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: fgColor.withValues(alpha: isDark ? 0.3 : 0.2),
          width: 0.8,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            difficulty.icon,
            size: isCompact ? 11 : 13,
            color: fgColor,
          ),
          const SizedBox(width: 4),
          Text(
            difficulty.label.toUpperCase(),
            style: TextStyle(
              color: fgColor,
              fontSize: isCompact ? 9.5 : 11,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.3,
            ),
          ),
        ],
      ),
    );
  }
}
