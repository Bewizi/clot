import 'package:clot/core/presentation/constants/app_colors.dart';
import 'package:clot/core/presentation/constants/app_images.dart';
import 'package:clot/core/presentation/constants/app_svgs.dart';
import 'package:clot/core/presentation/constants/font_manager.dart';
import 'package:clot/core/presentation/constants/icon_size_manager.dart';
import 'package:clot/core/presentation/ui/extension/app_spacing_extension.dart';
import 'package:clot/core/presentation/ui/widgets/icon_container.dart';
import 'package:clot/core/presentation/ui/widgets/text_styles.dart';
import 'package:clot/features/cart/presentation/pages/cart_page.dart';
import 'package:clot/features/home/presentation/widget/new_in_product.dart';
import 'package:clot/features/home/presentation/widget/top_selling.dart';
import 'package:clot/features/navigation/app_nav_bar.dart';
import 'package:clot/features/products/presentation/bloc/product_bloc.dart';
import 'package:clot/features/products/presentation/pages/shop_by_categories.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  static const String routeName = '/home';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    // Load all home data once
    context.read<ProductBloc>().add(LoadCategories());
    context.read<ProductBloc>().add(LoadTopSellingProducts());
    context.read<ProductBloc>().add(LoadNewInProducts());
  }

  final List<String> list = ['Men', 'Women'];
  String dropDownValue = 'Men';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: AppNavBar(currentIndex: 0),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // user image
                  Container(
                    width: 50,
                    height: 50,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.kBlcak100,
                    ),
                    clipBehavior: Clip.hardEdge,
                    child: Image.asset(
                      AppImages.kEllipse15,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Center(
                          child: Icon(
                            FontAwesomeIcons.user,
                            size: 24,
                            color: AppColors.kWhite100,
                          ),
                        );
                      },
                    ),
                  ),

                  16.horizontalSpace,

                  // dropDownMenu
                  Expanded(
                    child: Center(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 12,
                        ),
                        height: ValueManager.iconContainerSize,
                        decoration: BoxDecoration(
                          color: AppColors.kLightGrey,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                            value: dropDownValue,
                            icon: SvgPicture.asset(
                              AppSvgs.kArrowDown,
                              width: 16,
                              height: 16,
                              fit: BoxFit.cover,
                            ),
                            items: list.map((e) {
                              return DropdownMenuItem<String>(
                                value: e,
                                child: TextSmall(e),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                dropDownValue = value!;
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                  ),

                  // cart
                  IconContainer(
                    onTap: () => context.push(CartPage.routeName),
                    backgroundColor: AppColors.kPrimary,
                    child: SvgPicture.asset(
                      AppSvgs.kCart,
                      width: 16,
                      height: 16,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),

              24.verticalSpace,

              // Categories section (not scrollable with the rest of the content)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextRegular('Categories', fontWeight: FontManagerWeight.bold),
                  InkWell(
                    onTap: () => context.push(ShopByCategories.routeName),
                    child: TextRegular('See All', color: AppColors.kBlcak100),
                  ),
                ],
              ),
              24.verticalSpace,
              BlocBuilder<ProductBloc, ProductState>(
                builder: (context, state) {
                  if (state is ProductError) {
                    return Center(child: Text(state.message));
                  }

                  if (state is HomeDataLoaded) {
                    if (state.categories.isEmpty && !state.isCategoryLoading) {
                      return const Center(child: Text('No categories'));
                    }

                    final isLoading = state.isCategoryLoading;
                    final categoriesToSHow = state.categories.isEmpty
                        ? List.generate(5, (index) => null)
                        : state.categories;

                    return Skeletonizer(
                      enabled: isLoading,
                      child: SizedBox(
                        height: 150,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            final data = state.categories.isEmpty
                                ? null
                                : state.categories[index];
                            return Column(
                              crossAxisAlignment: .center,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 14),
                                    child: Image.network(
                                      data?.imageUrl ??
                                          'https://via.placeholder.com/80',
                                      width: 80,
                                      height: 80,
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (context, error, stackTrace) =>
                                              const Icon(
                                                FontAwesomeIcons.images,
                                                size: 16,
                                              ),
                                    ),
                                  ),
                                ),
                                8.verticalSpace,
                                TextSmall(
                                  data?.name ?? 'Category',
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            );
                          },
                          itemCount: categoriesToSHow.length,
                        ),
                      ),
                    );
                  }

                  return Skeletonizer(
                    enabled: true,
                    child: SizedBox(
                      height: 150,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 14),
                                  child: Container(
                                    width: 80,
                                    height: 80,
                                    color: AppColors.kLightGrey,
                                  ),
                                ),
                              ),
                              8.verticalSpace,
                              const TextSmall(
                                'Category',
                                textAlign: TextAlign.center,
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  );
                },
              ),

              24.verticalSpace,

              // Scrollable content
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const TopSelling(),
                      24.verticalSpace,
                      const NewInProduct(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
