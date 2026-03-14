import 'package:arcane_jaspr/flutter.dart';
import 'package:jaspr/jaspr.dart' hide BuildContext, InheritedComponent, Key, State, StatefulComponent, StatelessComponent, UniqueKey, ValueKey, runApp;
import 'menu_item_props.dart';

export 'menu_item_props.dart';

enum DropdownAlignment {
  left,
  right,
  center,
}

/// Dropdown menu component properties.
class DropdownMenuProps {
  final Widget trigger;
  final List<ArcaneMenuItem> items;
  final bool isOpen;
  final void Function()? onToggle;
  final void Function()? onClose;
  final DropdownAlignment alignment;
  final double? width;

  const DropdownMenuProps({
    required this.trigger,
    required this.items,
    required this.isOpen,
    this.onToggle,
    this.onClose,
    this.alignment = DropdownAlignment.left,
    this.width,
  });

  DropdownMenuProps copyWith({
    Widget? trigger,
    List<ArcaneMenuItem>? items,
    bool? isOpen,
    void Function()? onToggle,
    void Function()? onClose,
    DropdownAlignment? alignment,
    double? width,
  }) {
    return DropdownMenuProps(
      trigger: trigger ?? this.trigger,
      items: items ?? this.items,
      isOpen: isOpen ?? this.isOpen,
      onToggle: onToggle ?? this.onToggle,
      onClose: onClose ?? this.onClose,
      alignment: alignment ?? this.alignment,
      width: width ?? this.width,
    );
  }
}

// ============================================================================
// RENDERER CONTRACT
// ============================================================================

/// Mixin defining the renderer methods for dropdown menu components.
mixin DropdownMenuRendererContract {
  Widget dropdownMenu(DropdownMenuProps props);
}
