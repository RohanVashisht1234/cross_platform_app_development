import 'package:flutter/material.dart';

/// Universal recipe image component supporting both local assets and network URLs
/// with smooth loading, graceful fallback, and border radius clipping.
class AppRecipeImage extends StatelessWidget {
  final String imageUrl;
  final BoxFit fit;
  final double? width;
  final double? height;
  final BorderRadius? borderRadius;

  const AppRecipeImage({
    super.key,
    required this.imageUrl,
    this.fit = BoxFit.cover,
    this.width,
    this.height,
    this.borderRadius,
  });

  Widget _buildFallback(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isDark
              ? [const Color(0xFF2A2A2A), const Color(0xFF1E1E1E)]
              : [const Color(0xFFFFE0D2), const Color(0xFFFFD1BA)],
        ),
      ),
      child: Center(
        child: Icon(
          Icons.restaurant_rounded,
          color: isDark ? const Color(0xFFEE671C) : const Color(0xFF9E3D00),
          size: (width != null && width! < 50) ? 20 : 36,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget imageWidget;

    if (imageUrl.startsWith('assets/')) {
      imageWidget = Image.asset(
        imageUrl,
        width: width,
        height: height,
        fit: fit,
        errorBuilder: (context, error, stackTrace) => _buildFallback(context),
      );
    } else if (imageUrl.startsWith('http://') || imageUrl.startsWith('https://')) {
      imageWidget = Image.network(
        imageUrl,
        width: width,
        height: height,
        fit: fit,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return Container(
            width: width,
            height: height,
            color: Theme.of(context).colorScheme.surfaceContainerHighest.withValues(alpha: 0.4),
            child: const Center(
              child: SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            ),
          );
        },
        errorBuilder: (context, error, stackTrace) => _buildFallback(context),
      );
    } else if (imageUrl.isNotEmpty) {
      // Default to asset in case path doesn't start with assets/
      imageWidget = Image.asset(
        imageUrl,
        width: width,
        height: height,
        fit: fit,
        errorBuilder: (context, error, stackTrace) => _buildFallback(context),
      );
    } else {
      imageWidget = _buildFallback(context);
    }

    if (borderRadius != null) {
      return ClipRRect(
        borderRadius: borderRadius!,
        child: imageWidget,
      );
    }

    return imageWidget;
  }
}
