import 'package:jaspr/jaspr.dart';

/// Unified menu item for dropdown menus, context menus, and menubars.
///
/// This class combines all menu item features across different menu types:
/// - Basic: label, icon, onSelect, disabled
/// - Navigation: href (for link items)
/// - Visual: description, destructive styling
/// - Accessibility: shortcut hints
/// - Hierarchy: submenu for nested menus
/// - Toggles: checkbox/radio for stateful items
///
/// ```dart
/// ArcaneMenuItem(
///   label: 'Settings',
///   icon: ArcaneIcon.settings(),
///   shortcut: 'Ctrl+,',
///   onSelect: () => openSettings(),
/// )
/// ```
class ArcaneMenuItem {
  /// Display label for the item
  final String label;

  /// Optional icon component
  final Component? icon;

  /// Click/select handler
  final void Function()? onSelect;

  /// Optional navigation href (makes item a link)
  final String? href;

  /// Optional description text (shown below label)
  final String? description;

  /// Whether the item is disabled
  final bool disabled;

  /// Whether this is a destructive action (styled in red)
  final bool destructive;

  /// Keyboard shortcut hint (e.g., "Ctrl+C")
  final String? shortcut;

  /// Nested submenu items
  final List<ArcaneMenuItem>? submenu;

  /// Whether this item is a separator/divider
  final bool isSeparator;

  /// Whether this is a checkbox item
  final bool isCheckbox;

  /// Checkbox/radio checked state
  final bool checked;

  /// Radio group name (for mutually exclusive items)
  final String? radioGroup;

  /// Radio value within the group
  final String? radioValue;

  /// Creates a menu item.
  const ArcaneMenuItem({
    required this.label,
    this.icon,
    this.onSelect,
    this.href,
    this.description,
    this.disabled = false,
    this.destructive = false,
    this.shortcut,
    this.submenu,
    this.isSeparator = false,
    this.isCheckbox = false,
    this.checked = false,
    this.radioGroup,
    this.radioValue,
  });

  /// Creates a separator/divider item.
  const ArcaneMenuItem.separator()
      : label = '',
        icon = null,
        onSelect = null,
        href = null,
        description = null,
        disabled = false,
        destructive = false,
        shortcut = null,
        submenu = null,
        isSeparator = true,
        isCheckbox = false,
        checked = false,
        radioGroup = null,
        radioValue = null;

  /// Alias for separator()
  const ArcaneMenuItem.divider()
      : label = '',
        icon = null,
        onSelect = null,
        href = null,
        description = null,
        disabled = false,
        destructive = false,
        shortcut = null,
        submenu = null,
        isSeparator = true,
        isCheckbox = false,
        checked = false,
        radioGroup = null,
        radioValue = null;

  /// Creates a checkbox menu item.
  const ArcaneMenuItem.checkbox({
    required this.label,
    required this.checked,
    this.icon,
    this.onSelect,
    this.disabled = false,
    this.shortcut,
  })  : href = null,
        description = null,
        destructive = false,
        submenu = null,
        isSeparator = false,
        isCheckbox = true,
        radioGroup = null,
        radioValue = null;

  /// Creates a radio menu item.
  const ArcaneMenuItem.radio({
    required this.label,
    required String group,
    required String value,
    required this.checked,
    this.icon,
    this.onSelect,
    this.disabled = false,
  })  : href = null,
        description = null,
        destructive = false,
        shortcut = null,
        submenu = null,
        isSeparator = false,
        isCheckbox = false,
        radioGroup = group,
        radioValue = value;

  /// Creates a submenu item.
  const ArcaneMenuItem.submenu({
    required this.label,
    required List<ArcaneMenuItem> items,
    this.icon,
    this.disabled = false,
  })  : onSelect = null,
        href = null,
        description = null,
        destructive = false,
        shortcut = null,
        submenu = items,
        isSeparator = false,
        isCheckbox = false,
        checked = false,
        radioGroup = null,
        radioValue = null;
}
