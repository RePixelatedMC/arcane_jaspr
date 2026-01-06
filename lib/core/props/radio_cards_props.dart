import 'package:jaspr/jaspr.dart';

/// An item for radio cards
class RadioCardItemData<T> {
  final T value;
  final String? title;
  final String? subtitle;
  final Component? icon;
  final Component? child;
  final bool disabled;

  const RadioCardItemData({
    required this.value,
    this.title,
    this.subtitle,
    this.icon,
    this.child,
    this.disabled = false,
  });
}

/// Properties for radio cards components.
class RadioCardsProps<T> {
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

  const RadioCardsProps({
    required this.items,
    this.value,
    this.onChanged,
    this.gap = 12,
    this.wrap = true,
    this.cardWidth,
  });
}

/// Properties for selectable chip group components (distinct from ChipGroupProps).
class SelectableChipGroupProps {
  final List<Component> children;
  final double gap;
  final bool wrap;

  const SelectableChipGroupProps({
    required this.children,
    this.gap = 8,
    this.wrap = true,
  });
}

/// Properties for selectable chip components.
class ArcaneChipProps {
  final String label;
  final Component? avatar;
  final Component? deleteIcon;
  final void Function()? onDeleted;
  final void Function()? onTap;
  final bool selected;
  final bool disabled;

  const ArcaneChipProps({
    required this.label,
    this.avatar,
    this.deleteIcon,
    this.onDeleted,
    this.onTap,
    this.selected = false,
    this.disabled = false,
  });
}
