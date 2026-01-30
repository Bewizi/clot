import 'package:clot/core/presentation/constants/app_images.dart';
import 'package:clot/core/presentation/ui/extension/app_spacing_extension.dart';
import 'package:clot/core/presentation/ui/widgets/app_back_button.dart';
import 'package:clot/core/presentation/ui/widgets/app_button.dart';
import 'package:clot/core/presentation/ui/widgets/text_styles.dart';
import 'package:clot/features/products/presentation/pages/shop_by_categories.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  static const String routeName = '/add-to-cart';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(children: const [AppBackButton()]),
        automaticallyImplyLeading: false,
        forceMaterialTransparency: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Center(
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
                    'Explore Categories',
                    onTap: () => context.push(ShopByCategories.routeName),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
