import 'package:clot/core/presentation/constants/app_colors.dart';
import 'package:clot/core/presentation/constants/app_svgs.dart';
import 'package:clot/core/presentation/ui/extension/app_spacing_extension.dart';
import 'package:clot/core/presentation/ui/widgets/app_back_button.dart';
import 'package:clot/core/presentation/ui/widgets/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WishList extends StatelessWidget {
  const WishList({super.key});

  static const String routeName = '/wishlist';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        forceMaterialTransparency: true,
        title: Row(
          children: [
            AppBackButton(),
            Expanded(child: Center(child: TextMedium('Wishlist'))),
          ],
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
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
                        SvgPicture.asset(
                          AppSvgs.kHeart,
                          width: 32,
                          height: 32,
                          fit: BoxFit.cover,
                        ),

                        16.horizontalSpace,
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextRegular('My Favorite'),
                            4.verticalSpace,
                            TextSmall(
                              '12 Products',
                              color: AppColors.kBlcak100.withValues(alpha: 0.5),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SvgPicture.asset(
                      AppSvgs.kArrowRight,
                      width: 32,
                      height: 32,
                      fit: BoxFit.cover,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
