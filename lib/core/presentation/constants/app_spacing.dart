class AppSpacingSystem {
  // Allowed spacing values (design system)
  static const allowed = [4, 8, 16, 24, 32, 40, 48, 56, 64];

  /// Validates a number against the design system
  static double validate(double value) {
    if (allowed.contains(value)) return value;
    throw Exception(
      'Spacing value $value is not in the design system: $allowed',
    );
  }
}
