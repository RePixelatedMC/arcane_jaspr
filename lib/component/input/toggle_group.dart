import 'package:jaspr/jaspr.dart';

import '../../core/theme_provider.dart';

export '../../core/props/toggle_group_props.dart'
    show
        ToggleGroupVariantStyle,
        ToggleGroupSizeVariant,
        ToggleGroupSelectionType,
        ToggleGroupItemProps,
        ToggleGroupProps;

/// Toggle group variants.
enum ToggleGroupVariant {
  defaultVariant,
  outline,
}

/// Toggle group size.
enum ToggleGroupSize {
  sm,
  md,
  lg,
}

/// Toggle group selection type.
enum ToggleGroupType {
  single,
  multiple,
}

/// A toggle group component for selecting one or multiple options.
class ArcaneToggleGroup extends StatelessComponent {
  final List<ToggleGroupItem> items;
  final String? value;
  final Set<String>? values;
  final void Function(String?)? onChanged;
  final void Function(Set<String>)? onMultiChanged;
  final ToggleGroupType type;
  final ToggleGroupVariant variant;
  final ToggleGroupSize size;
  final bool disabled;

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

/// A toggle group item.
class ToggleGroupItem {
  final String value;
  final Component child;
  final bool disabled;

  const ToggleGroupItem({
    required this.value,
    required this.child,
    this.disabled = false,
  });

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
