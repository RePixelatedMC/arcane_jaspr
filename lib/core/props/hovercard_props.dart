import 'package:jaspr/jaspr.dart';

enum HovercardPositionVariant {
  top,
  bottom,
  left,
  right,
  topStart,
  topEnd,
  bottomStart,
  bottomEnd,
}

/// Hovercard component properties.
class HovercardProps {
  final Component trigger;
  final Component content;
  final HovercardPositionVariant position;
  final bool showArrow;
  final int offset;
  final bool isOpen;
  final void Function()? onMouseEnter;
  final void Function()? onMouseLeave;

  const HovercardProps({
    required this.trigger,
    required this.content,
    this.position = HovercardPositionVariant.top,
    this.showArrow = true,
    this.offset = 8,
    this.isOpen = false,
    this.onMouseEnter,
    this.onMouseLeave,
  });
}
