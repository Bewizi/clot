import 'package:clot/core/presentation/constants/app_colors.dart';
import 'package:clot/core/presentation/ui/widgets/text_styles.dart';
import 'package:flutter/widgets.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.onTap,
    this.text,
    this.color = AppColors.kPrimary,
    this.textColor = AppColors.kWhite100,
    this.borderRadius = 100.0,
    this.borderColor,
    this.borderWidth = 1.0,
    this.child,
    this.padding,
  });

  final String? text;
  final VoidCallback? onTap;
  final Color? color;
  final Color? textColor;
  final double borderRadius;
  final Color? borderColor;
  final double borderWidth;
  final Widget? child;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        // width: constraints.maxWidth,
        padding:
            padding ?? const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(borderRadius),
          border: borderColor != null
              ? Border.all(color: borderColor!, width: borderWidth)
              : null,
        ),
        alignment: Alignment.center,
        child: child ??
            TextRegular(
              text ?? '',
              color: textColor,
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }
}