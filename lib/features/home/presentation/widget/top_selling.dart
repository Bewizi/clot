import 'package:clot/core/presentation/constants/app_svgs.dart';
import 'package:clot/core/presentation/constants/font_manager.dart';
import 'package:clot/core/presentation/ui/extension/app_spacing_extension.dart';
import 'package:clot/core/presentation/ui/widgets/app_card.dart';
import 'package:clot/core/presentation/ui/widgets/text_styles.dart';
import 'package:clot/features/products/presentation/bloc/product_bloc.dart';
import 'package:clot/features/products/presentation/pages/products_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class TopSelling extends StatelessWidget {
  const TopSelling({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const TextRegular(
              'Top Selling',
              fontWeight: FontManagerWeight.bold,
            ),
            const Spacer(),
            InkWell(onTap: () {}, child: const TextRegular('See All')),
          ],
        ),
        24.verticalSpace,
        BlocBuilder<ProductBloc, ProductState>(
          builder: (context, state) {
            if (state is HomeDataLoaded) {
              if (state.isTopSellingLoading) {
                return const Center(
                  child: SizedBox(
                    height: 200,
                    child: Center(child: CircularProgressIndicator()),
                  ),
                );
              }

              if (state.topSellingProducts.isEmpty) {
                return const SizedBox(
                  height: 200,
                  child: Center(child: Text('No top selling products')),
                );
              }

              return SizedBox(
                height: 200,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: state.topSellingProducts.length,
                  itemBuilder: (context, index) {
                    final product = state.topSellingProducts[index];
                    return Padding(
                      padding: const EdgeInsets.only(right: 16),
                      child: AppCard(
                        image: product.imageUrl,
                        icon: AppSvgs.kHeart,
                        name: product.name,
                        price: product.price,
                        onTap: () => context.push(ProductsScreen.routeName),
                      ),
                    );
                  },
                ),
              );
            }
            if (state is ProductError) {
              return Center(child: TextMedium(state.message));
            }
            // initial loading
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ],
    );
  }
}
