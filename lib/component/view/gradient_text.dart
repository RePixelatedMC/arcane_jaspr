import 'package:jaspr/jaspr.dart';

import '../../core/theme_provider.dart';
import '../../util/style_types/arcane_color.dart';

export '../../core/props/gradient_text_props.dart';
export '../../util/style_types/arcane_color.dart';

/// Text with gradient color.
///
/// Supports multiple ways to define gradients:
/// - Simple two-color: [gradientStart] and [gradientEnd]
/// - Multi-color: [colors] list of [ArcaneColor] values
/// - Custom stops: [colorStops] list of [GradientStop] with positions
/// - Raw CSS: [gradient] string for full control
class ArcaneGradientText extends StatelessComponent {
  final String content;
  final String? gradient;
  final String? gradientStart;
  final String? gradientEnd;
  final String? gradientAngle;
  final List<GradientStop>? colorStops;
  final String fontSize;
  final String fontWeight;

  const ArcaneGradientText({
    required this.content,
    this.gradient,
    this.gradientStart,
    this.gradientEnd,
    this.gradientAngle,
    this.colorStops,
    this.fontSize = 'inherit',
    this.fontWeight = 'inherit',
    super.key,
  });

  /// Creates gradient text from a list of [ArcaneColor] values.
  ///
  /// Colors are evenly distributed across the gradient.
  /// ```dart
  /// ArcaneGradientText.fromColors(
  ///   content: 'Hello',
  ///   colors: [ArcaneColor.accent, ArcaneColor.primary, ArcaneColor.success],
  /// )
  /// ```
  factory ArcaneGradientText.fromColors({
    required String content,
    required List<ArcaneColor> colors,
    String angle = '135deg',
    String fontSize = 'inherit',
    String fontWeight = 'inherit',
    Key? key,
  }) {
    return ArcaneGradientText(
      content: content,
      gradient: colors.toGradient(angle: angle),
      fontSize: fontSize,
      fontWeight: fontWeight,
      key: key,
    );
  }

  /// Creates gradient text with custom color stops for precise control.
  ///
  /// ```dart
  /// ArcaneGradientText.custom(
  ///   content: 'Hello',
  ///   stops: [
  ///     GradientStop.fromArcane(ArcaneColor.accent, 0.0),
  ///     GradientStop.fromArcane(ArcaneColor.primary, 0.5),
  ///     GradientStop.hex('#FF0000', 1.0),
  ///   ],
  /// )
  /// ```
  const ArcaneGradientText.custom({
    required this.content,
    required List<GradientStop> stops,
    this.gradientAngle = '135deg',
    this.fontSize = 'inherit',
    this.fontWeight = 'inherit',
    super.key,
  })  : colorStops = stops,
        gradient = null,
        gradientStart = null,
        gradientEnd = null;

  /// Brand gradient using primary and accent colors.
  const ArcaneGradientText.brand({
    required this.content,
    this.fontSize = 'inherit',
    this.fontWeight = 'inherit',
    super.key,
  })  : gradient = 'linear-gradient(135deg, var(--primary) 0%, var(--accent) 100%)',
        gradientStart = null,
        gradientEnd = null,
        gradientAngle = null,
        colorStops = null;

  /// Accent gradient using accent color variations.
  const ArcaneGradientText.accent({
    required this.content,
    this.fontSize = 'inherit',
    this.fontWeight = 'inherit',
    super.key,
  })  : gradient = null,
        gradientStart = 'var(--accent)',
        gradientEnd = 'var(--primary)',
        gradientAngle = '135deg',
        colorStops = null;

  /// Success gradient using success color.
  const ArcaneGradientText.success({
    required this.content,
    this.fontSize = 'inherit',
    this.fontWeight = 'inherit',
    super.key,
  })  : gradient = 'linear-gradient(135deg, var(--success) 0%, var(--accent) 100%)',
        gradientStart = null,
        gradientEnd = null,
        gradientAngle = null,
        colorStops = null;

  /// Warning gradient using warning color.
  const ArcaneGradientText.warning({
    required this.content,
    this.fontSize = 'inherit',
    this.fontWeight = 'inherit',
    super.key,
  })  : gradient = 'linear-gradient(135deg, var(--warning) 0%, var(--destructive) 100%)',
        gradientStart = null,
        gradientEnd = null,
        gradientAngle = null,
        colorStops = null;

  /// Error/destructive gradient.
  const ArcaneGradientText.error({
    required this.content,
    this.fontSize = 'inherit',
    this.fontWeight = 'inherit',
    super.key,
  })  : gradient = 'linear-gradient(135deg, var(--destructive) 0%, var(--warning) 100%)',
        gradientStart = null,
        gradientEnd = null,
        gradientAngle = null,
        colorStops = null;

  /// Rainbow gradient cycling through multiple colors.
  const ArcaneGradientText.rainbow({
    required this.content,
    this.fontSize = 'inherit',
    this.fontWeight = 'inherit',
    super.key,
  })  : gradient = 'linear-gradient(135deg, var(--destructive) 0%, var(--warning) 25%, var(--success) 50%, var(--info) 75%, var(--accent) 100%)',
        gradientStart = null,
        gradientEnd = null,
        gradientAngle = null,
        colorStops = null;

  @override
  Component build(BuildContext context) {
    return context.renderers.gradientText(GradientTextProps(
      content: content,
      gradient: gradient,
      gradientStart: gradientStart,
      gradientEnd: gradientEnd,
      gradientAngle: gradientAngle,
      colorStops: colorStops,
      fontSize: fontSize,
      fontWeight: fontWeight,
    ));
  }
}

/// Animated gradient text with color shift.
class ArcaneAnimatedGradientText extends StatelessComponent {
  final String content;
  final String fontSize;
  final String fontWeight;

  const ArcaneAnimatedGradientText({
    required this.content,
    this.fontSize = '32px',
    this.fontWeight = '700',
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return context.renderers.animatedGradientText(AnimatedGradientTextProps(
      content: content,
      fontSize: fontSize,
      fontWeight: fontWeight,
    ));
  }
}

/// Glow text effect.
class ArcaneGlowText extends StatelessComponent {
  final String content;
  final String? glowColor;
  final String fontSize;
  final String fontWeight;
  final double intensity;

  const ArcaneGlowText({
    required this.content,
    this.glowColor,
    this.fontSize = '32px',
    this.fontWeight = '700',
    this.intensity = 1.0,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return context.renderers.glowText(GlowTextProps(
      content: content,
      glowColor: glowColor,
      fontSize: fontSize,
      fontWeight: fontWeight,
      intensity: intensity,
    ));
  }
}

/// Outline text effect.
class ArcaneOutlineText extends StatelessComponent {
  final String content;
  final String? strokeColor;
  final String? fillColor;
  final String fontSize;
  final String fontWeight;
  final double strokeWidth;

  const ArcaneOutlineText({
    required this.content,
    this.strokeColor,
    this.fillColor,
    this.fontSize = '32px',
    this.fontWeight = '700',
    this.strokeWidth = 2,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return context.renderers.outlineText(OutlineTextProps(
      content: content,
      strokeColor: strokeColor,
      fillColor: fillColor,
      fontSize: fontSize,
      fontWeight: fontWeight,
      strokeWidth: strokeWidth,
    ));
  }
}
