import 'package:jaspr/jaspr.dart';

/// Dropdown menu alignment.
enum DropdownAlignment {
  left,
  right,
  center,
}

/// A dropdown menu item.
class DropdownItemProps {
  /// Display label
  final String label;

  /// Optional link href
  final String? href;

  /// Click handler
  final void Function()? onTap;

  /// Optional icon
  final Component? icon;

  /// Optional description text
  final String? description;

  /// Whether the item is disabled
  final bool disabled;

  /// Whether this is a divider (separator)
  final bool divider;

  const DropdownItemProps({
    required this.label,
    this.href,
    this.onTap,
    this.icon,
    this.description,
    this.disabled = false,
    this.divider = false,
  });

  /// Create a divider item
  const DropdownItemProps.divider()
      : label = '',
        href = null,
        onTap = null,
        icon = null,
        description = null,
        disabled = false,
        divider = true;
}

/// Properties for dropdown menu components.
class DropdownMenuProps {
  /// The trigger element that opens the dropdown
  final Component trigger;

  /// The menu items
  final List<DropdownItemProps> items;

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
    List<DropdownItemProps>? items,
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
