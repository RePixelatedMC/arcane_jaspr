import 'package:jaspr/jaspr.dart';

import '../../core/theme_provider.dart';

export '../../core/props/menubar_props.dart';

/// Horizontal menu bar component.
class ArcaneMenubar extends StatefulComponent {
  final List<ArcaneMenubarMenu> menus;

  const ArcaneMenubar({
    required this.menus,
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

  @override
  Component build(BuildContext context) {
    return context.renderers.menubar(MenubarProps(
      menus: component.menus
          .map((menu) => MenubarMenuProps(
                label: menu.label,
                items: menu.items,
              ))
          .toList(),
      openMenuIndex: _openMenuIndex,
      onMenuChange: _onMenuChange,
    ));
  }
}

/// Top-level menu in the menubar.
class ArcaneMenubarMenu {
  final String label;
  final List<ArcaneMenuItem> items;

  const ArcaneMenubarMenu({
    required this.label,
    required this.items,
  });
}
