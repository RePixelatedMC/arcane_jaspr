import 'package:arcane_jaspr/flutter.dart';
import 'package:jaspr/jaspr.dart' hide BuildContext, InheritedComponent, Key, State, StatefulComponent, StatelessComponent, UniqueKey, ValueKey, runApp;

import '../../core/theme_provider.dart';

export '../../core/props/context_menu_props.dart';
export '../../core/props/menu_item_props.dart';

/// Context menu that appears on right-click.
class ArcaneContextMenu extends StatelessWidget {
  final Widget trigger;
  final List<ArcaneMenuItem> items;

  const ArcaneContextMenu({
    required this.trigger,
    required this.items,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return context.renderers.contextMenu(ContextMenuProps(
      trigger: trigger,
      items: items,
    ));
  }
}
