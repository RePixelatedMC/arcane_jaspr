import 'package:jaspr/jaspr.dart';
import '../shared/shared.dart';

export '../shared/shared.dart' show ComponentSize, ColorVariant, StyleVariant;

/// Badge component properties.
class BadgeProps {
  final String label;
  final Component? icon;
  final ColorVariant color;
  final StyleVariant style;
  final ComponentSize size;

  const BadgeProps({
    required this.label,
    this.icon,
    this.color = ColorVariant.secondary,
    this.style = StyleVariant.solid,
    this.size = ComponentSize.md,
  });

  BadgeProps copyWith({
    String? label,
    Component? icon,
    ColorVariant? color,
    StyleVariant? style,
    ComponentSize? size,
  }) {
    return BadgeProps(
      label: label ?? this.label,
      icon: icon ?? this.icon,
      color: color ?? this.color,
      style: style ?? this.style,
      size: size ?? this.size,
    );
  }
}

// ============================================================================
// RENDERER CONTRACT
// ============================================================================

/// Mixin defining the renderer methods for badge components.
mixin BadgeRendererContract {
  /// Renders a badge component.
  Component badge(BadgeProps props);
}
