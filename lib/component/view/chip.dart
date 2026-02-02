import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../core/theme_provider.dart';

export '../../core/props/chip_props.dart'
    show ComponentSize, ColorVariant, StyleVariant;

/// Chip/tag component for labels and filters.
class ArcaneChip extends StatelessComponent {
  final String label;
  final Component? icon;
  final ColorVariant color;
  final StyleVariant style;
  final ComponentSize size;
  final bool removable;
  final void Function()? onRemove;
  final void Function()? onTap;

  const ArcaneChip({
    required this.label,
    this.icon,
    this.color = ColorVariant.secondary,
    this.style = StyleVariant.solid,
    this.size = ComponentSize.md,
    this.removable = false,
    this.onRemove,
    this.onTap,
    super.key,
  });

  const ArcaneChip.primary({
    required this.label,
    this.icon,
    this.style = StyleVariant.solid,
    this.size = ComponentSize.md,
    this.removable = false,
    this.onRemove,
    this.onTap,
    super.key,
  }) : color = ColorVariant.primary;

  const ArcaneChip.success({
    required this.label,
    this.icon,
    this.style = StyleVariant.solid,
    this.size = ComponentSize.md,
    this.removable = false,
    this.onRemove,
    this.onTap,
    super.key,
  }) : color = ColorVariant.success;

  const ArcaneChip.warning({
    required this.label,
    this.icon,
    this.style = StyleVariant.solid,
    this.size = ComponentSize.md,
    this.removable = false,
    this.onRemove,
    this.onTap,
    super.key,
  }) : color = ColorVariant.warning;

  const ArcaneChip.destructive({
    required this.label,
    this.icon,
    this.style = StyleVariant.solid,
    this.size = ComponentSize.md,
    this.removable = false,
    this.onRemove,
    this.onTap,
    super.key,
  }) : color = ColorVariant.destructive;

  const ArcaneChip.outline({
    required this.label,
    this.icon,
    this.color = ColorVariant.secondary,
    this.size = ComponentSize.md,
    this.removable = false,
    this.onRemove,
    this.onTap,
    super.key,
  }) : style = StyleVariant.outline;

  /// Creates a soft/subtle chip with muted background and border.
  /// Ideal for display tags like "Pre-installed" or "Included".
  const ArcaneChip.soft({
    required this.label,
    this.icon,
    this.size = ComponentSize.md,
    this.removable = false,
    this.onRemove,
    this.onTap,
    super.key,
  })  : style = StyleVariant.soft,
        color = ColorVariant.secondary;

  @override
  Component build(BuildContext context) {
    return context.renderers.chip(ChipProps(
      label: label,
      icon: icon,
      color: color,
      style: style,
      size: size,
      removable: removable,
      onRemove: onRemove,
      onTap: onTap,
    ));
  }
}

/// Chip group for multiple chips.
class ArcaneChipGroup extends StatelessComponent {
  final List<Component>? _chips;
  final List<ChipProps>? _chipProps;
  final String? gap;

  const ArcaneChipGroup({
    required List<Component> chips,
    this.gap,
    super.key,
  })  : _chips = chips,
        _chipProps = null;

  const ArcaneChipGroup.fromProps({
    required List<ChipProps> chips,
    this.gap,
    super.key,
  })  : _chips = null,
        _chipProps = chips;

  @override
  Component build(BuildContext context) {
    if (_chipProps != null) {
      return context.renderers.chipGroup(ChipGroupProps(
        chips: _chipProps,
        gap: gap,
      ));
    }

    return dom.div(
      classes: 'arcane-chip-group',
      styles: dom.Styles(raw: {
        'display': 'flex',
        'flex-wrap': 'wrap',
        'gap': gap ?? '0.5rem',
      }),
      _chips!,
    );
  }
}
