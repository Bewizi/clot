import 'package:clot/core/presentation/constants/app_colors.dart';
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

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  static const String routeName = '/order';

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  final List<Map<String, dynamic>> orders = const [
    {'orderId': 'Order  #456765', 'orderItems': '4  items'},
    {'orderId': 'Order  #454569', 'orderItems': '2  items'},
    {'orderId': 'Order  #454809', 'orderItems': '1 items'},
  ];

  final List<String> orderType = const [
    'Processing',
    'Shipped',
    'Delivered',
    'Returned',
    'Cancelled',
  ];

  String _selectedOrderType = 'Processing';

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
              : Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.sizeOf(context).width * 0.06,
                      child: ListView.separated(
                        itemBuilder: (context, index) {
                          final type = orderType[index];
                          return _buildOrderTyp(
                            context,
                            type,
                            _selectedOrderType == type,
                            () {
                              setState(() {
                                _selectedOrderType = type;
                              });
                            },
                          );
                        },
                        separatorBuilder: (context, index) =>
                            16.horizontalSpace,
                        scrollDirection: Axis.horizontal,
                        itemCount: orderType.length,
                      ),
                    ),
                    24.verticalSpace,
                    Expanded(
                      child: ListView.separated(
                        itemCount: orders.length,
                        separatorBuilder: (context, index) => 16.verticalSpace,
                        itemBuilder: (context, index) {
                          final order = orders[index];
                          return OrderCard(
                            icon: AppSvgs.kReceipt,
                            text: order['orderId'],
                            item: order['orderItems'],
                            onTap: () {},
                          );
                        },
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}

Widget _buildOrderTyp(
  BuildContext context,
  String orderType,
  bool isSelected,
  VoidCallback onTap,
) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: isSelected ? AppColors.kPrimary : AppColors.kLightGrey,
      ),
      child: Center(
        child: TextSmall(
          orderType,
          color: isSelected ? AppColors.kWhite100 : AppColors.kBlcak100,
        ),
      ),
    ),
  );
}
