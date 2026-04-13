import 'package:auth_ano_g_e/core/themes/auth/overlays/dialog.dart';
import 'package:auth_ano_g_e/core/widgets/dialogs/common_dialog.dart';
import 'package:flutter/material.dart';

class AppConfirmDialog extends StatelessWidget {
  const AppConfirmDialog({
    super.key,
    this.title = "Are you sure?",
    this.titleStyle = AuthDialogTheme.titleTextStyle,
    this.subtitle,
    this.subtitleTextColor,
    this.warning,
    this.warningTextColor = Colors.red,
    this.confirmText = "Confirm",
    this.cancelText = "Cancel",
    this.confirmBgColor,
    this.cancelBgColor,
    this.confirmTextColor,
    this.cancelTextColor,
  });

  /// Title
  final String title;
  final TextStyle titleStyle;

  /// Optional subtitle (hidden if null)
  final String? subtitle;
  final Color? subtitleTextColor;

  final String? warning;
  final Color warningTextColor;

  /// Button texts
  final String confirmText;
  final String cancelText;

  /// Button background colors
  final Color? confirmBgColor;
  final Color? cancelBgColor;

  /// Button text colors
  final Color? confirmTextColor;
  final Color? cancelTextColor;

  @override
  Widget build(BuildContext context) {
    return AuthCommonDialog(
      children: [
        AuthDialogTitle(title: title, titleStyle: titleStyle),

        if (subtitle != null)
          AuthDialogSubtitle(
            subtitle: subtitle,
            subtitleTextColor: subtitleTextColor,
          ),

        if (warning != null)
          AuthDialogWarning(
            warning: warning!,
            warningTextColor: warningTextColor,
          ),

        AuthDialogButtonsRow(
          cancelBgColor: cancelBgColor,
          cancelTextColor: cancelTextColor,
          cancelText: cancelText,
          confirmBgColor: confirmBgColor,
          confirmTextColor: confirmTextColor,
          confirmText: confirmText,
        ),
      ],
    );
  }

  static Future<bool?> showAppConfirmDialog({
    required BuildContext context,
    String title = "Are you sure?",
    String? subtitle,
    Color? subtitleTextColor,
    String? warning,
    String confirmText = "Confirm",
    String cancelText = "Cancel",
    Color? confirmBgColor,
  }) async {
    return await showDialog<bool?>(
      context: context,
      builder: (_) {
        return AppConfirmDialog(
          title: title,
          subtitle: subtitle,
          warning: warning,
          subtitleTextColor: subtitleTextColor,
          confirmText: confirmText,
          cancelText: cancelText,
          confirmBgColor: confirmBgColor,
        );
      },
    );
  }
}

Future<bool?> changeEmailConfirmationDialog(BuildContext context) async {
  return await AppConfirmDialog.showAppConfirmDialog(
    context: context,
    warning:
        "After verifying the new email, you will be signed out automatically.\nPlease save any unsaved data.",
    confirmText: "Continue",
  );
}

Future<bool?> showGuestSignInConfirmationDialog(BuildContext context) async {
  return await AppConfirmDialog.showAppConfirmDialog(
    context: context,
    title: 'Continue as Guest?',
    warning:
        "Your data will be lost if you sign out or uninstall the app before linking an account.",
    confirmText: "Continue",
  );
}
