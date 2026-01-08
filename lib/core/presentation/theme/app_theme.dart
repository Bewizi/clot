import 'package:clot/core/presentation/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppThemeData {
  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.kWhite100,
    appBarTheme: AppBarTheme(
      elevation: 0,
      backgroundColor: AppColors.kWhite100,
    ),
    useMaterial3: true,
    textTheme: GoogleFonts.gabaritoTextTheme(),
    primaryColor: AppColors.kPrimary,
    colorScheme: ColorScheme(
      brightness: Brightness.light,
      primary: AppColors.kPrimary,
      onPrimary: AppColors.kWhite100,
      secondary: AppColors.kBlcak100,
      onSecondary: AppColors.kWhite100,
      error: AppColors.kError500,
      onError: AppColors.kWhite100,
      surface: AppColors.kLightGrey,
      onSurface: AppColors.kBlcak100,
    ),
  );
}
