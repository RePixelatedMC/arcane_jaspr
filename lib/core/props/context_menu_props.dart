import 'package:jaspr/jaspr.dart';

/// Props for a context menu item
class ContextMenuItemProps {
  /// Display label
  final String label;

  /// Optional icon
  final Component? icon;

  /// Select handler
  final void Function()? onSelect;

  /// Whether destructive action
  final bool destructive;

  /// Whether disabled
  final bool disabled;

  /// Keyboard shortcut hint
  final String? shortcut;

  /// Submenu items
  final List<ContextMenuItemProps>? submenu;

  /// Whether this is a separator
  final bool isSeparator;

  const ContextMenuItemProps({
    required this.label,
    this.icon,
    this.onSelect,
    this.destructive = false,
    this.disabled = false,
    this.shortcut,
    this.submenu,
    this.isSeparator = false,
  });

  /// Creates a separator
  const ContextMenuItemProps.separator()
      : label = '',
        icon = null,
        onSelect = null,
        destructive = false,
        disabled = false,
        shortcut = null,
        submenu = null,
        isSeparator = true;
}

/// Props for the context menu component
class ContextMenuProps {
  /// The trigger element
  final Component trigger;

  /// Menu items
  final List<ContextMenuItemProps> items;

  const ContextMenuProps({
    required this.trigger,
    required this.items,
  });
}
