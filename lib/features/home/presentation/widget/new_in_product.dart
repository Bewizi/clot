import 'package:clot/core/presentation/constants/app_colors.dart';
import 'package:clot/core/presentation/constants/font_manager.dart';
import 'package:clot/core/presentation/ui/extension/app_spacing_extension.dart';
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
                return const Center(
                  child: SizedBox(
                    height: 200,
                    child: Center(child: CircularProgressIndicator()),
                  ),
                );
              }

              if (state.newInProducts.isEmpty) {
                return const SizedBox(
                  height: 200,
                  child: Center(child: Text('No new in products')),
                );
              }

              return SizedBox(
                height: 200,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: state.newInProducts.length,
                  itemBuilder: (context, index) {
                    final product = state.newInProducts[index];
                    return Container(
                      padding: EdgeInsets.symmetric(vertical: 2),
                      margin: EdgeInsets.only(left: 16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: AppColors.kLightGrey,
                      ),
                      width: MediaQuery.sizeOf(context).width * 0.45,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: ClipRRect(
                              child: product.imageUrl.isNotEmpty
                                  ? Center(
                                      child: Image.network(
                                        product.imageUrl,
                                        fit: BoxFit.cover,
                                        width:
                                            MediaQuery.sizeOf(context).width *
                                            0.225,
                                        height:
                                            MediaQuery.sizeOf(context).height *
                                            0.9,
                                        errorBuilder:
                                            (context, error, stackTrace) =>
                                                Container(
                                                  color: AppColors.kBlcak100
                                                      .withValues(alpha: 0.5),
                                                  child: const Icon(
                                                    Icons.image_not_supported,
                                                    size: 48,
                                                  ),
                                                ),
                                      ),
                                    )
                                  : Center(
                                      child: Container(
                                        width: MediaQuery.sizeOf(context).width,
                                        height: MediaQuery.sizeOf(
                                          context,
                                        ).height,
                                        color: AppColors.kBlcak100.withValues(
                                          alpha: 0.5,
                                        ),
                                        child: const Icon(
                                          Icons.image_not_supported,
                                          size: 48,
                                        ),
                                      ),
                                    ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(product.name),
                                Text(product.price),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              );
            }
            if (state is ProductError) {
              return SizedBox(
                height: 200,
                child: Center(child: Text(state.message)),
              );
            }
            // initial loading
            return const SizedBox(
              height: 200,
              child: Center(child: CircularProgressIndicator()),
            );
          },
        ),
      ],
    );
  }
}
