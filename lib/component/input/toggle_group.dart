import 'package:jaspr/jaspr.dart';

import '../../core/theme_provider.dart';

// Re-export props for backwards compatibility
export '../../core/props/toggle_group_props.dart'
    show
        ToggleGroupVariantStyle,
        ToggleGroupSizeVariant,
        ToggleGroupSelectionType,
        ToggleGroupItemProps,
        ToggleGroupProps;

/// Toggle group variants matching shadcn/ui
/// Reference: https://ui.shadcn.com/docs/components/toggle-group
enum ToggleGroupVariant {
  /// Default - transparent bg, accent when selected
  defaultVariant,

  /// Outline - with border
  outline,
}

/// Toggle group size
enum ToggleGroupSize {
  /// Small - h-9 (36px)
  sm,

  /// Default - h-10 (40px)
  md,

  /// Large - h-11 (44px)
  lg,
}

/// Toggle group type
enum ToggleGroupType {
  /// Only one item can be selected at a time
  single,

  /// Multiple items can be selected
  multiple,
}

/// A toggle group component matching shadcn/ui
/// Reference: https://ui.shadcn.com/docs/components/toggle-group
///
/// Example:
/// ```dart
/// // Single selection
/// ArcaneToggleGroup(
///   items: [
///     ToggleGroupItem(value: 'left', child: Icon(Icons.alignLeft)),
///     ToggleGroupItem(value: 'center', child: Icon(Icons.alignCenter)),
///     ToggleGroupItem(value: 'right', child: Icon(Icons.alignRight)),
///   ],
///   value: 'center',
///   onChanged: (value) => print(value),
/// )
///
/// // Multiple selection
/// ArcaneToggleGroup.multiple(
///   items: [...],
///   values: {'bold', 'italic'},
///   onChanged: (values) => print(values),
/// )
/// ```
class ArcaneToggleGroup extends StatelessComponent {
  /// The toggle items
  final List<ToggleGroupItem> items;

  /// Current value (for single selection)
  final String? value;

  /// Current values (for multiple selection)
  final Set<String>? values;

  /// Callback when value changes (single)
  final void Function(String?)? onChanged;

  /// Callback when values change (multiple)
  final void Function(Set<String>)? onMultiChanged;

  /// Selection type
  final ToggleGroupType type;

  /// Visual variant
  final ToggleGroupVariant variant;

  /// Size
  final ToggleGroupSize size;

  /// Whether the group is disabled
  final bool disabled;

  /// Creates a single-selection toggle group
  const ArcaneToggleGroup({
    required this.items,
    this.value,
    this.onChanged,
    this.variant = ToggleGroupVariant.defaultVariant,
    this.size = ToggleGroupSize.md,
    this.disabled = false,
    super.key,
  })  : type = ToggleGroupType.single,
        values = null,
        onMultiChanged = null;

  /// Creates a multiple-selection toggle group
  const ArcaneToggleGroup.multiple({
    required this.items,
    this.values,
    this.onMultiChanged,
    this.variant = ToggleGroupVariant.defaultVariant,
    this.size = ToggleGroupSize.md,
    this.disabled = false,
    super.key,
  })  : type = ToggleGroupType.multiple,
        value = null,
        onChanged = null;

  ToggleGroupVariantStyle get _propsVariant => switch (variant) {
        ToggleGroupVariant.defaultVariant =>
          ToggleGroupVariantStyle.defaultVariant,
        ToggleGroupVariant.outline => ToggleGroupVariantStyle.outline,
      };

  ToggleGroupSizeVariant get _propsSize => switch (size) {
        ToggleGroupSize.sm => ToggleGroupSizeVariant.sm,
        ToggleGroupSize.md => ToggleGroupSizeVariant.md,
        ToggleGroupSize.lg => ToggleGroupSizeVariant.lg,
      };

  ToggleGroupSelectionType get _propsType => switch (type) {
        ToggleGroupType.single => ToggleGroupSelectionType.single,
        ToggleGroupType.multiple => ToggleGroupSelectionType.multiple,
      };

  @override
  Component build(BuildContext context) {
    return context.renderers.toggleGroup(ToggleGroupProps(
      items: items
          .map((item) => ToggleGroupItemProps(
                value: item.value,
                child: item.child,
                disabled: item.disabled,
              ))
          .toList(),
      value: value,
      values: values,
      type: _propsType,
      variant: _propsVariant,
      size: _propsSize,
      disabled: disabled,
      onChanged: onChanged,
      onMultiChanged: onMultiChanged,
    ));
  }
}

/// A toggle group item
class ToggleGroupItem {
  /// The value identifier
  final String value;

  /// The child component to display
  final Component child;

  /// Whether this item is disabled
  final bool disabled;

  const ToggleGroupItem({
    required this.value,
    required this.child,
    this.disabled = false,
  });

  /// Convenience constructor for text items
  factory ToggleGroupItem.text(
    String value, {
    String? label,
    bool disabled = false,
  }) {
    return ToggleGroupItem(
      value: value,
      disabled: disabled,
      child: Component.text(label ?? value),
    );
  }
}
