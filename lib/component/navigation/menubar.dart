import 'package:jaspr/jaspr.dart';

import '../../core/theme_provider.dart';

export '../../core/props/menubar_props.dart'
    show MenubarItemProps, MenubarMenuProps, MenubarProps;

/// A horizontal menu bar like in desktop applications matching shadcn/ui.
/// ShadCN Reference: https://ui.shadcn.com/docs/components/menubar
///
/// ```dart
/// ArcaneMenubar(
///   items: [
///     MenubarItem(
///       label: 'File',
///       menu: [
///         MenuItem(label: 'New', onSelect: () => newFile()),
///         MenuItem(label: 'Open', shortcut: 'Cmd+O', onSelect: () => open()),
///         MenuItem.separator(),
///         MenuItem(label: 'Save', shortcut: 'Cmd+S', onSelect: () => save()),
///       ],
///     ),
///     MenubarItem(
///       label: 'Edit',
///       menu: [
///         MenuItem(label: 'Undo', shortcut: 'Cmd+Z', onSelect: () => undo()),
///         MenuItem(label: 'Redo', shortcut: 'Shift+Cmd+Z', onSelect: () => redo()),
///       ],
///     ),
///   ],
/// )
/// ```
class ArcaneMenubar extends StatefulComponent {
  /// Menu items
  final List<MenubarItem> items;

  const ArcaneMenubar({
    required this.items,
    super.key,
  });

  @override
  State<ArcaneMenubar> createState() => _ArcaneMenubarState();
}

class _ArcaneMenubarState extends State<ArcaneMenubar> {
  int? _openMenuIndex;

  void _onMenuChange(int? index) {
    setState(() {
      _openMenuIndex = index;
    });
  }

  List<MenubarItemProps> _convertMenuItems(List<MenuItem> items) {
    return items.map((item) {
      if (item.isSeparator) {
        return const MenubarItemProps.separator();
      }
      return MenubarItemProps(
        label: item.label,
        icon: item.icon,
        onSelect: item.onSelect,
        disabled: item.disabled,
        shortcut: item.shortcut,
      );
    }).toList();
  }

  @override
  Component build(BuildContext context) {
    return context.renderers.menubar(MenubarProps(
      menus: component.items
          .map((item) => MenubarMenuProps(
                label: item.label,
                items: _convertMenuItems(item.menu),
              ))
          .toList(),
      openMenuIndex: _openMenuIndex,
      onMenuChange: _onMenuChange,
    ));
  }
}

/// A menubar top-level item
class MenubarItem {
  /// Display label
  final String label;

  /// Optional icon
  final Component? icon;

  /// Dropdown menu items
  final List<MenuItem> menu;

  const MenubarItem({
    required this.label,
    required this.menu,
    this.icon,
  });
}

/// A menu item in a menubar dropdown
class MenuItem {
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

  /// Keyboard shortcut hint
  final String? shortcut;

  /// Submenu items
  final List<MenuItem>? submenu;

  /// Whether this is a separator
  final bool isSeparator;

  const MenuItem({
    required this.label,
    this.icon,
    this.onSelect,
    this.destructive = false,
    this.disabled = false,
    this.shortcut,
    this.submenu,
  }) : isSeparator = false;

  /// Creates a separator item
  const MenuItem.separator()
      : label = '',
        icon = null,
        onSelect = null,
        destructive = false,
        disabled = false,
        shortcut = null,
        submenu = null,
        isSeparator = true;
}
