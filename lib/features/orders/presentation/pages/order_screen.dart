import 'package:clot/core/presentation/constants/app_images.dart';
import 'package:clot/core/presentation/constants/app_svgs.dart';
import 'package:clot/core/presentation/constants/font_manager.dart';
import 'package:clot/core/presentation/ui/extension/app_spacing_extension.dart';
import 'package:clot/core/presentation/ui/widgets/app_button.dart';
import 'package:clot/core/presentation/ui/widgets/text_styles.dart';
import 'package:clot/features/navigation/app_nav_bar.dart';
import 'package:clot/features/orders/presentation/widgets/order_card.dart';
import 'package:clot/features/products/presentation/pages/shop_by_categories.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  static const String routeName = '/order';

  final List<String> orders = const [
    'Order  #456765',
    'Order  #454569',
    'Order  #454809',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const TextRegular('Orders', fontWeight: FontManagerWeight.bold),
        centerTitle: true,
      ),
      bottomNavigationBar: AppNavBar(currentIndex: 2),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: orders.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        AppImages.kCheckOut,
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                      24.verticalSpace,
                      const TextMedium('No Orders yet'),
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
                )
              : ListView.separated(
                  itemCount: orders.length,
                  separatorBuilder: (context, index) => 16.verticalSpace,
                  itemBuilder: (context, index) {
                    return OrderCard(
                      icon: AppSvgs.kReceipt,
                      text: orders[index],
                      onTap: () {},
                    );
                  },
                ),
        ),
      ),
    );
  }
}
