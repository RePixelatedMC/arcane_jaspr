import 'package:arcane_jaspr/flutter.dart';
import 'menu_item_props.dart';

export 'menu_item_props.dart';

/// Context menu component properties.
class ContextMenuProps {
  final String id;
  final Widget trigger;
  final List<ArcaneMenuItem> items;
  final bool keepOpenOnAction;

  const ContextMenuProps({
    required this.id,
    required this.trigger,
    required this.items,
    this.keepOpenOnAction = false,
  });
}

// ============================================================================
// RENDERER CONTRACT
// ============================================================================

/// Mixin defining the renderer methods for context menu components.
mixin ContextMenuRendererContract {
  Widget contextMenu(ContextMenuProps props);
}
