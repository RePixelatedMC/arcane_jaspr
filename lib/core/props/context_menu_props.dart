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
