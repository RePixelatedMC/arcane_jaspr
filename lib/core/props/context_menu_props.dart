import 'package:arcane_jaspr/flutter.dart';
import 'package:jaspr/jaspr.dart' hide BuildContext, InheritedComponent, Key, State, StatefulComponent, StatelessComponent, UniqueKey, ValueKey, runApp;
import 'menu_item_props.dart';

export 'menu_item_props.dart';

/// Context menu component properties.
class ContextMenuProps {
  final Widget trigger;
  final List<ArcaneMenuItem> items;

  const ContextMenuProps({
    required this.trigger,
    required this.items,
  });
}

// ============================================================================
// RENDERER CONTRACT
// ============================================================================

/// Mixin defining the renderer methods for context menu components.
mixin ContextMenuRendererContract {
  Widget contextMenu(ContextMenuProps props);
}
