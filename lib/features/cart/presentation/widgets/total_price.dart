import 'package:clot/core/presentation/constants/app_colors.dart';
import 'package:clot/core/presentation/ui/extension/app_spacing_extension.dart';
import 'package:clot/core/presentation/ui/widgets/text_styles.dart';
import 'package:flutter/material.dart';

Widget buildReview() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      buildPrices('Subtotal', '\$200'),
      16.verticalSpace,
      buildPrices('Shipping Cost', '\$8.00'),
      16.verticalSpace,
      buildPrices('Tax', '\$0.00'),
      16.verticalSpace,
      buildPrices('Total', '\$208'),
    ],
  );
}

Widget buildPrices(String text, String price) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      TextRegular(text, color: AppColors.kBlcak100.withValues(alpha: 0.5)),
      TextRegular(price),
    ],
  );
}
