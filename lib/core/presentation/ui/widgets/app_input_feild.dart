import 'package:clot/core/presentation/constants/app_colors.dart';
import 'package:clot/core/presentation/constants/font_manager.dart';
import 'package:clot/core/presentation/ui/extension/fontsize_extension.dart';
import 'package:flutter/material.dart';

class AppInputFeild extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final TextInputType? keyboardType;
  final int minLines;
  final int maxLines;
  final String? Function(String?)? validator;
  final Widget? prefix;
  final Widget? suffix;
  final Function(String)? onChanged;
  final bool obscureText;

  const AppInputFeild({
    super.key,
    required this.controller,
    required this.hintText,
    this.keyboardType,
    this.minLines = 1,
    this.maxLines = 1,
    this.validator,
    this.prefix,
    this.suffix,
    this.onChanged,
    this.obscureText = false,
  });

  Widget _buildTextFormField(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType,
      controller: controller,
      minLines: minLines,
      maxLines: maxLines,
      obscureText: obscureText,

      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        hintText: hintText,
        hintStyle: TextStyle(
          color: AppColors.kBlcak100.withValues(alpha: 0.5),
          fontSize: 16.fs,
          fontWeight: FontManagerWeight.medium,
        ),
        filled: true,
        fillColor: AppColors.kLightGrey,
        border: InputBorder.none,
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.kError500, width: 1),
        ),
        errorStyle: TextStyle(fontWeight: FontManagerWeight.medium),
        prefixIcon: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
          child: prefix,
        ),
        prefixIconColor: AppColors.kBlcak100,
        suffixIcon: suffix,
        suffixIconColor: AppColors.kBlcak100,
      ),
      onChanged: (value) => onChanged?.call(value),
      validator: (value) => validator?.call(value),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [_buildTextFormField(context)],
    );
  }
}
