import 'package:clot/core/presentation/constants/app_colors.dart';
import 'package:clot/core/presentation/ui/extension/app_spacing_extension.dart';
import 'package:clot/core/presentation/ui/widgets/app_button.dart';
import 'package:clot/core/presentation/ui/widgets/text_styles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static const String routeName = '/home';

  // sign out

  Future<void> _signOut(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      // Show success message
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Signed out successfully')),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error signing out: $e')));
      }
    }
  }

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
                Text(
                  'Home Page',
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                ),

                40.verticalSpace,

                _buildSignInOptions(context, () {}),

                40.verticalSpace,

                AppButton(
                  'Sign Out',
                  onTap: () {
                    _signOut(context);
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

Widget _buildSignInOptions(BuildContext context, VoidCallback? onTap) {
  return Column(
    crossAxisAlignment: .start,
    children: [
      GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.kLightGrey,
            borderRadius: BorderRadius.circular(100),
          ),
          child: Row(
            children: [
              Icon(Icons.facebook, color: AppColors.kBlcak100),
              SizedBox(width: 10),
              Expanded(
                child: Center(
                  child: TextRegular(
                    'Continue With Apple',
                    color: AppColors.kBlcak100,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ],
  );
}
