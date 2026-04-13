import 'package:auth_ano_g_e/core/themes/auth/colors.dart';
import 'package:flutter/material.dart';

class AuthThemeHelpers {
  static bool isDark(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

  static Color onPrimary(BuildContext context) {
    return isDark(context)
        ? AuthColors.onPrimaryDark
        : AuthColors.onPrimaryLight;
  }
  
  static Color errorOnPrimary(BuildContext context) {
    return isDark(context)
        ? AuthColors.errorDark
        : AuthColors.errorLight;
  }
}
