import 'package:clot/core/presentation/ui/extension/app_spacing_extension.dart';
import 'package:clot/core/presentation/ui/widgets/text_styles.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FilterProduct extends StatelessWidget {
  const FilterProduct({
    super.key,
    required this.title,
    this.icon,
    this.onTap,
    this.color,
    this.textColor,
  });

  final String title;
  final String? icon;
  final VoidCallback? onTap;
  final Color? color;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),

      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(100),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextSmall(title, color: textColor),
          if (icon != null) 8.horizontalSpace,
          if (icon != null) SvgPicture.asset(icon!),
        ],
      ),
    );
  }
}
