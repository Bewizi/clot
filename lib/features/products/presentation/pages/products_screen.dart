import 'package:clot/core/presentation/constants/app_colors.dart';
import 'package:clot/core/presentation/constants/app_images.dart';
import 'package:clot/core/presentation/constants/app_svgs.dart';
import 'package:clot/core/presentation/constants/font_manager.dart';
import 'package:clot/core/presentation/ui/extension/app_spacing_extension.dart';
import 'package:clot/core/presentation/ui/extension/fontsize_extension.dart';
import 'package:clot/core/presentation/ui/widgets/app_back_button.dart';
import 'package:clot/core/presentation/ui/widgets/text_styles.dart';
import 'package:clot/features/cart/presentation/pages/cart_page.dart';
import 'package:clot/features/products/presentation/widget/mixins/color_btn_sheet_modal.dart';
import 'package:clot/features/products/presentation/widget/mixins/size_btn_sheet_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  static const String routeName = '/products';

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen>
    with SizeBtnSheetModal, ColorBtnSheetModal {
  List<String> images = [AppImages.kJacket1, AppImages.kJacket2];

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;

    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AppBackButton(),

            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.kLightGrey,
              ),
              padding: const EdgeInsets.all(12),
              child: Center(
                child: SvgPicture.asset(AppSvgs.kHeart, width: 24, height: 24),
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top fixed area (image + title + short details) - NOT scrollable
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: screenHeight * 0.35,
                    child: PageView.builder(
                      itemCount: images.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 16),
                          child: Image.asset(
                            images[index],
                            fit: BoxFit.contain,
                          ),
                        );
                      },
                    ),
                  ),

                  24.verticalSpace,
                  TextRegular(
                    "Men's Harrington Jacket",
                    fontWeight: FontManagerWeight.extraBold,
                  ),
                  16.verticalSpace,
                  TextRegular("\$148", color: AppColors.kPrimary),

                  32.verticalSpace,

                  buildSizeOption(),
                  16.verticalSpace,
                  buildColorOption(),
                  16.verticalSpace,
                  buildQuantityOption(),
                ],
              ),

              32.verticalSpace,

              // Scrollable area for shipping, reviews and other long content
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildDiscriptionSection(),
                      24.verticalSpace,
                      buildShippingAndReturns(),
                      24.verticalSpace,
                      buildReviewsSection(),

                      // Add extra space so last content is visible above bottom bar
                      SizedBox(height: 80),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),

      // Fixed bottom bar with price and Add to Bag button
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: GestureDetector(
          onTap: () => context.push(CartPage.routeName),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
            decoration: BoxDecoration(
              color: AppColors.kPrimary,
              borderRadius: BorderRadius.circular(100),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextRegular(
                  '\$148',
                  color: AppColors.kWhite100,
                  fontWeight: FontManagerWeight.extraBold,
                ),
                const SizedBox(width: 16),

                TextRegular('Add to Bag', color: AppColors.kWhite100),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Build Size Option Widget
  Widget buildSizeOption() {
    return GestureDetector(
      onTap: () => showSizeModalSheet(context),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: AppColors.kLightGrey,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextRegular('Size', fontWeight: FontManagerWeight.medium),
            Row(
              children: [
                TextRegular('S', color: AppColors.kBlcak100),
                32.horizontalSpace,
                SvgPicture.asset(AppSvgs.kArrowDown),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Build Color Option Widget
  Widget buildColorOption() {
    return GestureDetector(
      onTap: () => showColorModalSheet(context),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: AppColors.kLightGrey,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextRegular('Color', fontWeight: FontManagerWeight.medium),
            Row(
              children: [
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.kPrimary,
                  ),
                ),
                32.horizontalSpace,
                SvgPicture.asset(AppSvgs.kArrowDown),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildQuantityOption() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: AppColors.kLightGrey,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextRegular('Quantity', fontWeight: FontManagerWeight.medium),
          Row(
            children: [
              buildQuantityButton(AppSvgs.kAddIcon),
              24.horizontalSpace,

              TextRegular('1', color: AppColors.kBlcak100),
              24.horizontalSpace,
              buildQuantityButton(AppSvgs.kMinusIcon),
            ],
          ),
        ],
      ),
    );
  }

  // Build Quantity Button Widget
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

  // Build Shipping and Returns Section
  Widget buildShippingAndReturns() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextRegular('Shipping & Returns', fontWeight: FontManagerWeight.bold),
        16.verticalSpace,
        TextRegular(
          'Free standard shipping and free 60-day returns',
          fontSizes: 14.fs,
          color: AppColors.kBlcak100.withValues(alpha: 0.5),
        ),
      ],
    );
  }

  // Build Reviews Section
  Widget buildReviewsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextRegular('Reviews', fontWeight: FontManagerWeight.bold),
        8.verticalSpace,
        AppRichText(
          text: '4.5',
          fontSize: 24.fs,
          textSpan: [
            TextSpan(
              text: ' Ratings',
              style: TextStyle(
                fontWeight: FontManagerWeight.extraBold,
                color: AppColors.kBlcak100,
              ),
            ),
          ],
        ),
        16.verticalSpace,
        TextRegular(
          '213 Reviews',
          fontSizes: 14.fs,
          color: AppColors.kBlcak100.withValues(alpha: 0.5),
        ),
      ],
    );
  }

  // Build Description Section
  Widget buildDiscriptionSection() {
    return TextRegular(
      'Built for life and made to last, this full-zip corduroy jacket is part of our Nike Life collection. The spacious fit gives you plenty of room to layer underneath, while the soft corduroy keeps it casual and timeless.',
      color: AppColors.kBlcak100.withValues(alpha: 0.5),
      height: 2,
    );
  }
}
