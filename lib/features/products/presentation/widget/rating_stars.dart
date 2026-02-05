import 'package:clot/core/presentation/constants/app_colors.dart';
import 'package:flutter/material.dart';

/// A simple, reusable rating stars widget.
///
/// - `total` - total number of stars (default 5)
/// - `value` - current rating value (supports partial values like 4.5)
/// - `size` - icon size
/// - `activeColor` and `inactiveColor` - colors for filled/unfilled portions
/// - `isInteractive` and `onChanged` - make the stars tappable and receive updates
class RatingStars extends StatelessWidget {
  final int total;
  final double value;
  final Set<int>?
  highlightedIndices; // optional explicit indices to highlight (0-based)
  final double size;
  final Color activeColor;
  final Color inactiveColor;
  final bool isInteractive;
  final ValueChanged<double>? onChanged;

  const RatingStars({
    Key? key,
    this.total = 5,
    this.value = 0.0,
    this.highlightedIndices,
    this.size = 20.0,
    this.activeColor = AppColors.kPrimary,
    this.inactiveColor = AppColors.kBlcak100,
    this.isInteractive = false,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(total, (index) {
        final lower = index.toDouble();
        final upper = index + 1.0;
        final usesIndices = highlightedIndices != null;
        final isFilled = usesIndices
            ? highlightedIndices!.contains(index)
            : value >= upper;
        final isPartial = !usesIndices && value > lower && value < upper;

        Widget star;
        if (isPartial) {
          // draw a partially filled star using a ClipRect
          star = Stack(
            alignment: Alignment.centerLeft,
            children: [
              Icon(
                Icons.star_border,
                size: size,
                color: inactiveColor.withValues(alpha: 0.6),
              ),
              ClipRect(
                child: Align(
                  alignment: Alignment.centerLeft,
                  widthFactor: (value - lower).clamp(0.0, 1.0),
                  child: Icon(Icons.star, size: size, color: activeColor),
                ),
              ),
            ],
          );
        } else {
          star = Icon(
            isFilled ? Icons.star : Icons.star_border,
            size: size,
            color: isFilled
                ? activeColor
                : inactiveColor.withValues(alpha: 0.6),
          );
        }

        if (!isInteractive) {
          return Padding(
            padding: const EdgeInsets.only(right: 4.0),
            child: star,
          );
        }

        return GestureDetector(
          onTap: () => onChanged?.call(index + 1.0),
          child: Padding(
            padding: const EdgeInsets.only(right: 4.0),
            child: star,
          ),
        );
      }),
    );
  }
}
