import 'package:clot/core/presentation/constants/app_spacing.dart';
import 'package:flutter/material.dart';

extension AppSpacingExtension on num {
  SizedBox get verticalSpace =>
      SizedBox(height: AppSpacingSystem.validate(toDouble()));

  SizedBox get horizontalSpace =>
      SizedBox(width: AppSpacingSystem.validate(toDouble()));
}
