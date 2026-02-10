import 'package:clot/core/presentation/constants/app_colors.dart';
import 'package:clot/core/presentation/constants/app_svgs.dart';
import 'package:clot/core/presentation/constants/font_manager.dart';
import 'package:clot/core/presentation/ui/extension/app_spacing_extension.dart';
import 'package:clot/core/presentation/ui/widgets/app_back_button.dart';
import 'package:clot/core/presentation/ui/widgets/app_card.dart';
import 'package:clot/core/presentation/ui/widgets/text_styles.dart';
import 'package:clot/features/products/domain/category.dart';
import 'package:clot/features/products/domain/product.dart';
import 'package:clot/features/products/presentation/bloc/product_bloc.dart';
import 'package:clot/features/products/presentation/category_bloc/category_bloc.dart';
import 'package:clot/features/products/presentation/widget/filter_product.dart';
import 'package:clot/features/products/presentation/widget/mixins/deals_btn_sheet_modal.dart';
import 'package:clot/features/products/presentation/widget/mixins/gender_btn_sheet_modal.dart';
import 'package:clot/features/products/presentation/widget/mixins/price_btn_sheet_modal.dart';
import 'package:clot/features/products/presentation/widget/mixins/sort_by_btn_sheet_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CategoryProduct extends StatefulWidget {
  const CategoryProduct({super.key, required this.category});

  final Category category;

  static const String routeName = '/categoryProduct';

  @override
  State<CategoryProduct> createState() => _CategoryProductState();
}

class _CategoryProductState extends State<CategoryProduct>
    with
        SortByBtnSheetModal,
        GenderBtnSheetModal,
        DealsBtnSheetModal,
        PriceBtnSheetModal {
  late final TextEditingController _searchController;
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    final cleanCategoryId = widget.category.id.trim();
    context.read<CategoryBloc>().add(LoadCategoryProducts(cleanCategoryId));
    filters = [
      {
        'text': '2',
        'colors': AppColors.kPrimary,
        'textColor': AppColors.kWhite100,
        'icon': AppSvgs.kFilter,
        'iconColor': AppColors.kWhite100,
        'reverseOrder': true,
      },
      {
        'text': 'On Sale',
        'colors': AppColors.kLightGrey,
        'onTap': () => showDealsModalSheet(context),
      },
      {
        'text': 'Price',
        'colors': AppColors.kPrimary,
        'textColor': AppColors.kWhite100,
        'icon': AppSvgs.kArrowDown,
        'iconColor': AppColors.kWhite100,
        'onTap': () => showPriceModalSheet(context),
      },
      {
        'text': 'Sort  by',
        'colors': AppColors.kLightGrey,
        'icon': AppSvgs.kArrowDown,
        'iconColor': AppColors.kBlcak100,
        'onTap': () => showSortByModalSheet(context),
      },
      {
        'text': 'Men',
        'colors': AppColors.kPrimary,
        'textColor': AppColors.kWhite100,
        'icon': AppSvgs.kArrowDown,
        'iconColor': AppColors.kWhite100,
        'onTap': () => showGenderModalSheet(context),
      },
    ];
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  late final List<Map<String, dynamic>> filters;

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
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search products...',
                  prefixIcon: Padding(
                    padding: const EdgeInsets.only(left: 20, right: 12),
                    child: SvgPicture.asset(
                      AppSvgs.kSearchIcon,
                      height: 16,
                      width: 16,
                    ),
                  ),
                  suffixIcon: GestureDetector(
                    onTap: () {
                      _searchController.clear();
                      if (_isSearching) {
                        setState(() {
                          _isSearching = false;
                        });
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 12, right: 20),
                      child: SvgPicture.asset(
                        AppSvgs.kCloseIcon,
                        height: 16,
                        width: 16,
                      ),
                    ),
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 16),
                  fillColor: AppColors.kLightGrey,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(100),
                    borderSide: BorderSide.none,
                  ),
                ),
                onSubmitted: (query) {
                  if (query.isNotEmpty) {
                    setState(() {
                      _isSearching = true;
                    });
                    context.read<ProductBloc>().add(SearchProducts(query));
                  }
                },
              ),
              24.verticalSpace,
              SizedBox(
                height: MediaQuery.sizeOf(context).width * 0.06,
                child: ListView.separated(
                  itemBuilder: (context, index) {
                    final filter = filters[index];
                    return FilterProduct(
                      title: filter['text'],
                      color: filter['colors'],
                      textColor: filter['textColor'],
                      icon: filter['icon'],
                      iconColor: filter['iconColor'],
                      reverseOrder: filter['reverseOrder'] ?? false,
                      onTap: filter['onTap'] as VoidCallback?,
                    );
                  },
                  separatorBuilder: (_, index) => 16.horizontalSpace,
                  itemCount: filters.length,
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                ),
              ),
              16.verticalSpace,
              Expanded(
                child: _isSearching
                    ? BlocBuilder<ProductBloc, ProductState>(
                        builder: (context, state) {
                          if (state is ProductLoading) {
                            return _buildProductGridSkeleton();
                          }
                          if (state is ProductsLoaded) {
                            if (state.products.isEmpty) {
                              return const Center(
                                child: Text('No products found.'),
                              );
                            }
                            return _buildProductGrid(state.products);
                          }
                          if (state is ProductError) {
                            return Center(child: Text(state.message));
                          }
                          return _buildProductGridSkeleton(); // Initial state
                        },
                      )
                    : BlocBuilder<CategoryBloc, CategoryState>(
                        builder: (context, state) {
                          if (state is CategoryLoading) {
                            return _buildCategorySkeleton();
                          }
                          if (state is CategoryProductsLoaded) {
                            if (state.products.isEmpty) {
                              return Center(
                                child: Text(
                                  'No products in ${widget.category.name}.',
                                ),
                              );
                            }
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextRegular(
                                  '${state.categoryName.toUpperCase()} (${state.products.length})',
                                  fontWeight: FontManagerWeight.bold,
                                ),
                                24.verticalSpace,
                                Expanded(
                                  child: _buildProductGrid(state.products),
                                ),
                              ],
                            );
                          }
                          if (state is CategoryError) {
                            return Center(child: Text(state.message));
                          }
                          return _buildCategorySkeleton(); // Initial state
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProductGrid(List<Product> products) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
    );
  }

  Widget _buildProductGridSkeleton() {
    return Skeletonizer(
      enabled: true,
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 0.7,
        ),
        itemCount: 6,
        itemBuilder: (context, index) {
          return AppCard(
            image: 'https://via.placeholder.com/150',
            icon: AppSvgs.kHeart,
            name: 'Product Name',
            price: '\$00.00',
          );
        },
      ),
    );
  }

  Widget _buildCategorySkeleton() {
    return Skeletonizer(
      enabled: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextRegular(
            '${widget.category.name.toUpperCase()} (0)',
            fontWeight: FontManagerWeight.bold,
          ),
          24.verticalSpace,
          Expanded(child: _buildProductGridSkeleton()),
        ],
      ),
    );
  }
}
