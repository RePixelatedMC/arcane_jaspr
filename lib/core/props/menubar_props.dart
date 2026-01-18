import 'package:jaspr/jaspr.dart';

import 'menu_item_props.dart';

export 'menu_item_props.dart';

/// Menubar menu data.
class MenubarMenuProps {
  final String label;
  final List<ArcaneMenuItem> items;

  const MenubarMenuProps({
    required this.label,
    required this.items,
  });
}

/// Menubar component properties.
class MenubarProps {
  final List<MenubarMenuProps> menus;
  final int? openMenuIndex;
  final void Function(int? index)? onMenuChange;

  const MenubarProps({
    required this.menus,
    this.openMenuIndex,
    this.onMenuChange,
  });
}

// ============================================================================
// RENDERER CONTRACT
// ============================================================================

/// Mixin defining the renderer methods for menubar components.
mixin MenubarRendererContract {
  Component menubar(MenubarProps props);
}
