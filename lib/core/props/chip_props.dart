import 'package:jaspr/jaspr.dart';

enum ChipSize {
  small,
  medium,
  large,
}

enum ChipVariant {
  standard,
  primary,
  secondary,
  success,
  warning,
  error,
  outline,
}

/// Chip component properties.
class ChipProps {
  final String label;
  final Component? icon;
  final ChipVariant variant;
  final ChipSize size;
  final bool removable;
  final void Function()? onRemove;
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

/// Chip group component properties.
class ChipGroupProps {
  final List<ChipProps> chips;
  final String? gap;

  const ChipGroupProps({
    required this.chips,
    this.gap,
  });
}
