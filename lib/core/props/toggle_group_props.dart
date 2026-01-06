import 'package:jaspr/jaspr.dart';

/// Toggle group variant
enum ToggleGroupVariantStyle {
  /// Default - transparent bg, accent when selected
  defaultVariant,

  /// Outline - with border
  outline,
}

/// Toggle group size
enum ToggleGroupSizeVariant {
  sm,
  md,
  lg,
}

/// Toggle group selection type
enum ToggleGroupSelectionType {
  single,
  multiple,
}

/// Props for a toggle group item
class ToggleGroupItemProps {
  /// Value identifier
  final String value;

  /// Child component to display
  final Component child;

  /// Whether disabled
  final bool disabled;

  const ToggleGroupItemProps({
    required this.value,
    required this.child,
    this.disabled = false,
  });
}

/// Props for the toggle group component
class ToggleGroupProps {
  /// Items in the group
  final List<ToggleGroupItemProps> items;

  /// Current value (single)
  final String? value;

  /// Current values (multiple)
  final Set<String>? values;

  /// Selection type
  final ToggleGroupSelectionType type;

  /// Visual variant
  final ToggleGroupVariantStyle variant;

  /// Size
  final ToggleGroupSizeVariant size;

  /// Whether disabled
  final bool disabled;

  /// Value change handler (single)
  final void Function(String?)? onChanged;

  /// Value change handler (multiple)
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
