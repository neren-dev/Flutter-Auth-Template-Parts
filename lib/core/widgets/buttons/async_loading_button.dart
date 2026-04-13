import 'package:auth_ano_g_e/core/widgets/icon_size_builder.dart';
import 'package:auth_ano_g_e/core/widgets/press_scale_wrapper.dart';
import 'package:flutter/material.dart';

class AsyncScaleButton extends StatefulWidget {
  /// Whether the button is currently disabled
  final bool isBusy;

  /// Whether the button is showing a loading indicator
  final bool isActive;

  // Callback when button is pressed
  final Future<void> Function() onPressed;
  final String label;
  final Widget? icon;
  final ButtonStyle? style;
  final ButtonType type;

  const AsyncScaleButton._({
    required this.isBusy,
    required this.isActive,

    required this.onPressed,
    required this.label,
    required this.type,
    this.icon,
    this.style,
    super.key,
  });

  // Filled
  factory AsyncScaleButton.filled({
    required bool isBusy,
    required bool isActive,

    required Future<void> Function() onPressed,
    required String label,
    Widget? icon,
    ButtonStyle? style,
    Key? key,
  }) {
    return AsyncScaleButton._(
      key: key,
      isBusy: isBusy,
      isActive: isActive,
      onPressed: onPressed,
      label: label,
      icon: icon,
      style: style,
      type: ButtonType.filled,
    );
  }

  // Outlined
  factory AsyncScaleButton.outlined({
    required bool isBusy,
    required bool isActive,

    required Future<void> Function() onPressed,
    required String label,
    Widget? icon,
    ButtonStyle? style,
    Key? key,
  }) {
    return AsyncScaleButton._(
      key: key,
      isBusy: isBusy,
      isActive: isActive,
      onPressed: onPressed,
      label: label,
      icon: icon,
      style: style,
      type: ButtonType.outlined,
    );
  }

  // Elevated
  factory AsyncScaleButton.elevated({
    required bool isBusy,
    required bool isActive,
    required Future<void> Function() onPressed,
    required String label,
    Widget? icon,
    ButtonStyle? style,
    Key? key,
  }) {
    return AsyncScaleButton._(
      key: key,
      isBusy: isBusy,
      isActive: isActive,
      onPressed: onPressed,
      label: label,
      icon: icon,
      style: style,
      type: ButtonType.elevated,
    );
  }

  @override
  State<AsyncScaleButton> createState() => _AsyncScaleButtonState();
}

class _AsyncScaleButtonState extends State<AsyncScaleButton> {
  bool get _isNotInteractive => widget.isBusy;

  Widget _buildButton(VoidCallback? onPressed) {
    final child = IconSizeBuilder(
      min: 22,
      builder: (context, iconSize) {
        // Flexible ensures the text wraps within the available space, preventing overflow errors in a Row.
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: Stack(
            alignment: Alignment.center,
            children: [
              AnimatedOpacity(
                duration: const Duration(milliseconds: 350),
                opacity: widget.isActive ? 0 : 1,
                child: Row(
                  spacing: 12,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (widget.icon != null)
                      SizedBox(
                        width: iconSize,
                        height: iconSize,
                        child: FittedBox(
                          fit: BoxFit.contain,
                          child: widget.icon!,
                        ),
                      ),
                    Flexible(child: Text(widget.label)),

                    // Flexible ensures the text wraps within the available space, preventing overflow errors in a Row.
                  ],
                ),
              ),
              if (widget.isActive)
                AnimatedOpacity(
                  duration: const Duration(milliseconds: 350),
                  opacity: widget.isActive ? 1 : 0,
                  child: SizedBox.square(
                    dimension: (iconSize > 20 ? (iconSize - 4) : iconSize)
                        .clamp(18, 26),
                    child: CircularProgressIndicator(
                      strokeWidth: (iconSize * 0.11).clamp(1, 3),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );

    switch (widget.type) {
      case ButtonType.filled:
        return FilledButton(
          style: widget.style,
          onPressed: onPressed,
          // onPressed is already nullified by the caller if the button is inactive; no additional disabling logic needed here.
          child: child,
        );

      case ButtonType.outlined:
        return OutlinedButton(
          style: widget.style,
          onPressed: onPressed,
          child: child,
        );

      case ButtonType.elevated:
        return ElevatedButton(
          style: widget.style,
          onPressed: onPressed,
          child: child,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return PressScaleWrapper(
      enabled: !_isNotInteractive,
      child: _buildButton(_isNotInteractive ? null : widget.onPressed),
    );
  }
}

enum ButtonType { filled, outlined, elevated }
