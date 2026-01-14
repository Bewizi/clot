import 'package:clot/core/presentation/constants/app_colors.dart';
import 'package:clot/core/presentation/ui/extension/app_spacing_extension.dart';
import 'package:clot/core/presentation/ui/widgets/app_button.dart';
import 'package:clot/core/presentation/ui/widgets/text_styles.dart';
import 'package:clot/features/products/domain/category.dart';
import 'package:clot/features/products/presentation/bloc/product_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryProduct extends StatefulWidget {
  const CategoryProduct({super.key, required this.category});

  final Category category;

  static const String routeName = '/categoryProduct';

  @override
  State<CategoryProduct> createState() => _CategoryProductState();
}

class _CategoryProductState extends State<CategoryProduct> {
  @override
  void initState() {
    super.initState();
    context.read<ProductBloc>().add(
      LoadProductsByCategory(widget.category.id.trim()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.category.name), centerTitle: true),
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          if (state is ProductLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is ProductsLoaded) {
            final products = state.products;

            if (products.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.inventory_2_outlined,
                      size: 64,
                      color: Colors.grey,
                    ),
                    const SizedBox(height: 16),
                    TextMedium(
                      'No ${widget.category.name.toLowerCase()} available',
                      color: Colors.grey,
                    ),
                  ],
                ),
              );
            }

            return SafeArea(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 0.7,
                  ),
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final product = products[index];
                    return Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(12),
                              ),
                              child: product.imageUrl.isNotEmpty
                                  ? Image.network(
                                      product.imageUrl,
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                      errorBuilder:
                                          (context, error, stackTrace) =>
                                              Container(
                                                color: Colors.grey[300],
                                                child: const Icon(
                                                  Icons.image_not_supported,
                                                  size: 48,
                                                ),
                                              ),
                                    )
                                  : Container(
                                      color: Colors.grey[300],
                                      child: const Icon(
                                        Icons.image_not_supported,
                                        size: 48,
                                      ),
                                    ),
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextMedium(
                                  product.name,
                                  color: AppColors.kBlcak100,
                                ),
                                8.verticalSpace,
                                TextSmall(
                                  product.price,
                                  color: AppColors.kPrimary,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            );
          }

          if (state is ProductError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error, size: 48, color: Colors.red),
                  const SizedBox(height: 16),
                  Text(state.message),
                  const SizedBox(height: 16),
                  AppButton(
                    onTap: () {
                      context.read<ProductBloc>().add(
                        LoadProductsByCategory(widget.category.id.trim()),
                      );
                    },
                    'Retry',
                  ),
                ],
              ),
            );
          }
          return const Center(child: Text('No data'));
        },
      ),
    );
  }
}
