import 'package:auth_ano_g_e/core/themes/auth/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:hyper_snackbar/hyper_snackbar.dart';
import 'package:auth_ano_g_e/core/navigation/go_routes.dart';
import 'package:auth_ano_g_e/core/widgets/wobble_icon.dart';

/// clears all the hypersnackbars before showing new
void showHyperSnackbar({
  Future<void> Function()? onRetryPressed,
  required Object message,
  bool mounted = true,
  required bool clearAll,
  Widget? icon,
  Color? bgColor,
}) {
  if (!mounted) return;

  if (clearAll) {
    HyperSnackbar.clearAll();
  }
  const textColor = Colors.white;
  HyperSnackbar.show(
    context: rootNavigatorKey.currentContext,

    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
    position: HyperSnackPosition.bottom,

    enterAnimationType: HyperSnackAnimationType.fade,
    exitAnimationType: HyperSnackAnimationType.fade,
    margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
    maxWidth: 500,
    showCloseButton: false,
    borderRadius: 24,
    border: BoxBorder.all(color: Colors.white70),
    backgroundColor: bgColor,
    textColor: textColor,

    content: Row(
      mainAxisSize: MainAxisSize.min,
      spacing: 13,
      children: [
        ?icon,
        Flexible(
          child: Text(message.toString(), style: TextStyle(color: textColor)),
        ),
        if (onRetryPressed != null)
          TextButton(
            onPressed: () {
              HyperSnackbar.clearAll();
              onRetryPressed();
            },
            child: const Text("Retry", style: TextStyle(color: Colors.blue)),
          ),
      ],
    ),
    actionAlignment: MainAxisAlignment.end,
  );
}

/// clears all the hypersnackbars before showing new
void showHyperErrorSnackbar({
  Future<void> Function()? onRetryPressed,
  required Object error,
  bool mounted = true,
  bool clearAll = true,
  Widget? icon,
}) {
  showHyperSnackbar(
    message: error,
    mounted: mounted,
    onRetryPressed: onRetryPressed,
    icon: icon,
    clearAll: clearAll,
    bgColor: Colors.red,
  );
}

/// clears all the hypersnackbars before showing new
void showHyperSuccessSnackbar({
  Future<void> Function()? onRetryPressed,
  required Object message,
  bool mounted = true,
  bool clearAll = true,
  Widget? icon,
}) {
  showHyperSnackbar(
    message: message,
    mounted: mounted,
    onRetryPressed: onRetryPressed,
    icon: icon,
    clearAll: clearAll,
    bgColor: Colors.green,
  );
}

/// clears all the hypersnackbars before showing new
void showHyperInfoSnackbar({
  Future<void> Function()? onRetryPressed,
  required Object message,
  bool mounted = true,
  bool clearAll = true,
  Widget? icon,
}) {
  showHyperSnackbar(
    message: message,
    mounted: mounted,
    onRetryPressed: onRetryPressed,
    icon: icon,
    clearAll: clearAll,
    bgColor: const Color.fromARGB(255, 23, 23, 23),
  );
}

/// clears all the hypersnackbars before showing new
void showInternetErrorSnackbar({
  Future<void> Function()? onRetryPressed,
  required Object message,
  bool mounted = true,
  bool clearAll = true,
}) {
  showHyperSnackbar(
    message: message,
    mounted: mounted,
    clearAll: clearAll,
    onRetryPressed: onRetryPressed,
    icon: const WobbleIcon(icon: AuthIcons.wifiOff, color: Colors.blue),
    bgColor: const Color.fromARGB(255, 23, 23, 23),
  );
}
