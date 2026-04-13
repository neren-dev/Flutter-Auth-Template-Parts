import 'dart:math';
import 'package:flutter/material.dart';

class WobbleIcon extends StatefulWidget {
  final IconData icon;
  final Color? color;
  final double size;

  const WobbleIcon({
    super.key,
    required this.icon,
    this.color,
    this.size = 22,
  });

  @override
  State<WobbleIcon> createState() => _WobbleIconState();
}

class _WobbleIconState extends State<WobbleIcon>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    )..forward(); // run once
  }

  double _wobble(double t) {
    return sin(t * 2 * pi * 2) * (1 - t) * 6;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(_wobble(_controller.value), 0),
          child: child,
        );
      },
      child: Icon(
        widget.icon,
        color: widget.color ?? Colors.white70,
        size: widget.size,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

