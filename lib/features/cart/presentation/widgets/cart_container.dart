import 'package:clot/core/presentation/constants/app_colors.dart';
import 'package:clot/core/presentation/constants/app_svgs.dart';
import 'package:clot/core/presentation/ui/extension/app_spacing_extension.dart';
import 'package:clot/core/presentation/ui/extension/fontsize_extension.dart';
import 'package:clot/core/presentation/ui/widgets/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

Widget buildCartContainer(
  String productImage,
  String productName,
  String productSize,
  String productColor,
  String price,
) {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: AppColors.kLightGrey,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            //   images
            ClipRRect(
              borderRadius: BorderRadiusGeometry.circular(4),
              child: Image.asset(
                productImage,
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
            ),
            8.horizontalSpace,
            //   column Text
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextRegular(productName, fontSizes: 14.fs),
                8.verticalSpace,
                Row(
                  children: [
                    AppRichText(
                      text: 'Size - ',
                      color: AppColors.kBlcak100.withValues(alpha: 0.5),
                      textSpan: [
                        TextSpan(
                          text: productSize,
                          style: TextStyle(color: AppColors.kBlcak100),
                        ),
                      ],
                    ),
                    16.horizontalSpace,
                    AppRichText(
                      text: 'Color - ',
                      color: AppColors.kBlcak100.withValues(alpha: 0.5),
                      textSpan: [
                        TextSpan(
                          text: productColor,
                          style: TextStyle(color: AppColors.kBlcak100),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextRegular(price, fontSizes: 14.fs),
            8.verticalSpace,
            Row(
              children: [
                buildQuantityButton(AppSvgs.kAddIcon),
                8.horizontalSpace,
                buildQuantityButton(AppSvgs.kMinusIcon),
              ],
            ),
          ],
        ),
      ],
    ),
  );
}

Widget buildQuantityButton(String icon) {
  return Container(
    padding: const EdgeInsets.all(8),
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: AppColors.kPrimary,
    ),
    child: Center(child: SvgPicture.asset(icon, width: 16, height: 16)),
  );
}
