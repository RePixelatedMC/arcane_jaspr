import '../../util/style_types/arcane_color.dart';

/// Gradient text component properties.
class GradientTextProps {
  final String content;

  /// Full CSS gradient string. Takes precedence over other gradient properties.
  final String? gradient;

  /// Start color (for simple two-color gradients).
  final String? gradientStart;

  /// End color (for simple two-color gradients).
  final String? gradientEnd;

  /// Gradient angle (e.g., '135deg', 'to right').
  final String? gradientAngle;

  /// List of color stops for multi-color gradients.
  final List<GradientStop>? colorStops;

  final String fontSize;
  final String fontWeight;

  const GradientTextProps({
    required this.content,
    this.gradient,
    this.gradientStart,
    this.gradientEnd,
    this.gradientAngle,
    this.colorStops,
    this.fontSize = 'inherit',
    this.fontWeight = 'inherit',
  });

  /// Builds the CSS gradient string from the properties.
  String buildGradient() {
    // Full gradient string takes precedence
    if (gradient != null) return gradient!;

    // Multi-color stops
    if (colorStops != null && colorStops!.isNotEmpty) {
      final angle = gradientAngle ?? '135deg';
      final stops = <String>[];

      for (var i = 0; i < colorStops!.length; i++) {
        final stop = colorStops![i];
        if (stop.position != null) {
          stops.add(stop.css);
        } else {
          // Evenly distribute stops without explicit positions
          final position = i / (colorStops!.length - 1) * 100;
          stops.add('${stop.color} ${position.round()}%');
        }
      }

      return 'linear-gradient($angle, ${stops.join(', ')})';
    }

    // Simple two-color gradient
    final start = gradientStart ?? 'var(--primary)';
    final end = gradientEnd ?? 'var(--accent)';
    final angle = gradientAngle ?? '135deg';
    return 'linear-gradient($angle, $start 0%, $end 100%)';
  }
}

/// Animated gradient text component properties.
class AnimatedGradientTextProps {
  final String content;
  final String fontSize;
  final String fontWeight;

  const AnimatedGradientTextProps({
    required this.content,
    this.fontSize = '32px',
    this.fontWeight = '700',
  });
}

/// Glow text component properties.
class GlowTextProps {
  final String content;
  final String? glowColor;
  final String fontSize;
  final String fontWeight;
  final double intensity;

  const GlowTextProps({
    required this.content,
    this.glowColor,
    this.fontSize = '32px',
    this.fontWeight = '700',
    this.intensity = 1.0,
  });
}

/// Outline text component properties.
class OutlineTextProps {
  final String content;
  final String? strokeColor;
  final String? fillColor;
  final String fontSize;
  final String fontWeight;
  final double strokeWidth;

  const OutlineTextProps({
    required this.content,
    this.strokeColor,
    this.fillColor,
    this.fontSize = '32px',
    this.fontWeight = '700',
    this.strokeWidth = 2,
  });
}
