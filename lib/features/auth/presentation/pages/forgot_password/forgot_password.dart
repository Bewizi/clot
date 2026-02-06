import 'package:clot/core/presentation/constants/app_colors.dart';
import 'package:clot/core/presentation/ui/extension/app_spacing_extension.dart';
import 'package:clot/core/presentation/ui/widgets/app_back_button.dart';
import 'package:clot/core/presentation/ui/widgets/app_button.dart';
import 'package:clot/core/presentation/ui/widgets/app_input_feild.dart';
import 'package:clot/core/presentation/ui/widgets/text_styles.dart';
import 'package:clot/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:clot/features/auth/presentation/pages/forgot_password/reset_password.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  static const String routeName = '/forgotPassword';

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final TextEditingController emailcontroller = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is PasswordResetEmailSent) {
          context.go(ResetPassword.routeName);
        } else if (state is AuthError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message), backgroundColor: Colors.red),
          );
        }
      },
      builder: (context, state) {
        final isLoading = state is AuthLoading;
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            forceMaterialTransparency: true,
            title: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: AppBackButton(),
            ),
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextHeading('Forgot Password', color: AppColors.kBlcak100),

                  32.verticalSpace,

                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        // email
                        AppInputFeild(
                          prefix: Icon(FontAwesomeIcons.envelope),
                          controller: emailcontroller,
                          hintText: 'Enter Email address',
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email';
                            }
                            if (!RegExp(
                              r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                            ).hasMatch(value)) {
                              return 'Please enter a valid email';
                            }
                            return null;
                          },
                        ),

                        40.verticalSpace,

                        // login button
                        AppButton(
                          text: 'Continue',
                          onTap: isLoading
                              ? null
                              : () {
                                  if (_formKey.currentState!.validate()) {
                                    context.read<AuthBloc>().add(
                                      PasswordResetRequested(
                                        email: emailcontroller.text.trim(),
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
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
