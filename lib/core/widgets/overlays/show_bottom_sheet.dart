import 'package:flutter/material.dart';

class AuthShowBottomSheet {
  /// `isScrollControlled + viewInsets` ensures proper keyboard handling
  static Future<void> show({
    required BuildContext context,
    required RouteSettings? routeSettings,
    required Widget child,
  }) async {
    await showModalBottomSheet(
      routeSettings: routeSettings,

      /// Ensures sheet appears above nested navigators.
      useRootNavigator: true,
      isScrollControlled: true,
      enableDrag: true,
      showDragHandle: true,
      context: context,
      builder: (sheetContext) {
        return SafeArea(
          child: Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(sheetContext).viewInsets.bottom,
            ),
            child: SingleChildScrollView(
              /// Reuses LoginCard for re-authentication to keep flows consistent.
              child: child,
            ),
          ),
        );
      },
    );
  }
}
