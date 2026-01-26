import 'package:clot/core/presentation/constants/app_colors.dart';
import 'package:clot/core/presentation/constants/app_svgs.dart';
import 'package:clot/core/presentation/ui/extension/app_spacing_extension.dart';
import 'package:clot/core/presentation/ui/widgets/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class OrderStatus extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool isCompleted;
  final bool isFirst;
  final bool isLast;

  const OrderStatus({
    super.key,
    required this.title,
    required this.subtitle,
    this.isCompleted = false,
    this.isFirst = false,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              height: 24,
              width: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isCompleted ? AppColors.kPrimary : AppColors.kLightGrey,
              ),
              child: isCompleted
                  ? SvgPicture.asset(AppSvgs.kCheckLine, width: 8, height: 8)
                  : null,
            ),
            if (!isLast) SizedBox(width: 1, height: 51),
          ],
        ),
        16.horizontalSpace,
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [TextRegular(title), TextSmall(subtitle)],
          ),
        ),
      ],
    );
  }
}

class OrderItems extends StatelessWidget {
  const OrderItems({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.kLightGrey,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          SvgPicture.asset(AppSvgs.kReceipt),
          16.horizontalSpace,
          const TextRegular('4 items'),
          const Spacer(),
          const TextRegular('View All', color: AppColors.kPrimary),
        ],
      ),
    );
  }
}

class ShippingDetails extends StatelessWidget {
  const ShippingDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TextRegular('Shipping details'),
        16.verticalSpace,
        Container(
          width: MediaQuery.sizeOf(context).width,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: AppColors.kLightGrey,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TextSmall('2715 Ash Dr. San Jose, South Dakota 83475'),
              8.verticalSpace,
              const TextSmall('121-224-7890'),
            ],
          ),
        ),
      ],
    );
  }
}
