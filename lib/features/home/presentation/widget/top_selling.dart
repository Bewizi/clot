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
import 'package:skeletonizer/skeletonizer.dart';

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
              if (state.topSellingProducts.isEmpty &&
                  !state.isTopSellingLoading) {
                return const SizedBox(
                  height: 200,
                  child: Center(child: Text('No top selling products')),
                );
              }

              final isLoading = state.isTopSellingLoading;
              final productToShow = state.topSellingProducts.isEmpty
                  ? List.generate(3, (index) => null)
                  : state.topSellingProducts;

              return Skeletonizer(
                enabled: isLoading,
                child: SizedBox(
                  height: 200,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: productToShow.length,
                    itemBuilder: (context, index) {
                      final product = state.topSellingProducts.isEmpty
                          ? null
                          : state.topSellingProducts[index];
                      return Padding(
                        padding: const EdgeInsets.only(right: 16),
                        child: AppCard(
                          image:
                              product?.imageUrl ??
                              'https://via.placeholder.com/150',
                          icon: AppSvgs.kHeart,
                          name: product?.name ?? 'Product Name',
                          price: product?.price ?? '\$00.00',
                          onTap: product != null
                              ? () => context.push(ProductsScreen.routeName)
                              : null,
                        ),
                      );
                    },
                  ),
                ),
              );
            }
            if (state is ProductError) {
              return Center(child: TextMedium(state.message));
            }
            // initial loading
            return Skeletonizer(
              enabled: true,
              child: SizedBox(
                height: 200,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 16),
                      child: AppCard(
                        image: 'https://via.placeholder.com/150',
                        icon: AppSvgs.kHeart,
                        name: 'Product Name',
                        price: '\$00.00',
                      ),
                    );
                  },
                  itemCount: 3,
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
