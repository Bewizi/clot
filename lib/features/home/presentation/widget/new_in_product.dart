import 'package:clot/core/presentation/constants/app_colors.dart';
import 'package:clot/core/presentation/constants/app_svgs.dart';
import 'package:clot/core/presentation/constants/font_manager.dart';
import 'package:clot/core/presentation/ui/extension/app_spacing_extension.dart';
import 'package:clot/core/presentation/ui/widgets/app_card.dart';
import 'package:clot/core/presentation/ui/widgets/text_styles.dart';
import 'package:clot/features/products/presentation/bloc/product_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';

class NewInProduct extends StatelessWidget {
  const NewInProduct({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const TextRegular(
              'New In',
              fontWeight: FontManagerWeight.bold,
              color: AppColors.kPrimary,
            ),
            const Spacer(),
            InkWell(onTap: () {}, child: const TextRegular('See All')),
          ],
        ),
        24.verticalSpace,
        BlocBuilder<ProductBloc, ProductState>(
          builder: (context, state) {
            if (state is HomeDataLoaded) {
              if (state.newInProducts.isEmpty && !state.isNewInLoading) {
                return const Center(child: Text('No new in products'));
              }

              final isLoading = state.isNewInLoading;
              final productToShow = state.newInProducts.isEmpty
                  ? List.generate(3, (index) => null)
                  : state.newInProducts;

              return Skeletonizer(
                enabled: isLoading,
                child: SizedBox(
                  height: 200,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: productToShow.length,
                    itemBuilder: (context, index) {
                      final product = state.newInProducts.isEmpty
                          ? null
                          : state.newInProducts[index];
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
                              ? () => context.pushNamed('products')
                              : null,
                        ),
                      );
                    },
                  ),
                ),
              );
            }
            if (state is ProductError) {
              return Center(child: Text(state.message));
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
