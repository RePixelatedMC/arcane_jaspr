import 'package:jaspr/jaspr.dart';

import '../../core/theme_provider.dart';

// Re-export props for backwards compatibility
export '../../core/props/context_menu_props.dart'
    show ContextMenuItemProps, ContextMenuProps;

/// A context menu that appears on right-click matching shadcn/ui.
/// ShadCN Reference: https://ui.shadcn.com/docs/components/context-menu
///
/// Wrap any component with ArcaneContextMenu to add a right-click menu.
///
/// ```dart
/// ArcaneContextMenu(
///   trigger: ArcaneCard(child: content),
///   items: [
///     ContextMenuItem(label: 'Edit', onSelect: () => edit()),
///     ContextMenuItem(label: 'Copy', onSelect: () => copy()),
///     ContextMenuItem.separator(),
///     ContextMenuItem(label: 'Delete', onSelect: () => delete(), destructive: true),
///   ],
/// )
/// ```
class ArcaneContextMenu extends StatelessComponent {
  /// The element that triggers the context menu
  final Component trigger;

  /// Menu items
  final List<ContextMenuItem> items;

  const ArcaneContextMenu({
    required this.trigger,
    required this.items,
    super.key,
  });

  List<ContextMenuItemProps> _convertItems(List<ContextMenuItem> items) {
    return items.map((item) {
      if (item.isSeparator) {
        return const ContextMenuItemProps.separator();
      }
      return ContextMenuItemProps(
        label: item.label,
        icon: item.icon,
        onSelect: item.onSelect,
        destructive: item.destructive,
        disabled: item.disabled,
        shortcut: item.shortcut,
        submenu:
            item.submenu != null ? _convertItems(item.submenu!) : null,
      );
    }).toList();
  }

  @override
  Component build(BuildContext context) {
    return context.renderers.contextMenu(ContextMenuProps(
      trigger: trigger,
      items: _convertItems(items),
    ));
  }
}

/// A context menu item
class ContextMenuItem {
  /// Display label
  final String label;

  /// Optional icon
  final Component? icon;

  /// Called when item is selected
  final void Function()? onSelect;

  /// Whether this is a destructive action
  final bool destructive;

  /// Whether this item is disabled
  final bool disabled;

  /// Keyboard shortcut hint (e.g., "Cmd+C")
  final String? shortcut;

  /// Submenu items
  final List<ContextMenuItem>? submenu;

  /// Whether this is a separator
  final bool isSeparator;

  const ContextMenuItem({
    required this.label,
    this.icon,
    this.onSelect,
    this.destructive = false,
    this.disabled = false,
    this.shortcut,
    this.submenu,
  }) : isSeparator = false;

  /// Creates a separator item
  const ContextMenuItem.separator()
      : label = '',
        icon = null,
        onSelect = null,
        destructive = false,
        disabled = false,
        shortcut = null,
        submenu = null,
        isSeparator = true;
}
