import 'package:jaspr/jaspr.dart';

/// Props for a menubar item
class MenubarItemProps {
  /// Display label
  final String label;

  /// Optional icon
  final Component? icon;

  /// Click handler
  final void Function()? onSelect;

  /// Whether disabled
  final bool disabled;

  /// Keyboard shortcut hint
  final String? shortcut;

  /// Whether this is a separator
  final bool isSeparator;

  /// Whether this is a checkbox item
  final bool isCheckbox;

  /// Checkbox checked state
  final bool checked;

  /// Radio group name (for radio items)
  final String? radioGroup;

  /// Radio value
  final String? radioValue;

  const MenubarItemProps({
    required this.label,
    this.icon,
    this.onSelect,
    this.disabled = false,
    this.shortcut,
    this.isSeparator = false,
    this.isCheckbox = false,
    this.checked = false,
    this.radioGroup,
    this.radioValue,
  });

  /// Creates a separator
  const MenubarItemProps.separator()
      : label = '',
        icon = null,
        onSelect = null,
        disabled = false,
        shortcut = null,
        isSeparator = true,
        isCheckbox = false,
        checked = false,
        radioGroup = null,
        radioValue = null;
}

/// Props for a menubar menu (top-level)
class MenubarMenuProps {
  /// Trigger label
  final String label;

  /// Menu items
  final List<MenubarItemProps> items;

  const MenubarMenuProps({
    required this.label,
    required this.items,
  });
}

/// Props for the menubar component
class MenubarProps {
  /// Menus in the bar
  final List<MenubarMenuProps> menus;

  /// Currently open menu index
  final int? openMenuIndex;

  /// Menu open handler
  final void Function(int? index)? onMenuChange;

  const MenubarProps({
    required this.menus,
    this.openMenuIndex,
    this.onMenuChange,
  });
}
