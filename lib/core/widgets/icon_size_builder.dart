import 'package:flutter/widgets.dart';

class IconSizeBuilder extends StatelessWidget {
  final Widget Function(BuildContext context, double iconSize) builder;

  final double factor;
  final double min;
  final double max;
  final double fallback;

  const IconSizeBuilder({
    super.key,
    required this.builder,
    this.factor = 1.0,
    this.min = 16,
    this.max = 40,
    this.fallback = 14,
  });

  @override
  Widget build(BuildContext context) {
    final textStyle = DefaultTextStyle.of(context).style;
    final textScaler = MediaQuery.textScalerOf(context);

    final baseSize = textStyle.fontSize ?? fallback;
    final scaledSize = textScaler.scale(baseSize);
    final iconSize = (scaledSize * factor).clamp(min, max);

    return builder(context, iconSize);
  }
}