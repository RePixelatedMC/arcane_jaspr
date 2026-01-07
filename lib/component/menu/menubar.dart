import 'package:jaspr/jaspr.dart';

import '../../core/theme_provider.dart';

export '../../core/props/menubar_props.dart';

/// A horizontal menu bar like in desktop applications matching shadcn/ui.
/// ShadCN Reference: https://ui.shadcn.com/docs/components/menubar
///
/// ```dart
/// ArcaneMenubar(
///   menus: [
///     ArcaneMenubarMenu(
///       label: 'File',
///       items: [
///         ArcaneMenuItem(label: 'New', onSelect: () => newFile()),
///         ArcaneMenuItem(label: 'Open', shortcut: 'Cmd+O', onSelect: () => open()),
///         ArcaneMenuItem.separator(),
///         ArcaneMenuItem(label: 'Save', shortcut: 'Cmd+S', onSelect: () => save()),
///       ],
///     ),
///     ArcaneMenubarMenu(
///       label: 'Edit',
///       items: [
///         ArcaneMenuItem(label: 'Undo', shortcut: 'Cmd+Z', onSelect: () => undo()),
///         ArcaneMenuItem(label: 'Redo', shortcut: 'Shift+Cmd+Z', onSelect: () => redo()),
///       ],
///     ),
///   ],
/// )
/// ```
class ArcaneMenubar extends StatefulComponent {
  /// Menu definitions
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

/// A top-level menu in the menubar
class ArcaneMenubarMenu {
  /// Display label for this menu
  final String label;

  /// Menu items in this dropdown
  final List<ArcaneMenuItem> items;

  const ArcaneMenubarMenu({
    required this.label,
    required this.items,
  });
}
