import 'package:clot/core/presentation/constants/app_colors.dart';
import 'package:clot/core/presentation/constants/app_svgs.dart';
import 'package:clot/core/presentation/constants/font_manager.dart';
import 'package:clot/core/presentation/ui/extension/app_spacing_extension.dart';
import 'package:clot/core/presentation/ui/extension/fontsize_extension.dart';
import 'package:clot/core/presentation/ui/widgets/app_button.dart';
import 'package:clot/core/presentation/ui/widgets/app_input_feild.dart';
import 'package:clot/core/presentation/ui/widgets/text_styles.dart';
import 'package:clot/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:clot/features/auth/presentation/forgot_password/forgot_password.dart';
import 'package:clot/features/auth/presentation/sign_up/sign_up.dart';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  static const String routeName = '/signIn';

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController passwordcontroller = TextEditingController();

  bool isLoading = false;

  @override
  void dispose() {
    emailcontroller.dispose();
    passwordcontroller.dispose();
    super.dispose();
  }

  void clearForm() {
    emailcontroller.clear();
    passwordcontroller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is Authenticated) {
          clearForm();
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('Login successfully')));
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
                  TextHeading('Sign in', color: AppColors.kBlcak100),
                  32.verticalSpace,

                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
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
                        Column(
                          crossAxisAlignment: .start,
                          children: [
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

                            16.verticalSpace,

                            // forgot password
                            Row(
                              mainAxisAlignment: .end,
                              children: [
                                AppRichText(
                                  text: 'Forgot Password ? ',
                                  styles: TextStyle(
                                    fontSize: 12.fs,
                                    color: AppColors.kBlcak100,
                                    fontWeight: FontManagerWeight.medium,
                                  ),

                                  textSpan: [
                                    TextSpan(
                                      text: ' Reset',
                                      style: TextStyle(
                                        fontSize: 16.fs,
                                        fontWeight: FontManagerWeight.bold,
                                      ),

                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () => context.push(
                                          ForgotPassword.routeName,
                                        ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),

                        SizedBox(height: 40),

                        // login button
                        AppButton(
                          'Login',
                          onTap: isLoading
                              ? null
                              : () {
                                  if (_formKey.currentState!.validate()) {
                                    context.read<AuthBloc>().add(
                                      SignInRequested(
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
                      text: 'Dont have an Account ? ',
                      styles: TextStyle(
                        fontSize: 12.fs,
                        color: AppColors.kBlcak100,
                        fontWeight: FontManagerWeight.medium,
                      ),
                      textSpan: [
                        TextSpan(
                          text: ' Create One',
                          style: TextStyle(
                            fontSize: 16.fs,
                            fontWeight: FontManagerWeight.bold,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => context.go(SignUp.routeName),
                        ),
                      ],
                    ),
                  ),

                  40.verticalSpace,

                  _buildSignInOptions(
                    context,
                    () {},
                    'Continue With Apple',
                    AppSvgs.apple,
                  ),
                  16.verticalSpace,
                  _buildSignInOptions(
                    context,
                    () {},
                    'Continue With Google',
                    AppSvgs.google,
                  ),
                  16.verticalSpace,
                  _buildSignInOptions(
                    context,
                    () {},
                    'Continue With Facebook',
                    AppSvgs.facebook,
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

Widget _buildSignInOptions(
  BuildContext context,
  VoidCallback? onTap,
  String text,
  String icon,
) {
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
              SvgPicture.asset(icon, fit: BoxFit.cover, width: 24, height: 24),
              SizedBox(width: 10),
              Expanded(
                child: Center(
                  child: TextRegular(text, color: AppColors.kBlcak100),
                ),
              ),
            ],
          ),
        ),
      ),
    ],
  );
}
