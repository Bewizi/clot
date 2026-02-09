import 'package:clot/core/presentation/constants/app_colors.dart';
import 'package:clot/core/presentation/ui/extension/app_spacing_extension.dart';
import 'package:clot/core/presentation/ui/widgets/app_back_button.dart';
import 'package:clot/core/presentation/ui/widgets/text_styles.dart';
import 'package:clot/features/products/presentation/category_bloc/category_bloc.dart';
import 'package:clot/features/products/presentation/pages/category_product.dart';
import 'package:clot/features/products/presentation/widget/category_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ShopByCategories extends StatefulWidget {
  const ShopByCategories({super.key});

  static const String routeName = '/shopByCategories';

  @override
  State<ShopByCategories> createState() => _ShopByCategoriesState();
}

class _ShopByCategoriesState extends State<ShopByCategories> {
  @override
  void initState() {
    super.initState();
    context.read<CategoryBloc>().add(LoadAllCategoriesForBrowsing());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        forceMaterialTransparency: true,
        title: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: AppBackButton(),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextMedium('Shop by Categories', color: AppColors.kBlcak100),
              16.verticalSpace,
              BlocBuilder<CategoryBloc, CategoryState>(
                builder: (context, state) {
                  if (state is CategoryLoading) {
                    return const Expanded(
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }

                  if (state is CategoryError) {
                    return Expanded(child: Center(child: Text(state.message)));
                  }

                  if (state is CategoriesListLoaded) {
                    return Expanded(
                      child: ListView.builder(
                        itemCount: state.categories.length,
                        itemBuilder: (context, index) {
                          final category = state.categories[index];
                          return CategoryCard(
                            name: category.name,
                            imageUrl: category.imageUrl,
                            onTap: () {
                              context.push(
                                CategoryProduct.routeName,
                                extra: category,
                              );
                            },
                          );
                        },
                      ),
                    );
                  }

                  return const Expanded(
                    child: Center(child: Text('No categories')),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
