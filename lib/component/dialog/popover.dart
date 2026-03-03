import 'package:jaspr/jaspr.dart';

import '../view/floating.dart';

export '../../core/props/floating_props.dart' show FloatingPosition;

class ArcanePopover extends StatelessComponent {
  final Component trigger;
  final Component content;
  final FloatingPosition position;
  final bool? isOpen;
  final void Function(bool isOpen)? onOpenChange;
  final bool showArrow;
  final int offset;
  final bool closeOnOutsideClick;
  final bool closeOnEscape;

  const ArcanePopover({
    required this.trigger,
    required this.content,
    this.position = FloatingPosition.bottom,
    this.isOpen,
    this.onOpenChange,
    this.showArrow = true,
    this.offset = 8,
    this.closeOnOutsideClick = true,
    this.closeOnEscape = true,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return ArcaneFloating.popover(
      trigger: trigger,
      content: content,
      position: position,
      isOpen: isOpen,
      onOpenChange: onOpenChange,
      showArrow: showArrow,
      offset: offset,
      closeOnOutsideClick: closeOnOutsideClick,
      closeOnEscape: closeOnEscape,
    );
  }
}
