import 'package:jaspr/jaspr.dart';
import '../shared/shared.dart';

export '../shared/shared.dart' show ComponentSize, ColorVariant, StyleVariant;

/// Chip component properties.
class ChipProps {
  final String label;
  final Component? icon;
  final ColorVariant color;
  final StyleVariant style;
  final ComponentSize size;
  final bool removable;
  final void Function()? onRemove;
  final void Function()? onTap;

  const ChipProps({
    required this.label,
    this.icon,
    this.color = ColorVariant.secondary,
    this.style = StyleVariant.solid,
    this.size = ComponentSize.md,
    this.removable = false,
    this.onRemove,
    this.onTap,
  });
}

/// Chip group component properties.
class ChipGroupProps {
  final List<ChipProps> chips;
  final String? gap;

  const ChipGroupProps({
    required this.chips,
    this.gap,
  });
}

// ============================================================================
// RENDERER CONTRACT
// ============================================================================

/// Mixin defining the renderer methods for chip components.
mixin ChipRendererContract {
  /// Renders a chip component.
  Component chip(ChipProps props);

  /// Renders a group of chips.
  Component chipGroup(ChipGroupProps props);
}
