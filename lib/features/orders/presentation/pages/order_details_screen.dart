import 'package:clot/core/presentation/ui/extension/app_spacing_extension.dart';
import 'package:clot/core/presentation/ui/widgets/app_back_button.dart';
import 'package:clot/core/presentation/ui/widgets/text_styles.dart';
import 'package:clot/features/orders/presentation/widgets/order_details_widgets.dart';
import 'package:flutter/material.dart';

class OrderDetailsScreen extends StatelessWidget {
  const OrderDetailsScreen({super.key});

  static const String routeName = '/order-details';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        forceMaterialTransparency: true,
        leading: AppBackButton(),
        centerTitle: true,
        title: const TextRegular('Order #456765'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const OrderStatus(
                  title: 'Delivered',
                  subtitle: '28 May',
                  isFirst: true,
                ),
                const OrderStatus(
                  title: 'Shipped',
                  subtitle: '28 May',
                  isCompleted: true,
                ),
                const OrderStatus(
                  title: 'Order Confirmed',
                  subtitle: '28 May',
                  isCompleted: true,
                ),
                const OrderStatus(
                  title: 'Order Placed',
                  subtitle: '28 May',
                  isCompleted: true,
                  isLast: true,
                ),
                32.verticalSpace,
                const TextRegular('Order Items'),
                16.verticalSpace,
                const OrderItems(),
                32.verticalSpace,
                const ShippingDetails(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
