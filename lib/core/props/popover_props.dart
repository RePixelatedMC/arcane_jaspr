import 'package:jaspr/jaspr.dart';

/// Popover position relative to the trigger element.
enum PopoverPosition {
  /// Above the trigger (centered)
  top,

  /// Below the trigger (centered)
  bottom,

  /// To the left of the trigger
  left,

  /// To the right of the trigger
  right,

  /// Above and to the start (left in LTR)
  topStart,

  /// Above and to the end (right in LTR)
  topEnd,

  /// Below and to the start
  bottomStart,

  /// Below and to the end
  bottomEnd,
}

/// Popover trigger behavior.
enum PopoverTrigger {
  /// Trigger on click
  click,

  /// Trigger on hover
  hover,

  /// Manual control only
  manual,
}

/// Properties for popover components.
class PopoverProps {
  /// The trigger element that opens the popover
  final Component trigger;

  /// The content to show in the popover
  final Component content;

  /// Whether the popover is currently open
  final bool isOpen;

  /// Position relative to the trigger
  final PopoverPosition position;

  /// Trigger behavior type
  final PopoverTrigger triggerType;

  /// Callback for toggle action (click trigger)
  final void Function()? onToggle;

  /// Callback when mouse enters trigger (hover trigger)
  final void Function()? onMouseEnter;

  /// Callback when mouse leaves trigger (hover trigger)
  final void Function()? onMouseLeave;

  /// Whether to show the arrow
  final bool showArrow;

  /// Offset from trigger in pixels
  final int offset;

  const PopoverProps({
    required this.trigger,
    required this.content,
    required this.isOpen,
    this.position = PopoverPosition.bottom,
    this.triggerType = PopoverTrigger.click,
    this.onToggle,
    this.onMouseEnter,
    this.onMouseLeave,
    this.showArrow = true,
    this.offset = 8,
  });

  /// Create a copy with modified properties
  PopoverProps copyWith({
    Component? trigger,
    Component? content,
    bool? isOpen,
    PopoverPosition? position,
    PopoverTrigger? triggerType,
    void Function()? onToggle,
    void Function()? onMouseEnter,
    void Function()? onMouseLeave,
    bool? showArrow,
    int? offset,
  }) {
    return PopoverProps(
      trigger: trigger ?? this.trigger,
      content: content ?? this.content,
      isOpen: isOpen ?? this.isOpen,
      position: position ?? this.position,
      triggerType: triggerType ?? this.triggerType,
      onToggle: onToggle ?? this.onToggle,
      onMouseEnter: onMouseEnter ?? this.onMouseEnter,
      onMouseLeave: onMouseLeave ?? this.onMouseLeave,
      showArrow: showArrow ?? this.showArrow,
      offset: offset ?? this.offset,
    );
  }
}
