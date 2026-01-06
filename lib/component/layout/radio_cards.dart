import 'package:jaspr/jaspr.dart';

import '../../core/theme_provider.dart';

// Re-export from props for convenience
export '../../core/props/radio_cards_props.dart' show RadioCardItemData, SelectableChipGroupProps, ArcaneChipProps;

/// Type alias for backwards compatibility
typedef ArcaneRadioCardItem<T> = RadioCardItemData<T>;

/// A group of selectable cards where only one can be selected at a time.
class ArcaneRadioCards<T> extends StatelessComponent {
  /// The items to display
  final List<RadioCardItemData<T>> items;

  /// The currently selected value
  final T? value;

  /// Callback when selection changes
  final void Function(T value)? onChanged;

  /// Gap between cards
  final double gap;

  /// Whether to wrap cards
  final bool wrap;

  /// Card width (null for auto)
  final double? cardWidth;

  const ArcaneRadioCards({
    required this.items,
    this.value,
    this.onChanged,
    this.gap = 12,
    this.wrap = true,
    this.cardWidth,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return context.renderers.radioCards<T>(RadioCardsProps<T>(
      items: items,
      value: value,
      onChanged: onChanged,
      gap: gap,
      wrap: wrap,
      cardWidth: cardWidth,
    ));
  }
}

/// A group of selectable chips where multiple can be selected
class ArcaneChipGroup extends StatelessComponent {
  final List<Component> children;
  final double gap;
  final bool wrap;

  const ArcaneChipGroup({
    required this.children,
    this.gap = 8,
    this.wrap = true,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return context.renderers.selectableChipGroup(SelectableChipGroupProps(
      children: children,
      gap: gap,
      wrap: wrap,
    ));
  }
}

/// A single chip component
class ArcaneChip extends StatelessComponent {
  final String label;
  final Component? avatar;
  final Component? deleteIcon;
  final void Function()? onDeleted;
  final void Function()? onTap;
  final bool selected;
  final bool disabled;

  const ArcaneChip({
    required this.label,
    this.avatar,
    this.deleteIcon,
    this.onDeleted,
    this.onTap,
    this.selected = false,
    this.disabled = false,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return context.renderers.arcaneChip(ArcaneChipProps(
      label: label,
      avatar: avatar,
      deleteIcon: deleteIcon,
      onDeleted: onDeleted,
      onTap: onTap,
      selected: selected,
      disabled: disabled,
    ));
  }
}
