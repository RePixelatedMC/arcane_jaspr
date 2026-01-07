import 'package:jaspr/jaspr.dart';

import '../../core/theme_provider.dart';

export '../../core/props/context_menu_props.dart';
export '../../core/props/menu_item_props.dart';

/// Context menu that appears on right-click.
class ArcaneContextMenu extends StatelessComponent {
  final Component trigger;
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
