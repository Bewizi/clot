import 'package:clot/core/presentation/constants/app_colors.dart';
import 'package:clot/core/presentation/constants/app_images.dart';
import 'package:clot/core/presentation/ui/extension/app_spacing_extension.dart';
import 'package:clot/core/presentation/ui/widgets/app_button.dart';
import 'package:clot/core/presentation/ui/widgets/text_styles.dart';
import 'package:clot/features/auth/presentation/pages/sign_in/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ResetPassword extends StatelessWidget {
  const ResetPassword({super.key});

  static const String routeName = '/resetPassword';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Center(
            child: Column(
              crossAxisAlignment: .center,
              mainAxisAlignment: .center,
              children: [
                // icons
                Image.asset(
                  AppImages.emailBox,
                  fit: BoxFit.cover,
                  width: 100,
                  height: 100,
                ),

                24.verticalSpace,

                const TextMedium(
                  'We Sent you an Email to reset\n your password.',
                  color: AppColors.kBlcak100,
                  textAlign: TextAlign.center,
                ),

                24.verticalSpace,

                AppButton(
                  'Return to Login',
                  onTap: () {
                    context.go(SignIn.routeName);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
