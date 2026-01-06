import 'package:jaspr/jaspr.dart';

/// Position for hovercard
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

/// Props for the hovercard component
class HovercardProps {
  /// The trigger element
  final Component trigger;

  /// The content to display
  final Component content;

  /// Position relative to trigger
  final HovercardPositionVariant position;

  /// Whether to show arrow
  final bool showArrow;

  /// Offset in pixels
  final int offset;

  /// Whether currently open
  final bool isOpen;

  /// Mouse enter handler
  final void Function()? onMouseEnter;

  /// Mouse leave handler
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
