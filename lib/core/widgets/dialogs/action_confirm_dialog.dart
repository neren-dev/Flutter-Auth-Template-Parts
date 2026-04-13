import 'package:auth_ano_g_e/features/shared/state/effects/app_effects.dart';
import 'package:auth_ano_g_e/features/shared/state/effects/app_effects_notifier.dart';
import 'package:auth_ano_g_e/core/navigation/flow_mapper.dart';
import 'package:auth_ano_g_e/features/auth/login/state/auth_config.dart';
import 'package:auth_ano_g_e/features/profile/state/notifier.dart';
import 'package:auth_ano_g_e/core/themes/auth/colors.dart';
import 'package:auth_ano_g_e/core/themes/auth/overlays/dialog.dart';
import 'package:auth_ano_g_e/core/themes/auth/buttons/filled_button.dart';
import 'package:auth_ano_g_e/core/widgets/buttons/async_loading_button.dart';
import 'package:auth_ano_g_e/core/widgets/buttons/auth_button_style.dart';
import 'package:auth_ano_g_e/core/widgets/dialogs/common_dialog.dart';
import 'package:auth_ano_g_e/core/widgets/theme_helpers.dart';
import 'package:flutter/material.dart';

class AuthActionConfirmDialog extends StatefulWidget {
  const AuthActionConfirmDialog({
    super.key,
    required this.onConfirm,

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

    this.autoPopOnSuccess = true,
  });

  final Future<bool> Function() onConfirm;

  final String title;
  final TextStyle titleStyle;

  final String? subtitle;
  final Color? subtitleTextColor;

  final String? warning;
  final Color warningTextColor;

  final String confirmText;
  final String cancelText;

  final Color? confirmBgColor;
  final Color? cancelBgColor;

  final Color? confirmTextColor;
  final Color? cancelTextColor;

  /// Whether to close dialog after success
  final bool autoPopOnSuccess;

  @override
  State<AuthActionConfirmDialog> createState() =>
      _AuthActionConfirmDialogState();
}

class _AuthActionConfirmDialogState extends State<AuthActionConfirmDialog> {
  bool _isActive = false;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: !_isActive,
      child: AuthCommonDialog(
        children: [
          AuthDialogTitle(title: widget.title, titleStyle: widget.titleStyle),

          if (widget.subtitle != null)
            AuthDialogSubtitle(
              subtitle: widget.subtitle,
              subtitleTextColor: widget.subtitleTextColor,
            ),

          if (widget.warning != null)
            AuthDialogWarning(
              warning: widget.warning!,
              warningTextColor: widget.warningTextColor,
            ),

          /// Buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            spacing: 18,
            children: [
              /// Cancel
              Flexible(
                child: FilledButton(
                  style: AuthDialogButtonStyle.elevated(
                    bgColor: widget.cancelBgColor,
                    textColor: widget.cancelTextColor,
                    theme: AuthFilledButton.cancelTheme(),
                  ),
                  onPressed: _isActive
                      ? null
                      : () {
                          Navigator.of(context).pop(false);
                        },
                  child: Text(widget.cancelText),
                ),
              ),

              /// Confirm (Async)
              Flexible(
                child: AsyncScaleButton.filled(
                  style: AuthDialogButtonStyle.elevated(
                    bgColor: widget.confirmBgColor,
                    textColor: widget.confirmTextColor,
                    theme: AuthFilledButton.confirmTheme(),
                  ),
                  label: widget.confirmText,
                  isBusy: _isActive,
                  isActive: _isActive,
                  onPressed: () async {
                    _isActive = true;
                    setState(() {});

                    final result = await widget.onConfirm();

                    if (result) {
                      if (widget.autoPopOnSuccess && context.mounted) {
                        Navigator.of(context).pop(true);
                      }
                    } else {
                      if (mounted) {
                        _isActive = false;
                        setState(() {});
                      }
                    }
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// helper

class AuthActionConfirmDialogHelper {
  static Future<bool?> show({
    required BuildContext context,
    required Future<bool> Function() onConfirm,

    String title = "Are you sure?",
    String? subtitle,
    String? warning,
    String confirmText = "Confirm",
    Color? confirmBgColor,
  }) {
    return showDialog<bool?>(
      context: context,
      // PopScope will override barrierDismissible during loading
      builder: (_) {
        return AuthActionConfirmDialog(
          onConfirm: onConfirm,
          title: title,
          subtitle: subtitle,
          warning: warning,
          confirmText: confirmText,
          confirmBgColor: confirmBgColor,
        );
      },
    );
  }

  static Future<void> signOut(
    BuildContext context,
    Future<void> Function() onSignOut,
    bool isAnonymous,
    GlobalEffectNotifier globalEffectNotifier,
  ) async {
    final SignOutData signOutData = isAnonymous
        ? const SignOutData(
            title: 'Sign Out?',
            subtitle:
                'Guest data will be lost if you continue.\nLink this account first to preserve it.',
            warning:
                'You won\'t be able to sign back into this guest account. Data will be lost.',
          )
        : const SignOutData(
            title: 'Sign Out?',
            subtitle: 'You\'ll need to sign in again to access your account.',
            warning: 'Unsaved data may be lost!',
          );

    await AuthActionConfirmDialogHelper.show(
      context: context,
      onConfirm: () async {
        await onSignOut();
        globalEffectNotifier.emitMany([
          GoToLoginReset(),
          const ShowSuccessSnackbar("Account successfully signed out."),
        ]);
        return true;
      },
      title: signOutData.title,
      subtitle: signOutData.subtitle,
      warning: signOutData.warning,
      confirmText: 'Sign Out',
      confirmBgColor: AuthThemeHelpers.errorOnPrimary(context).withAlpha(225),
    );
  }

  static Future<void> credConflictSignIn(
    BuildContext context,
    Future<bool> Function() onSignIn,
    bool isAnonymous,
  ) async {
    await AuthActionConfirmDialogHelper.show(
      context: context,
      onConfirm: onSignIn,
      title: 'Account exists',
      subtitle: 'Sign in instead?',
      warning: isAnonymous
          ? 'Guest data will be lost if you continue.\nLink this account first to preserve it.'
          : 'Unsaved data may be lost!',
      confirmText: 'Sign In',
      confirmBgColor: AuthColors.blue,
    );
  }

  static Future<void> delete(
    BuildContext context,
    ProfileNotifier notifier,
  ) async {
    await AuthActionConfirmDialogHelper.show(
      context: context,
      onConfirm: notifier.deleteAccount,
      title: 'Delete Account?',
      warning: 'All your data associated with this account will be deleted.',
      confirmText: 'Delete',
      confirmBgColor: AuthThemeHelpers.errorOnPrimary(context),
    );
  }

  static Future<void> unlink(
    BuildContext context,
    ProfileNotifier notifier,
    AuthProviderType provider,
  ) async {
    final providerName = AuthProviderMapper.toName(provider);
    await AuthActionConfirmDialogHelper.show(
      context: context,
      onConfirm: () async {
        return await notifier.unlinkProvider(provider);
      },
      title: 'Unlink $providerName?',
      warning:
          'You will no longer be able to sign in to this account using ${providerName.toLowerCase()}.',
      confirmText: 'Unlink',
      confirmBgColor: AuthThemeHelpers.errorOnPrimary(context).withAlpha(210),
    );
  }
}

class SignOutData {
  final String title;
  final String subtitle;
  final String warning;

  const SignOutData({
    required this.title,
    required this.subtitle,
    required this.warning,
  });
}
