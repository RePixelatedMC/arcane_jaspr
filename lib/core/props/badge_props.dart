import 'package:jaspr/jaspr.dart';

/// Badge style variants.
enum BadgeVariant {
  /// Default/standard badge
  standard,

  /// Primary/accent colored badge
  primary,

  /// Secondary/muted badge
  secondary,

  /// Success badge (green)
  success,

  /// Warning badge (amber)
  warning,

  /// Error/destructive badge (red)
  error,

  /// Info badge (blue)
  info,

  /// Outline badge
  outline,
}

/// Badge size variants.
enum BadgeSize {
  /// Small badge
  small,

  /// Medium badge (default)
  medium,

  /// Large badge
  large,
}

/// Properties for badge components.
class BadgeProps {
  /// The badge text
  final String label;

  /// Optional leading icon
  final Component? icon;

  /// Badge style variant
  final BadgeVariant variant;

  /// Badge size
  final BadgeSize size;

  const BadgeProps({
    required this.label,
    this.icon,
    this.variant = BadgeVariant.standard,
    this.size = BadgeSize.medium,
  });

  /// Create a copy with modified properties
  BadgeProps copyWith({
    String? label,
    Component? icon,
    BadgeVariant? variant,
    BadgeSize? size,
  }) {
    return BadgeProps(
      label: label ?? this.label,
      icon: icon ?? this.icon,
      variant: variant ?? this.variant,
      size: size ?? this.size,
    );
  }
}
