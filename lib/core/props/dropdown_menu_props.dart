import 'package:jaspr/jaspr.dart';
import 'menu_item_props.dart';

export 'menu_item_props.dart';

/// Dropdown menu alignment.
enum DropdownAlignment {
  left,
  right,
  center,
}

/// Properties for dropdown menu components.
class DropdownMenuProps {
  /// The trigger element that opens the dropdown
  final Component trigger;

  /// The menu items
  final List<ArcaneMenuItem> items;

  /// Whether the dropdown is currently open
  final bool isOpen;

  /// Callback to toggle open state
  final void Function()? onToggle;

  /// Callback to close the dropdown
  final void Function()? onClose;

  /// Alignment of the dropdown relative to trigger
  final DropdownAlignment alignment;

  /// Optional fixed width in pixels
  final double? width;

  const DropdownMenuProps({
    required this.trigger,
    required this.items,
    required this.isOpen,
    this.onToggle,
    this.onClose,
    this.alignment = DropdownAlignment.left,
    this.width,
  });

  /// Create a copy with modified properties
  DropdownMenuProps copyWith({
    Component? trigger,
    List<ArcaneMenuItem>? items,
    bool? isOpen,
    void Function()? onToggle,
    void Function()? onClose,
    DropdownAlignment? alignment,
    double? width,
  }) {
    return DropdownMenuProps(
      trigger: trigger ?? this.trigger,
      items: items ?? this.items,
      isOpen: isOpen ?? this.isOpen,
      onToggle: onToggle ?? this.onToggle,
      onClose: onClose ?? this.onClose,
      alignment: alignment ?? this.alignment,
      width: width ?? this.width,
    );
  }
}
