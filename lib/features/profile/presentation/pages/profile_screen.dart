import 'package:clot/core/presentation/constants/app_colors.dart';
import 'package:clot/core/presentation/constants/app_images.dart';
import 'package:clot/core/presentation/constants/app_svgs.dart';
import 'package:clot/core/presentation/ui/extension/app_spacing_extension.dart';
import 'package:clot/core/presentation/ui/widgets/app_button.dart';
import 'package:clot/core/presentation/ui/widgets/text_styles.dart';
import 'package:clot/features/navigation/app_nav_bar.dart';
import 'package:clot/features/profile/presentation/widgets/profile_settings.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  static const String routeName = '/profile';

  @override
  Widget build(BuildContext context) {
    // To properly handle a missing image, you can define a variable
    // for your image asset and set it to null to test the fallback.
    // const String? profileImageAsset = AppImages.kEllipse15;
    const String? profileImageAsset = null;

    final List<Map<String, dynamic>> profileSettings = const [
      {'text': 'Address', 'icon': AppSvgs.kArrowRight},
      {'text': 'Wishlist', 'icon': AppSvgs.kArrowRight},
      {'text': 'Payment', 'icon': AppSvgs.kArrowRight},
      {'text': 'Help', 'icon': AppSvgs.kArrowRight},
      {'text': 'Support', 'icon': AppSvgs.kArrowRight},
    ];

    return Scaffold(
      bottomNavigationBar: AppNavBar(currentIndex: 3),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            children: [
              //   profile image,
              Center(
                child: CircleAvatar(
                  maxRadius: 50,
                  backgroundImage: profileImageAsset == null
                      ? AssetImage(AppImages.kEllipse15)
                      : null,
                  child: profileImageAsset != null
                      ? const Icon(FontAwesomeIcons.user, size: 48)
                      : null,
                ),
              ),
              32.verticalSpace,

              //user address, name and phone name (container),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.kLightGrey,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const TextRegular('Gilbert Jones'),
                        8.verticalSpace,
                        TextRegular(
                          'Glbertjones001@gmail.com',
                          color: AppColors.kBlcak100.withValues(alpha: 0.5),
                        ),
                        8.verticalSpace,
                        TextRegular(
                          '121-224-7890',
                          color: AppColors.kBlcak100.withValues(alpha: 0.5),
                        ),
                      ],
                    ),
                    const TextSmall('Edit', color: AppColors.kPrimary),
                  ],
                ),
              ),
              24.verticalSpace,

              //   reusable widget for address, wishlist, payment and so on. (8 spacing) list view
              Expanded(
                child: ListView.separated(
                  itemBuilder: (context, index) {
                    final data = profileSettings[index];
                    return buildProfileSettings(data['text'], data['icon']);
                  },
                  separatorBuilder: (context, index) => 8.verticalSpace,

                  itemCount: profileSettings.length,
                ),
              ),

              32.verticalSpace,

              // sign out button
              AppButton(
                'Sign Out',
                onTap: () {},
                color: Colors.transparent,
                textColor: AppColors.kError500,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
