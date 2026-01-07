import 'menu_item_props.dart';

export 'menu_item_props.dart';

/// Props for a menubar menu (top-level dropdown)
class MenubarMenuProps {
  /// Trigger label
  final String label;

  /// Menu items
  final List<ArcaneMenuItem> items;

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
