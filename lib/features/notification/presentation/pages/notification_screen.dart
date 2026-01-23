import 'package:clot/core/presentation/constants/app_images.dart';
import 'package:clot/core/presentation/constants/app_svgs.dart';
import 'package:clot/core/presentation/constants/font_manager.dart';
import 'package:clot/core/presentation/ui/extension/app_spacing_extension.dart';
import 'package:clot/core/presentation/ui/widgets/app_button.dart';
import 'package:clot/core/presentation/ui/widgets/text_styles.dart';
import 'package:clot/features/navigation/app_nav_bar.dart';
import 'package:clot/features/notification/presentation/widgets/notification_card.dart';
import 'package:clot/features/products/presentation/pages/shop_by_categories.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  static const String routeName = '/notifications';

  final List<String> notifications = const [
    'Gilbert, you placed and order check your order history for full details',
    'Gilbert, Thank you for shopping with us we have canceled order #24568.',
    'Gilbert, your Order #24568 has been  confirmed check  your order history for full details',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const TextRegular(
          'Notifications',
          fontWeight: FontManagerWeight.bold,
        ),
        centerTitle: true,
      ),
      bottomNavigationBar: AppNavBar(currentIndex: 1),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: notifications.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        AppImages.kBellIcon,
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                      24.verticalSpace,
                      const TextMedium('No Notification yet'),
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
                  itemCount: notifications.length,
                  separatorBuilder: (context, index) => 16.verticalSpace,
                  itemBuilder: (context, index) {
                    return NotificationCard(
                      icon: AppSvgs.kNotification,
                      text: notifications[index],
                      onTap: () {},
                    );
                  },
                ),
        ),
      ),
    );
  }
}
