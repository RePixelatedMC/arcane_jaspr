import 'package:jaspr/jaspr.dart';

/// Chip size variants
enum ChipSize {
  small,
  medium,
  large,
}

/// Chip style variants
enum ChipVariant {
  standard,
  primary,
  secondary,
  success,
  warning,
  error,
  outline,
}

/// Props for chip components
class ChipProps {
  /// The label text
  final String label;

  /// Optional leading icon
  final Component? icon;

  /// Visual style variant
  final ChipVariant variant;

  /// Size variant
  final ChipSize size;

  /// Whether the chip can be removed
  final bool removable;

  /// Callback when remove button is clicked
  final void Function()? onRemove;

  /// Callback when chip is clicked
  final void Function()? onTap;

  const ChipProps({
    required this.label,
    this.icon,
    this.variant = ChipVariant.standard,
    this.size = ChipSize.medium,
    this.removable = false,
    this.onRemove,
    this.onTap,
  });
}

/// Props for chip group component
class ChipGroupProps {
  /// The chips to display
  final List<ChipProps> chips;

  /// Gap between chips
  final String? gap;

  const ChipGroupProps({
    required this.chips,
    this.gap,
  });
}
