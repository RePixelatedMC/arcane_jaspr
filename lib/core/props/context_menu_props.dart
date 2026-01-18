import 'package:jaspr/jaspr.dart';
import 'menu_item_props.dart';

export 'menu_item_props.dart';

/// Context menu component properties.
class ContextMenuProps {
  final Component trigger;
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
  Component contextMenu(ContextMenuProps props);
}
