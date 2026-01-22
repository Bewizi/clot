import 'package:clot/core/presentation/constants/app_colors.dart';
import 'package:clot/core/presentation/constants/font_manager.dart';
import 'package:clot/core/presentation/ui/extension/app_spacing_extension.dart';
import 'package:clot/core/presentation/ui/extension/fontsize_extension.dart';
import 'package:clot/core/presentation/ui/widgets/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppCard extends StatelessWidget {
  const AppCard({
    super.key,
    required this.image,
    required this.icon,
    required this.name,
    required this.price,
  });

  final String image;
  final String icon;
  final String name;
  final String price;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width * 0.35,
      height: MediaQuery.sizeOf(context).width * 0.18,
      margin: EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        color: AppColors.kLightGrey,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                ClipRRect(
                  // borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    image,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      color: AppColors.kBlcak100.withValues(alpha: 0.5),
                      child: const Icon(
                        Icons.image_not_supported_outlined,
                        size: 30,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 10,
                  right: 0,
                  child: SvgPicture.asset(icon, width: 24, height: 24),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextRegular(name, color: AppColors.kBlcak100, fontSizes: 14.fs),
                8.horizontalSpace,
                TextSmall(
                  price,
                  color: AppColors.kBlcak100,
                  fontWeight: FontManagerWeight.bold,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
