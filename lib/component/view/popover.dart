import 'dart:async';

import 'package:jaspr/jaspr.dart';

import '../../core/theme_provider.dart';

export '../../core/props/popover_props.dart' show PopoverPosition, PopoverTrigger;

/// A floating content panel that appears relative to a trigger element.
class ArcanePopover extends StatefulComponent {
  final Component trigger;
  final Component content;
  final PopoverPosition position;
  final PopoverTrigger triggerType;
  final bool? isOpen;
  final void Function(bool isOpen)? onOpenChange;
  final bool showArrow;
  final bool closeOnOutsideClick;
  final bool closeOnEscape;
  final int offset;
  final int openDelay;
  final int closeDelay;

  const ArcanePopover({
    required this.trigger,
    required this.content,
    this.position = PopoverPosition.bottom,
    this.triggerType = PopoverTrigger.click,
    this.isOpen,
    this.onOpenChange,
    this.showArrow = true,
    this.closeOnOutsideClick = true,
    this.closeOnEscape = true,
    this.offset = 8,
    this.openDelay = 0,
    this.closeDelay = 0,
    super.key,
  });

  @override
  State<ArcanePopover> createState() => _ArcanePopoverState();
}

class _ArcanePopoverState extends State<ArcanePopover> {
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

  void _toggle() {
    _cancelTimers();
    final newState = !_isOpen;
    if (component.isOpen == null) {
      setState(() => _internalIsOpen = newState);
    }
    component.onOpenChange?.call(newState);
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

  void _handleTriggerEnter() {
    _cancelTimers();
    _startOpenTimer();
  }

  void _handleTriggerLeave() {
    _cancelTimers();
    _startCloseTimer();
  }

  @override
  Component build(BuildContext context) {
    return context.renderers.popover(PopoverProps(
      trigger: component.trigger,
      content: component.content,
      isOpen: _isOpen,
      position: component.position,
      triggerType: component.triggerType,
      onToggle: _toggle,
      onMouseEnter: _handleTriggerEnter,
      onMouseLeave: _handleTriggerLeave,
      showArrow: component.showArrow,
      offset: component.offset,
    ));
  }
}
