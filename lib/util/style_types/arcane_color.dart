/// Semantic color values that map to theme CSS custom properties.
///
/// Use these colors for type-safe color references that automatically
/// adapt to the current theme.
enum ArcaneColor {
  // Primary colors
  primary,
  primaryForeground,
  secondary,
  secondaryForeground,
  accent,
  accentForeground,

  // Semantic colors
  success,
  successForeground,
  warning,
  warningForeground,
  error,
  errorForeground,
  info,
  infoForeground,
  destructive,
  destructiveForeground,

  // Surface colors
  background,
  foreground,
  card,
  cardForeground,
  muted,
  mutedForeground,
  border,

  // Special colors
  ring,
  input,
  popover,
  popoverForeground;

  /// Returns the CSS variable reference for this color.
  String get css => switch (this) {
        ArcaneColor.primary => 'var(--primary)',
        ArcaneColor.primaryForeground => 'var(--primary-foreground)',
        ArcaneColor.secondary => 'var(--secondary)',
        ArcaneColor.secondaryForeground => 'var(--secondary-foreground)',
        ArcaneColor.accent => 'var(--accent)',
        ArcaneColor.accentForeground => 'var(--accent-foreground)',
        ArcaneColor.success => 'var(--success)',
        ArcaneColor.successForeground => 'var(--success-foreground)',
        ArcaneColor.warning => 'var(--warning)',
        ArcaneColor.warningForeground => 'var(--warning-foreground)',
        ArcaneColor.error => 'var(--destructive)',
        ArcaneColor.errorForeground => 'var(--destructive-foreground)',
        ArcaneColor.info => 'var(--info)',
        ArcaneColor.infoForeground => 'var(--info-foreground)',
        ArcaneColor.destructive => 'var(--destructive)',
        ArcaneColor.destructiveForeground => 'var(--destructive-foreground)',
        ArcaneColor.background => 'var(--background)',
        ArcaneColor.foreground => 'var(--foreground)',
        ArcaneColor.card => 'var(--card)',
        ArcaneColor.cardForeground => 'var(--card-foreground)',
        ArcaneColor.muted => 'var(--muted)',
        ArcaneColor.mutedForeground => 'var(--muted-foreground)',
        ArcaneColor.border => 'var(--border)',
        ArcaneColor.ring => 'var(--ring)',
        ArcaneColor.input => 'var(--input)',
        ArcaneColor.popover => 'var(--popover)',
        ArcaneColor.popoverForeground => 'var(--popover-foreground)',
      };

  /// Returns the color with opacity using color-mix.
  String withOpacity(double opacity) {
    final percent = (opacity * 100).round();
    return 'color-mix(in srgb, $css $percent%, transparent)';
  }
}

/// A color stop in a gradient, supporting both ArcaneColor and raw CSS values.
class GradientStop {
  /// The color value - either an ArcaneColor or raw CSS string.
  final String color;

  /// Position in the gradient (0.0 to 1.0). If null, evenly distributed.
  final double? position;

  const GradientStop._(this.color, this.position);

  /// Create a gradient stop from an ArcaneColor.
  const GradientStop.arcane(ArcaneColor arcaneColor, [this.position])
      : color = '';

  /// Create a gradient stop from an ArcaneColor (runtime).
  factory GradientStop.fromArcane(ArcaneColor arcaneColor, [double? position]) {
    return GradientStop._(arcaneColor.css, position);
  }

  /// Create a gradient stop from a raw CSS color value.
  const GradientStop.raw(this.color, [this.position]);

  /// Create a gradient stop from a hex color.
  const GradientStop.hex(String hexColor, [this.position]) : color = hexColor;

  /// Returns the CSS representation of this stop.
  String get css {
    if (position != null) {
      return '$color ${(position! * 100).round()}%';
    }
    return color;
  }
}

/// Builds a CSS linear-gradient from a list of colors.
class GradientBuilder {
  final List<GradientStop> _stops = [];
  String _angle = '135deg';

  /// Set the gradient angle.
  GradientBuilder angle(String angle) {
    _angle = angle;
    return this;
  }

  /// Add a color stop using an ArcaneColor.
  GradientBuilder add(ArcaneColor color, [double? position]) {
    _stops.add(GradientStop.fromArcane(color, position));
    return this;
  }

  /// Add a color stop using a raw CSS value.
  GradientBuilder addRaw(String color, [double? position]) {
    _stops.add(GradientStop.raw(color, position));
    return this;
  }

  /// Add a color stop using a hex value.
  GradientBuilder addHex(String hex, [double? position]) {
    _stops.add(GradientStop.hex(hex, position));
    return this;
  }

  /// Build the CSS gradient string.
  String build() {
    if (_stops.isEmpty) {
      return 'linear-gradient($_angle, var(--primary), var(--accent))';
    }

    final stopStrings = <String>[];
    for (var i = 0; i < _stops.length; i++) {
      final stop = _stops[i];
      if (stop.position != null) {
        stopStrings.add(stop.css);
      } else {
        // Evenly distribute stops without explicit positions
        final position = i / (_stops.length - 1) * 100;
        stopStrings.add('${stop.color} ${position.round()}%');
      }
    }

    return 'linear-gradient($_angle, ${stopStrings.join(', ')})';
  }
}

/// Extension for creating gradients from a list of ArcaneColors.
extension ArcaneColorGradient on List<ArcaneColor> {
  /// Creates a linear gradient from this list of colors.
  String toGradient({String angle = '135deg'}) {
    if (isEmpty) return 'transparent';
    if (length == 1) return first.css;

    final stops = <String>[];
    for (var i = 0; i < length; i++) {
      final position = i / (length - 1) * 100;
      stops.add('${this[i].css} ${position.round()}%');
    }

    return 'linear-gradient($angle, ${stops.join(', ')})';
  }
}
