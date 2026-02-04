import 'package:clot/core/presentation/constants/app_colors.dart';
import 'package:clot/core/presentation/constants/app_svgs.dart';
import 'package:clot/core/presentation/constants/font_manager.dart';
import 'package:clot/core/presentation/ui/widgets/app_back_button.dart';
import 'package:clot/core/presentation/ui/widgets/text_styles.dart';
import 'package:clot/features/cart/presentation/pages/successful_order.dart';
import 'package:clot/features/cart/presentation/widgets/checkoout_card_container.dart';
import 'package:clot/features/cart/presentation/widgets/total_price.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CheckoutPage extends StatelessWidget {
  const CheckoutPage({super.key});

  static const String routeName = '/checkout-product';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: const [
            AppBackButton(),
            Expanded(child: Center(child: TextRegular('Checkout'))),
          ],
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        forceMaterialTransparency: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildCheckOutCardContainer(
                      'Shipping Address',
                      'Add Shipping Address',
                      AppSvgs.kArrowRight,
                    ),
                    buildCheckOutCardContainer(
                      'Payment Method',
                      'Add Payment Method',
                      AppSvgs.kArrowRight,
                    ),
                  ],
                ),
              ),

              Expanded(child: buildReview()),
            ],
          ),
        ),
      ),

      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: GestureDetector(
          onTap: () => context.go(SuccessfulOrder.routeName),
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
                  '\$208',
                  color: AppColors.kWhite100,
                  fontWeight: FontManagerWeight.bold,
                ),
                TextRegular('Place Order', color: AppColors.kWhite100),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
