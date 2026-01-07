import 'package:jaspr/jaspr.dart';
import 'menu_item_props.dart';

export 'menu_item_props.dart';

/// Props for the context menu component
class ContextMenuProps {
  /// The trigger element
  final Component trigger;

  /// Menu items
  final List<ArcaneMenuItem> items;

  const ContextMenuProps({
    required this.trigger,
    required this.items,
  });
}
