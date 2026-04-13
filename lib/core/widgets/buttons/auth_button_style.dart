import 'package:flutter/material.dart';

class AuthDialogButtonStyle {
  static ButtonStyle elevated({
    Color? bgColor,
    Color? textColor,
    required ButtonStyle theme,
  }) {
    final resolvedBg =
        bgColor ?? theme.backgroundColor?.resolve({});
    final resolvedFg =
        textColor ?? theme.foregroundColor?.resolve({});

    return ElevatedButton.styleFrom(
      backgroundColor: resolvedBg,
      disabledBackgroundColor: resolvedBg,
      foregroundColor: resolvedFg,
      disabledForegroundColor: resolvedFg,
    );
  }
}