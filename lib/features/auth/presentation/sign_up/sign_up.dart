import 'package:clot/core/presentation/constants/app_colors.dart';
import 'package:clot/core/presentation/constants/font_manager.dart';
import 'package:clot/core/presentation/ui/extension/app_spacing_extension.dart';
import 'package:clot/core/presentation/ui/extension/fontsize_extension.dart';
import 'package:clot/core/presentation/ui/widgets/app_button.dart';
import 'package:clot/core/presentation/ui/widgets/app_input_feild.dart';
import 'package:clot/core/presentation/ui/widgets/text_styles.dart';
import 'package:clot/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:clot/features/auth/presentation/sign_in/sign_in.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  static const String routeName = '/signUp';

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController firstnamecontroller = TextEditingController();
  final TextEditingController lastnamecontroller = TextEditingController();
  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController passwordcontroller = TextEditingController();

  @override
  void dispose() {
    firstnamecontroller.dispose();
    lastnamecontroller.dispose();
    emailcontroller.dispose();
    passwordcontroller.dispose();
    super.dispose();
  }

  void clearForm() {
    firstnamecontroller.clear();
    lastnamecontroller.clear();
    emailcontroller.clear();
    passwordcontroller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is Authenticated) {
          clearForm();
          if (state.user.isProfileComplete == false) {
            ;
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Account created! Complete your profile'),
              ),
            );
          } else {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(const SnackBar(content: Text('Welcome back!')));
          }
        } else if (state is AuthError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      builder: (context, state) {
        final isLoading = state is AuthLoading;
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextHeading('Create Account', color: AppColors.kBlcak100),

                  32.verticalSpace,

                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        // firstname
                        AppInputFeild(
                          controller: firstnamecontroller,
                          hintText: 'Firstname',
                          keyboardType: TextInputType.name,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Firstname is required';
                            }

                            return null;
                          },
                        ),

                        16.verticalSpace,

                        // lastname
                        AppInputFeild(
                          controller: lastnamecontroller,
                          hintText: 'Lastname',
                          keyboardType: TextInputType.name,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Lastname is required';
                            }

                            return null;
                          },
                        ),

                        16.verticalSpace,

                        // email
                        AppInputFeild(
                          controller: emailcontroller,
                          hintText: 'Email Address',
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Email Address is required';
                            }
                            if (!value.contains('@')) {
                              return 'Invalid Email Address';
                            }
                            return null;
                          },
                        ),

                        16.verticalSpace,

                        // password
                        AppInputFeild(
                          controller: passwordcontroller,
                          hintText: 'Password',
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Password is required';
                            }
                            if (value.length < 6 || value.length > 16) {
                              return 'Password must be between 6 and 16 characters';
                            }
                            return null;
                          },
                        ),

                        40.verticalSpace,

                        AppButton(
                          'Continue',
                          onTap: isLoading
                              ? null
                              : () {
                                  if (_formKey.currentState!.validate()) {
                                    context.read<AuthBloc>().add(
                                      SignUpRequested(
                                        firstname: firstnamecontroller.text
                                            .trim(),
                                        lastname: lastnamecontroller.text
                                            .trim(),
                                        email: emailcontroller.text.trim(),
                                        password: passwordcontroller.text
                                            .trim(),
                                      ),
                                    );
                                  }
                                },
                          child: isLoading
                              ? SizedBox(
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
                  24.verticalSpace,
                  Center(
                    child: AppRichText(
                      text: 'Already have an account?',
                      styles: TextStyle(
                        fontSize: 12.fs,
                        color: AppColors.kBlcak100,
                        fontWeight: FontManagerWeight.medium,
                      ),
                      textSpan: [
                        TextSpan(
                          text: ' Login',
                          style: TextStyle(
                            fontSize: 16.fs,
                            fontWeight: FontManagerWeight.bold,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => context.go(SignIn.routeName),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
