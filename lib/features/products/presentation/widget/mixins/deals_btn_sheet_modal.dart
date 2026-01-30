import 'package:clot/core/presentation/constants/app_colors.dart';
import 'package:clot/core/presentation/constants/app_svgs.dart';
import 'package:clot/core/presentation/ui/extension/app_spacing_extension.dart';
import 'package:clot/core/presentation/ui/widgets/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

mixin DealsBtnSheetModal {
  void showDealsModalSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        // Use a StatefulBuilder so the modal can keep local selected state
        String? selectedLabel = 'On sale';

        return StatefulBuilder(
          builder: (context, setState) {
            Widget dealsItem(String label) => _buildDealsItem(
              label,
              context,
              selectedLabel == label,
              () => setState(() => selectedLabel = label),
            );

            return Container(
              width: MediaQuery.sizeOf(context).width,
              // height: MediaQuery.sizeOf(context).height * 0.5,
              decoration: BoxDecoration(
                color: AppColors.kWhite100,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),

              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () => setState(() => selectedLabel = null),
                        child: TextRegular('Clear'),
                      ),
                      TextMedium('Deals'),
                      GestureDetector(
                        onTap: () => context.pop(),
                        child: SvgPicture.asset(
                          AppSvgs.kCloseIcon,
                          height: 24,
                          width: 24,
                        ),
                      ),
                    ],
                  ),

                  24.verticalSpace,
                  Column(
                    children: [
                      dealsItem('On sale'),
                      dealsItem('Free Shipping Eligible'),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildDealsItem(
    String label,
    BuildContext context,
    bool isSelected,
    VoidCallback? onTap,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: isSelected ? AppColors.kPrimary : AppColors.kLightGrey,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextRegular(
                label,
                color: isSelected ? AppColors.kWhite100 : AppColors.kBlcak100,
              ),
              isSelected
                  ? SvgPicture.asset(AppSvgs.kCheckLine, height: 24, width: 24)
                  : const SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }
}
