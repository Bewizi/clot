import 'package:clot/core/presentation/constants/app_colors.dart';
import 'package:clot/core/presentation/constants/app_svgs.dart';
import 'package:clot/core/presentation/constants/font_manager.dart';
import 'package:clot/core/presentation/ui/extension/app_spacing_extension.dart';
import 'package:clot/core/presentation/ui/widgets/app_card.dart';
import 'package:clot/core/presentation/ui/widgets/text_styles.dart';
import 'package:clot/features/products/presentation/bloc/product_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
              if (state.isNewInLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (state.newInProducts.isEmpty) {
                return const Center(child: Text('No new in products'));
              }

              return SizedBox(
                height: 200,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: state.newInProducts.length,
                  itemBuilder: (context, index) {
                    final product = state.newInProducts[index];
                    return Padding(
                      padding: const EdgeInsets.only(right: 16),
                      child: AppCard(
                        image: product.imageUrl,
                        icon: AppSvgs.kHeart,
                        name: product.name,
                        price: product.price,
                      ),
                    );
                  },
                ),
              );
            }
            if (state is ProductError) {
              return Center(child: Text(state.message));
            }
            // initial loading
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ],
    );
  }
}
