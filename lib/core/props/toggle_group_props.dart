import 'package:jaspr/jaspr.dart';

enum ToggleGroupVariantStyle {
  defaultVariant,
  outline,
}

enum ToggleGroupSizeVariant {
  sm,
  md,
  lg,
}

enum ToggleGroupSelectionType {
  single,
  multiple,
}

/// Toggle group item data.
class ToggleGroupItemProps {
  final String value;
  final Component child;
  final bool disabled;

  const ToggleGroupItemProps({
    required this.value,
    required this.child,
    this.disabled = false,
  });
}

/// Toggle group component properties.
class ToggleGroupProps {
  final List<ToggleGroupItemProps> items;
  final String? value;
  final Set<String>? values;
  final ToggleGroupSelectionType type;
  final ToggleGroupVariantStyle variant;
  final ToggleGroupSizeVariant size;
  final bool disabled;
  final void Function(String?)? onChanged;
  final void Function(Set<String>)? onMultiChanged;

  const ToggleGroupProps({
    required this.items,
    this.value,
    this.values,
    this.type = ToggleGroupSelectionType.single,
    this.variant = ToggleGroupVariantStyle.defaultVariant,
    this.size = ToggleGroupSizeVariant.md,
    this.disabled = false,
    this.onChanged,
    this.onMultiChanged,
  });
}

// ============================================================================
// RENDERER CONTRACT
// ============================================================================

/// Mixin defining the renderer methods for toggle group components.
mixin ToggleGroupRendererContract {
  Component toggleGroup(ToggleGroupProps props);
}
