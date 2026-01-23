import 'package:clot/core/presentation/constants/app_colors.dart';
import 'package:clot/core/presentation/constants/app_svgs.dart';
import 'package:clot/features/home/presentation/pages/home.dart';
import 'package:clot/features/notification/presentation/pages/notification_screen.dart';
import 'package:clot/features/orders/presentation/pages/order_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class AppNavBar extends StatelessWidget {
  const AppNavBar({super.key, required this.currentIndex});

  final int currentIndex;

  void _onDestinationSelected(BuildContext context, int index) {
    switch (index) {
      // home page
      case 0:
        context.go(HomePage.routeName);
        break;
      // notification page
      case 1:
        context.go(NotificationScreen.routeName);
        break;
      // receipt page
      case 2:
        context.go(OrderScreen.routeName);
        break;
      // profile page
      case 3:
        context.go(HomePage.routeName);
        break;
      default:
        context.go(HomePage.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      indicatorColor: Colors.transparent,
      backgroundColor: Colors.transparent,
      onDestinationSelected: (index) => _onDestinationSelected(context, index),
      selectedIndex: currentIndex,
      labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,

      destinations: [
        // home page
        NavigationDestination(
          selectedIcon: SvgPicture.asset(
            AppSvgs.kHome,
            width: 32,
            height: 32,
            colorFilter: ColorFilter.mode(AppColors.kPrimary, BlendMode.srcIn),
          ),
          icon: SvgPicture.asset(
            AppSvgs.kHome,
            width: 32,
            height: 32,
            colorFilter: ColorFilter.mode(
              AppColors.kBlcak100.withValues(alpha: 0.5),
              BlendMode.srcIn,
            ),
          ),
          label: 'Home',
        ),

        // notification page
        NavigationDestination(
          selectedIcon: SvgPicture.asset(
            AppSvgs.kNotification,
            width: 32,
            height: 32,
            colorFilter: ColorFilter.mode(AppColors.kPrimary, BlendMode.srcIn),
          ),
          icon: SvgPicture.asset(AppSvgs.kNotification, width: 32, height: 32),
          label: 'Notification',
        ),

        // receipt page
        NavigationDestination(
          selectedIcon: SvgPicture.asset(
            AppSvgs.kReceipt,
            width: 32,
            height: 32,
            colorFilter: ColorFilter.mode(AppColors.kPrimary, BlendMode.srcIn),
          ),
          icon: SvgPicture.asset(AppSvgs.kReceipt, width: 32, height: 32),
          label: 'Receipt',
        ),

        // profile page
        NavigationDestination(
          selectedIcon: SvgPicture.asset(
            AppSvgs.kProfile,
            width: 32,
            height: 32,
            colorFilter: ColorFilter.mode(AppColors.kPrimary, BlendMode.srcIn),
          ),
          icon: SvgPicture.asset(AppSvgs.kProfile, width: 32, height: 32),
          label: 'Profile',
        ),
      ],
    );
  }
}
