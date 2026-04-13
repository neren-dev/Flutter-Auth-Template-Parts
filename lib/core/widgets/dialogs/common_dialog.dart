import 'package:auth_ano_g_e/core/themes/auth/overlays/dialog.dart';
import 'package:auth_ano_g_e/core/themes/auth/buttons/filled_button.dart';
import 'package:auth_ano_g_e/core/widgets/buttons/auth_button_style.dart';
import 'package:auth_ano_g_e/core/widgets/theme_helpers.dart';
import 'package:flutter/material.dart';

class AuthCommonDialog extends StatelessWidget {
  const AuthCommonDialog({
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
    required this.children,
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

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        progressIndicatorTheme: const ProgressIndicatorThemeData(
          color: Colors.white,
        ),
        textTheme: Theme.of(
          context,
        ).textTheme.apply(bodyColor: AuthThemeHelpers.onPrimary(context)),
      ),
      child: Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 500),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                spacing: 18,
                children: children,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class AuthDialogButtonsRow extends StatelessWidget {
  const AuthDialogButtonsRow({
    super.key,
    required this.cancelBgColor,
    required this.cancelTextColor,
    required this.cancelText,
    required this.confirmBgColor,
    required this.confirmTextColor,
    required this.confirmText,
  });

  final Color? cancelBgColor;
  final Color? cancelTextColor;
  final String cancelText;
  final Color? confirmBgColor;
  final Color? confirmTextColor;
  final String confirmText;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      spacing: 18,

      children: [
        /// Cancel Button
        Flexible(
          child: FilledButton(
            style: AuthDialogButtonStyle.elevated(
              bgColor: cancelBgColor,
              textColor: cancelTextColor,
              theme: AuthFilledButton.cancelTheme(),
            ),
            onPressed: () {
              Navigator.of(context).pop(false);
            },
            child: Text(cancelText),
          ),
        ),

        /// Confirm Button
        Flexible(
          child: FilledButton(
            style: AuthDialogButtonStyle.elevated(
              bgColor: confirmBgColor,
              textColor: confirmTextColor,
              theme: AuthFilledButton.confirmTheme(),
            ),
            onPressed: () {
              Navigator.of(context).pop(true);
            },
            child: Text(confirmText),
          ),
        ),
      ],
    );
  }
}

class AuthDialogWarning extends StatelessWidget {
  const AuthDialogWarning({
    super.key,
    required this.warning,
    this.warningTextColor,
  });

  final String warning;
  final Color? warningTextColor;

  @override
  Widget build(BuildContext context) {
    return Text(
      warning,
      style: AuthDialogTheme.commonSubtitleAndWarningTextStyle.copyWith(
        color: warningTextColor,
        backgroundColor: AuthThemeHelpers.onPrimary(context).withAlpha(10),
      ),
      textAlign: TextAlign.center,
    );
  }
}

class AuthDialogSubtitle extends StatelessWidget {
  const AuthDialogSubtitle({
    super.key,
    required this.subtitle,
    this.subtitleTextColor,
  });

  final String? subtitle;
  final Color? subtitleTextColor;

  @override
  Widget build(BuildContext context) {
    return Text(
      subtitle!,
      style: AuthDialogTheme.commonSubtitleAndWarningTextStyle.copyWith(
        color: subtitleTextColor,
      ),
      textAlign: TextAlign.center,
    );
  }
}

class AuthDialogTitle extends StatelessWidget {
  const AuthDialogTitle({super.key, required this.title, this.titleStyle});

  final String title;
  final TextStyle? titleStyle;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: titleStyle ?? AuthDialogTheme.titleTextStyle,
      textAlign: TextAlign.center,
    );
  }
}
