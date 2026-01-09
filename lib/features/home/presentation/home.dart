import 'package:clot/core/presentation/constants/app_colors.dart';
import 'package:clot/core/presentation/constants/app_svgs.dart';
import 'package:clot/core/presentation/constants/font_manager.dart';
import 'package:clot/core/presentation/constants/icon_size_manager.dart';
import 'package:clot/core/presentation/ui/extension/app_spacing_extension.dart';
import 'package:clot/core/presentation/ui/widgets/icon_container.dart';
import 'package:clot/core/presentation/ui/widgets/text_styles.dart';
import 'package:clot/features/products/presentation/bloc/product_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  static const String routeName = '/home';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // sign out

  // Future<void> _signOut(BuildContext context) async {
  //   try {
  //     await FirebaseAuth.instance.signOut();
  //     // Show success message
  //     if (context.mounted) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         const SnackBar(content: Text('Signed out successfully')),
  //       );
  //     }
  //   } catch (e) {
  //     if (context.mounted) {
  //       ScaffoldMessenger.of(
  //         context,
  //       ).showSnackBar(SnackBar(content: Text('Error signing out: $e')));
  //     }
  //   }
  // }

  @override
  void initState() {
    super.initState();
    context.read<ProductBloc>().add(LoadCategories());
  }

  final List<String> list = ['Men', 'Women'];

  String dropDonwValue = 'Men';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Center(
            child: Column(
              crossAxisAlignment: .start,

              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // user image rounded inside of clipprect
                    ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image.asset(
                        'assets/images/user.png',
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Icon(
                            Icons.person,
                            size: 50,
                            color: AppColors.kBlcak100,
                          );
                        },
                      ),
                    ),

                    16.horizontalSpace,

                    // droppdownmeanu
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
                              value: dropDonwValue,
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
                                  dropDonwValue = value!;
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                    ),

                    // cart
                    IconContainer(
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextRegular(
                          'Categories',
                          fontWeight: FontManagerWeight.bold,
                        ),
                        TextRegular('See All', color: AppColors.kBlcak100),
                      ],
                    ),
                    24.verticalSpace,
                    BlocBuilder<ProductBloc, ProductState>(
                      builder: (context, state) {
                        if (state is CategoryLoading) {
                          return Center(
                            child: const CircularProgressIndicator(),
                          );
                        }

                        if (state is CategoriesLoaded) {
                          return SizedBox(
                            height: 200,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                final data = state.categories[index];
                                return Column(
                                  crossAxisAlignment: .center,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                          left: 14,
                                        ),
                                        child: Image.network(
                                          data.imageUrl,
                                          width: 80,
                                          height: 80,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    8.verticalSpace,
                                    TextSmall(
                                      data.name,
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                );
                              },

                              itemCount: state.categories.length,
                            ),
                          );
                        } else {
                          return const SizedBox.shrink();
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
