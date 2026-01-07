import 'package:jaspr/jaspr.dart';

enum PopoverPosition {
  top,
  bottom,
  left,
  right,
  topStart,
  topEnd,
  bottomStart,
  bottomEnd,
}

enum PopoverTrigger {
  click,
  hover,
  manual,
}

/// Popover component properties.
class PopoverProps {
  final Component trigger;
  final Component content;
  final bool isOpen;
  final PopoverPosition position;
  final PopoverTrigger triggerType;
  final void Function()? onToggle;
  final void Function()? onMouseEnter;
  final void Function()? onMouseLeave;
  final bool showArrow;
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
