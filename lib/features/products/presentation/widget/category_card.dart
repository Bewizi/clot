import 'package:clot/core/presentation/constants/app_colors.dart';
import 'package:clot/core/presentation/ui/extension/app_spacing_extension.dart';
import 'package:clot/core/presentation/ui/widgets/text_styles.dart';
import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    super.key,
    required this.name,
    required this.imageUrl,
    this.onTap,
  });

  final String name;
  final String imageUrl;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: InkWell(
        onTap: onTap,
        child: Container(
          width: MediaQuery.sizeOf(context).width,
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),

          decoration: BoxDecoration(
            color: AppColors.kLightGrey,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Image.network(
                imageUrl,
                width: 60,
                height: 60,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.image_not_supported_rounded, size: 16),
              ),

              16.horizontalSpace,
              TextRegular(name, color: AppColors.kBlcak100),
            ],
          ),
        ),
      ),
    );
  }
}
