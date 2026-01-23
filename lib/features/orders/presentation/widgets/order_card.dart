import 'package:clot/core/presentation/constants/app_colors.dart';
import 'package:clot/core/presentation/constants/app_svgs.dart';
import 'package:clot/core/presentation/ui/extension/app_spacing_extension.dart';
import 'package:clot/core/presentation/ui/widgets/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OrderCard extends StatelessWidget {
  const OrderCard({
    super.key,
    required this.icon,
    required this.text,
    required this.item,
    this.onTap,
  });

  final String icon;
  final String text;
  final String item;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: MediaQuery.sizeOf(context).width,
        padding: const EdgeInsets.all(24),

        decoration: BoxDecoration(
          color: AppColors.kLightGrey,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            SvgPicture.asset(
              icon,
              width: 32,
              height: 32,
              colorFilter: ColorFilter.mode(
                AppColors.kBlcak100,
                BlendMode.srcIn,
              ),
            ),

            16.horizontalSpace,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextRegular(text, color: AppColors.kBlcak100),
                  4.verticalSpace,
                  TextSmall(
                    item,
                    color: AppColors.kBlcak100.withValues(alpha: 0.5),
                  ),
                ],
              ),
            ),

            SvgPicture.asset(AppSvgs.kArrowRight, width: 32, height: 32),
          ],
        ),
      ),
    );
  }
}
