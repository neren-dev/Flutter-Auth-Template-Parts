import 'package:flutter/material.dart';

class PressScaleWrapper extends StatefulWidget {
  final Widget child;
  final bool enabled;

  const PressScaleWrapper({
    required this.child,
    required this.enabled,
    super.key,
  });

  @override
  State<PressScaleWrapper> createState() => _PressScaleWrapperState();
}

class _PressScaleWrapperState extends State<PressScaleWrapper>
    with SingleTickerProviderStateMixin {
  static const _lowerBound = 0.965;
  static const _upperBound = 1.0;

  late final AnimationController _controller;

  bool _isPointerInside = false;

  bool get _enabled => widget.enabled;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 175),
      lowerBound: _lowerBound,
      upperBound: _upperBound,
      value: _upperBound,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant PressScaleWrapper oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (!widget.enabled && _controller.value != _upperBound) {
      _controller.animateTo(_upperBound);
    }
  }

  void _onPointerDown(_) {
    setState(() {
      _isPointerInside = true;
    });
    _controller.animateTo(_lowerBound);
  }

  void _onPointerMove(PointerMoveEvent event) {
    if (!_isPointerInside) return;

    final box = context.findRenderObject();
    if (box is! RenderBox) return;

    final rect = box.localToGlobal(Offset.zero) & box.size;
    final isInside = rect.contains(event.position);

    if (!isInside && _controller.value != _upperBound) {
      _controller.animateTo(_upperBound);
    }

    _isPointerInside = isInside;
  }

  void _reset() {
    _controller.animateTo(_upperBound);
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _controller,
      child: Listener(
        onPointerDown: _enabled ? _onPointerDown : null,
        onPointerMove: _enabled ? _onPointerMove : null,
        onPointerUp: (_) => _reset(),
        onPointerCancel: (_) => _reset(),
        child: widget.child,
      ),
    );
  }
}
