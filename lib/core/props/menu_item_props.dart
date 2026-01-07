import 'package:jaspr/jaspr.dart';

/// Unified menu item for dropdown menus, context menus, and menubars.
class ArcaneMenuItem {
  final String label;
  final Component? icon;
  final void Function()? onSelect;
  final String? href;
  final String? description;
  final bool disabled;
  final bool destructive;
  final String? shortcut;
  final List<ArcaneMenuItem>? submenu;
  final bool isSeparator;
  final bool isCheckbox;
  final bool checked;
  final String? radioGroup;
  final String? radioValue;

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
