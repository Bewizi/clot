import 'package:clot/core/presentation/constants/app_svgs.dart';
import 'package:clot/core/presentation/constants/font_manager.dart';
import 'package:clot/core/presentation/ui/extension/app_spacing_extension.dart';
import 'package:clot/core/presentation/ui/widgets/app_back_button.dart';
import 'package:clot/core/presentation/ui/widgets/app_button.dart';
import 'package:clot/core/presentation/ui/widgets/app_card.dart';
import 'package:clot/core/presentation/ui/widgets/text_styles.dart';
import 'package:clot/features/products/domain/category.dart';
import 'package:clot/features/products/presentation/category_bloc/category_bloc.dart';
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
    final cleanCategoryId = widget.category.id.trim();
    context.read<CategoryBloc>().add(LoadCategoryProducts(cleanCategoryId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        forceMaterialTransparency: true,
        title: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: AppBackButton(),
        ),
      ),
      body: BlocBuilder<CategoryBloc, CategoryState>(
        builder: (context, state) {
          if (state is CategoryLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is CategoryProductsLoaded) {
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
                      'No ${state.categoryName.toLowerCase()} available',
                      color: Colors.grey,
                    ),
                  ],
                ),
              );
            }

            return SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextRegular(
                      '${state.categoryName.toUpperCase()} (${products.length})',
                      fontWeight: FontManagerWeight.bold,
                    ),
                    24.verticalSpace,
                    Expanded(
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 16,
                              mainAxisSpacing: 16,
                              childAspectRatio: 0.7,
                            ),
                        itemCount: products.length,
                        itemBuilder: (context, index) {
                          final product = products[index];

                          return AppCard(
                            image: product.imageUrl,
                            icon: AppSvgs.kHeart,
                            name: product.name,
                            price: product.price,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          if (state is CategoryError) {
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
                      context.read<CategoryBloc>().add(
                        LoadCategoryProducts(widget.category.id.trim()),
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

//
// Card(
// shape: RoundedRectangleBorder(
// borderRadius: BorderRadius.circular(8),
// ),
// surfaceTintColor: Colors.transparent,
// shadowColor: Colors.transparent,
// child: Column(
// crossAxisAlignment: CrossAxisAlignment.start,
// children: [
// Expanded(
// child: Stack(
// children: [
// ClipRRect(
// borderRadius: BorderRadius.vertical(
// top: Radius.circular(12),
// ),
// child: product.imageUrl.isNotEmpty
// ? Center(
// child: Image.network(
// product.imageUrl,
// fit: BoxFit.cover,
// errorBuilder:
// (
// context,
// error,
// stackTrace,
// ) => Container(
// color: AppColors
//     .kBlcak100
//     .withValues(
// alpha: 0.5,
// ),
// child: const Icon(
// Icons
//     .image_not_supported,
// size: 48,
// ),
// ),
// ),
// )
//     : Center(
// child: Container(
// width: MediaQuery.sizeOf(
// context,
// ).width,
// height: MediaQuery.sizeOf(
// context,
// ).height,
// color: AppColors.kBlcak100
//     .withValues(alpha: 0.5),
// child: const Icon(
// Icons.image_not_supported,
// size: 48,
// ),
// ),
// ),
// ),
// Positioned(
// top: 9,
// right: 9,
// child: SvgPicture.asset(
// AppSvgs.kHeart,
// width: 24,
// height: 24,
// ),
// ),
// ],
// ),
// ),
// Padding(
// padding: const EdgeInsets.symmetric(
// horizontal: 8,
// vertical: 16,
// ),
// child: Column(
// crossAxisAlignment:
// CrossAxisAlignment.start,
// children: [
// TextRegular(
// fontSizes: 14.fs,
// product.name,
// color: AppColors.kBlcak100,
// ),
// 8.verticalSpace,
// TextSmall(
// product.price,
// color: AppColors.kBlcak100,
// fontWeight: FontManagerWeight.bold,
// ),
// ],
// ),
// ),
// ],
// ),
// );
