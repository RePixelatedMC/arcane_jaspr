import 'package:jaspr/jaspr.dart';

enum BadgeVariant {
  standard,
  primary,
  secondary,
  success,
  warning,
  error,
  info,
  outline,
}

enum BadgeSize {
  small,
  medium,
  large,
}

/// Badge component properties.
class BadgeProps {
  final String label;
  final Component? icon;
  final BadgeVariant variant;
  final BadgeSize size;

  const BadgeProps({
    required this.label,
    this.icon,
    this.variant = BadgeVariant.standard,
    this.size = BadgeSize.medium,
  });

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
