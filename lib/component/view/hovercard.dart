import 'dart:async';

import 'package:jaspr/jaspr.dart';

import '../../core/theme_provider.dart';

export '../../core/props/hovercard_props.dart'
    show HovercardPositionVariant, HovercardProps;

/// Hovercard position relative to the trigger element.
enum HovercardPosition {
  top,
  bottom,
  left,
  right,
  topStart,
  topEnd,
  bottomStart,
  bottomEnd,
}

/// A floating card that appears on hover with rich, interactive content.
class ArcaneHovercard extends StatefulComponent {
  final Component trigger;
  final Component content;
  final HovercardPosition position;
  final bool showArrow;
  final int openDelay;
  final int closeDelay;
  final int offset;
  final bool? isOpen;
  final void Function(bool isOpen)? onOpenChange;

  const ArcaneHovercard({
    required this.trigger,
    required this.content,
    this.position = HovercardPosition.top,
    this.showArrow = true,
    this.openDelay = 200,
    this.closeDelay = 300,
    this.offset = 8,
    this.isOpen,
    this.onOpenChange,
    super.key,
  });

  @override
  State<ArcaneHovercard> createState() => _ArcaneHovercardState();
}

class _ArcaneHovercardState extends State<ArcaneHovercard> {
  bool _internalIsOpen = false;
  Timer? _openTimer;
  Timer? _closeTimer;

  bool get _isOpen => component.isOpen ?? _internalIsOpen;

  void _cancelTimers() {
    _openTimer?.cancel();
    _openTimer = null;
    _closeTimer?.cancel();
    _closeTimer = null;
  }

  void _startOpenTimer() {
    _cancelTimers();
    if (component.openDelay <= 0) {
      _open();
    } else {
      _openTimer = Timer(Duration(milliseconds: component.openDelay), _open);
    }
  }

  void _startCloseTimer() {
    _cancelTimers();
    if (component.closeDelay <= 0) {
      _close();
    } else {
      _closeTimer = Timer(Duration(milliseconds: component.closeDelay), _close);
    }
  }

  void _open() {
    if (!_isOpen) {
      if (component.isOpen == null) {
        setState(() => _internalIsOpen = true);
      }
      component.onOpenChange?.call(true);
    }
  }

  void _close() {
    if (_isOpen) {
      if (component.isOpen == null) {
        setState(() => _internalIsOpen = false);
      }
      component.onOpenChange?.call(false);
    }
  }

  void _handleMouseEnter() {
    _cancelTimers();
    _startOpenTimer();
  }

  void _handleMouseLeave() {
    _cancelTimers();
    _startCloseTimer();
  }

  HovercardPositionVariant get _propsPosition => switch (component.position) {
        HovercardPosition.top => HovercardPositionVariant.top,
        HovercardPosition.bottom => HovercardPositionVariant.bottom,
        HovercardPosition.left => HovercardPositionVariant.left,
        HovercardPosition.right => HovercardPositionVariant.right,
        HovercardPosition.topStart => HovercardPositionVariant.topStart,
        HovercardPosition.topEnd => HovercardPositionVariant.topEnd,
        HovercardPosition.bottomStart => HovercardPositionVariant.bottomStart,
        HovercardPosition.bottomEnd => HovercardPositionVariant.bottomEnd,
      };

  @override
  Component build(BuildContext context) {
    return context.renderers.hovercard(HovercardProps(
      trigger: component.trigger,
      content: component.content,
      position: _propsPosition,
      showArrow: component.showArrow,
      offset: component.offset,
      isOpen: _isOpen,
      onMouseEnter: _handleMouseEnter,
      onMouseLeave: _handleMouseLeave,
    ));
  }
}
