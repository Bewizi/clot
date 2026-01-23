import 'package:clot/core/presentation/constants/app_colors.dart';
import 'package:clot/core/presentation/constants/icon_size_manager.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class IconContainer extends StatelessWidget {
  const IconContainer({
    super.key,
    required this.child,
    this.onTap,
    this.backgroundColor,
  });

  final Widget child;
  final VoidCallback? onTap;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.pop();
      },
      child: Container(
        width: ValueManager.iconContainerSize,
        height: ValueManager.iconContainerSize,
        padding: EdgeInsets.zero,
        decoration: BoxDecoration(
          color: backgroundColor ?? AppColors.kLightGrey,
          borderRadius: BorderRadius.circular(100),
        ),
        child: Center(child: child),
      ),
    );
  }
}
