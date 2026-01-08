import 'package:clot/core/presentation/constants/app_colors.dart';
import 'package:clot/core/presentation/ui/extension/app_spacing_extension.dart';
import 'package:clot/core/presentation/ui/widgets/app_button.dart';
import 'package:clot/core/presentation/ui/widgets/text_styles.dart';
import 'package:clot/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:clot/features/home/presentation/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class TellUsAboutYourself extends StatefulWidget {
  const TellUsAboutYourself({super.key});

  static const String routeName = '/tellUsAboutYourself';

  @override
  State<TellUsAboutYourself> createState() => _TellUsAboutYourselfState();
}

class _TellUsAboutYourselfState extends State<TellUsAboutYourself> {
  String? selectedGender;
  int selectedAge = 18;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is Authenticated && state.user.isProfileComplete == true) {
          context.go(HomePage.routeName);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Profile completed successfully!')),
          );
        } else if (state is AuthError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      builder: (context, state) {
        final isLoading = state is AuthLoading;

        final currentUser = state is Authenticated ? state.user : null;

        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextMedium(
                    'Tell us About yourself',
                    color: AppColors.kBlcak100,
                  ),
                  48.verticalSpace,
                  TextRegular(
                    'Who do you shop for ?',
                    color: AppColors.kBlcak100,
                  ),
                  24.verticalSpace,
                  Row(
                    children: [
                      Expanded(
                        child: _buildGenderOption('Men', 'male', context),
                      ),
                      16.horizontalSpace,
                      Expanded(
                        child: _buildGenderOption('Women', 'female', context),
                      ),
                    ],
                  ),
                  56.verticalSpace,
                  TextRegular('How Old are you ?', color: AppColors.kBlcak100),
                  24.verticalSpace,
                  _buildAgeSelector(),

                  const Spacer(),

                  AppButton(
                    'Finish',
                    onTap: isLoading || selectedGender == null
                        ? null
                        : () {
                            if (currentUser != null) {
                              context.read<AuthBloc>().add(
                                UpdateUserProfileRequested(
                                  userId: currentUser.id,
                                  gender: selectedGender,
                                  age: selectedAge,
                                ),
                              );
                            }
                          },
                    child: isLoading
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.white,
                              ),
                            ),
                          )
                        : null,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildGenderOption(String label, String value, BuildContext context) {
    final isSelected = selectedGender == value;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedGender = value;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.kPrimary : AppColors.kLightGrey,
          borderRadius: BorderRadius.circular(100),
          border: Border.all(
            color: isSelected ? AppColors.kPrimary : Colors.transparent,
            width: 2,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextRegular(
              label,
              color: isSelected ? Colors.white : AppColors.kBlcak100,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAgeSelector() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      decoration: BoxDecoration(
        color: AppColors.kLightGrey,
        borderRadius: BorderRadius.circular(100),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextMedium('Age', color: AppColors.kBlcak100),
          Row(
            children: [
              IconButton(
                onPressed: () {
                  if (selectedAge > 13) {
                    setState(() {
                      selectedAge--;
                    });
                  }
                },
                icon: const Icon(Icons.remove_circle_outline),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: TextMedium('$selectedAge', color: AppColors.kBlcak100),
              ),
              IconButton(
                onPressed: () {
                  if (selectedAge < 100) {
                    setState(() {
                      selectedAge++;
                    });
                  }
                },
                icon: const Icon(Icons.add_circle_outline),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
