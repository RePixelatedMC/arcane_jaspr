import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../core/theme_provider.dart';

export '../../core/props/chip_props.dart' show ChipSize, ChipVariant;

/// Chip/tag component for labels and filters
///
/// ```dart
/// ArcaneChip(
///   label: 'Active',
///   variant: ChipVariant.success,
/// )
/// ```
class ArcaneChip extends StatelessComponent {
  final String label;
  final Component? icon;
  final ChipVariant variant;
  final ChipSize size;
  final bool removable;
  final void Function()? onRemove;
  final void Function()? onTap;

  const ArcaneChip({
    required this.label,
    this.icon,
    this.variant = ChipVariant.standard,
    this.size = ChipSize.medium,
    this.removable = false,
    this.onRemove,
    this.onTap,
    super.key,
  });

  /// Primary chip
  const ArcaneChip.primary({
    required this.label,
    this.icon,
    this.size = ChipSize.medium,
    this.removable = false,
    this.onRemove,
    this.onTap,
    super.key,
  }) : variant = ChipVariant.primary;

  /// Success chip
  const ArcaneChip.success({
    required this.label,
    this.icon,
    this.size = ChipSize.medium,
    this.removable = false,
    this.onRemove,
    this.onTap,
    super.key,
  }) : variant = ChipVariant.success;

  /// Warning chip
  const ArcaneChip.warning({
    required this.label,
    this.icon,
    this.size = ChipSize.medium,
    this.removable = false,
    this.onRemove,
    this.onTap,
    super.key,
  }) : variant = ChipVariant.warning;

  /// Error chip
  const ArcaneChip.error({
    required this.label,
    this.icon,
    this.size = ChipSize.medium,
    this.removable = false,
    this.onRemove,
    this.onTap,
    super.key,
  }) : variant = ChipVariant.error;

  /// Outline chip
  const ArcaneChip.outline({
    required this.label,
    this.icon,
    this.size = ChipSize.medium,
    this.removable = false,
    this.onRemove,
    this.onTap,
    super.key,
  }) : variant = ChipVariant.outline;

  @override
  Component build(BuildContext context) {
    return context.renderers.chip(ChipProps(
      label: label,
      icon: icon,
      variant: variant,
      size: size,
      removable: removable,
      onRemove: onRemove,
      onTap: onTap,
    ));
  }
}

/// Chip group for multiple chips
///
/// Accepts either [ArcaneChip] widgets or [ChipProps] for rendering.
class ArcaneChipGroup extends StatelessComponent {
  final List<Component>? _chips;
  final List<ChipProps>? _chipProps;
  final String? gap;

  /// Create a chip group from ArcaneChip widgets
  const ArcaneChipGroup({
    required List<Component> chips,
    this.gap,
    super.key,
  })  : _chips = chips,
        _chipProps = null;

  /// Create a chip group from ChipProps
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

    // Render chip widgets directly in a flex container
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
