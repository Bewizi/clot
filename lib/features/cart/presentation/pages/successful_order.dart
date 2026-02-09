import 'package:clot/core/presentation/constants/app_colors.dart';
import 'package:clot/core/presentation/constants/app_images.dart';
import 'package:clot/core/presentation/constants/font_manager.dart';
import 'package:clot/core/presentation/ui/extension/app_spacing_extension.dart';
import 'package:clot/core/presentation/ui/widgets/app_button.dart';
import 'package:clot/core/presentation/ui/widgets/text_styles.dart';
import 'package:clot/features/orders/presentation/pages/order_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SuccessfulOrder extends StatelessWidget {
  const SuccessfulOrder({super.key});

  static const String routeName = '/successful_order';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kPrimary,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Center(
          child: ClipRRect(
            child: Image.asset(AppImages.kCartSuccess, width: 300),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 40),
        height: MediaQuery.sizeOf(context).height * 0.45,
        decoration: BoxDecoration(
          color: AppColors.kWhite100,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              AppRichText(
                text: 'Order Placed\n Successfully',
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: AppColors.kBlcak100,
                textAlign: TextAlign.center,
                textSpan: [
                  TextSpan(
                    text: '\n 8E6CEF',
                    style: TextStyle(
                      fontSize: 24,
                      color: AppColors.kBlcak100,
                      fontWeight: FontManagerWeight.bold,
                    ),
                  ),
                ],
              ),
              24.verticalSpace,
              TextRegular(
                'You will receive an email confirmation',
                color: AppColors.kBlcak100.withValues(alpha: 0.5),
              ),
              64.verticalSpace,
              AppButton(
                text: 'See Order details',
                onTap: () => context.push(OrderDetailsScreen.routeName),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
