import 'package:jaspr/jaspr.dart';

import '../../core/theme_provider.dart';

export '../../core/props/context_menu_props.dart';
export '../../core/props/menu_item_props.dart';

/// A context menu that appears on right-click matching shadcn/ui.
/// ShadCN Reference: https://ui.shadcn.com/docs/components/context-menu
///
/// Wrap any component with ArcaneContextMenu to add a right-click menu.
///
/// ```dart
/// ArcaneContextMenu(
///   trigger: ArcaneCard(child: content),
///   items: [
///     ArcaneMenuItem(label: 'Edit', onSelect: () => edit()),
///     ArcaneMenuItem(label: 'Copy', onSelect: () => copy()),
///     ArcaneMenuItem.separator(),
///     ArcaneMenuItem(label: 'Delete', onSelect: () => delete(), destructive: true),
///   ],
/// )
/// ```
class ArcaneContextMenu extends StatelessComponent {
  /// The element that triggers the context menu
  final Component trigger;

  /// Menu items
  final List<ArcaneMenuItem> items;

  const ArcaneContextMenu({
    required this.trigger,
    required this.items,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return context.renderers.contextMenu(ContextMenuProps(
      trigger: trigger,
      items: items,
    ));
  }
}
