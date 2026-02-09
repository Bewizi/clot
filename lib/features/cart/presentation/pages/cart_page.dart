import 'package:clot/core/presentation/constants/app_colors.dart';
import 'package:clot/core/presentation/constants/app_images.dart';
import 'package:clot/core/presentation/constants/app_svgs.dart';
import 'package:clot/core/presentation/ui/extension/app_spacing_extension.dart';
import 'package:clot/core/presentation/ui/widgets/app_back_button.dart';
import 'package:clot/core/presentation/ui/widgets/app_button.dart';
import 'package:clot/core/presentation/ui/widgets/icon_container.dart';
import 'package:clot/core/presentation/ui/widgets/text_styles.dart';
import 'package:clot/features/cart/presentation/pages/checkout_page.dart';
import 'package:clot/features/cart/presentation/widgets/cart_container.dart';
import 'package:clot/features/cart/presentation/widgets/total_price.dart';
import 'package:clot/features/products/presentation/pages/shop_by_categories.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  static const String routeName = '/add-to-cart';

  final List<Map<String, dynamic>> cartItems = const [
    {
      'productImage': AppImages.kJacket1,
      'productName': 'Men\'s Harrington Jacket',
      'productSize': 'M',
      'productColor': 'Lemon',
      'price': '\$148',
    },
    {
      'productImage': AppImages.kJacket3,
      'productName': 'Men\'s Coaches Jacket',
      'productSize': 'M',
      'productColor': 'Black',
      'price': '\$52.00',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: const [
            AppBackButton(),
            Expanded(child: Center(child: TextRegular('Cart'))),
          ],
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        forceMaterialTransparency: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: cartItems.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        AppImages.kParcel,
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                      24.verticalSpace,
                      const TextMedium('Your Cart is Empty'),
                      24.verticalSpace,
                      SizedBox(
                        width: MediaQuery.sizeOf(context).width * 0.4,
                        child: AppButton(
                          text: 'Explore Categories',
                          onTap: () => context.push(ShopByCategories.routeName),
                        ),
                      ),
                    ],
                  ),
                )
              : SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextRegular('Remove All'),
                      ),
                      16.verticalSpace,
                      ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: cartItems.length,
                        separatorBuilder: (context, index) => 16.verticalSpace,
                        itemBuilder: (context, index) {
                          final item = cartItems[index];
                          return buildCartContainer(
                            item['productImage'] ?? '',
                            item['productName'] ?? '',
                            item['productSize'] ?? '',
                            item['productColor'] ?? '',
                            item['price'] ?? '',
                          );
                        },
                      ),
                      16.verticalSpace,
                      buildReview(),
                      40.verticalSpace,
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
                                SvgPicture.asset(AppSvgs.kDiscountShape),
                                16.horizontalSpace,
                                TextSmall(
                                  'Enter Coupon Code',
                                  color: AppColors.kBlcak100.withValues(
                                    alpha: 0.5,
                                  ),
                                ),
                              ],
                            ),
                            IconContainer(
                              backgroundColor: AppColors.kPrimary,
                              child: SvgPicture.asset(
                                AppSvgs.kArrowRight,
                                colorFilter: ColorFilter.mode(
                                  AppColors.kWhite100,
                                  BlendMode.srcIn,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: GestureDetector(
          onTap: () => context.push(CheckoutPage.routeName),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
            decoration: BoxDecoration(
              color: AppColors.kPrimary,
              borderRadius: BorderRadius.circular(100),
            ),
            child: TextRegular(
              'Checkout',
              color: AppColors.kWhite100,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
