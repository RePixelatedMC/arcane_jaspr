import 'package:jaspr/jaspr.dart';

import '../../core/props/gradient_text_props.dart';
import '../../core/theme_provider.dart';

// Re-export props for usage
export '../../core/props/gradient_text_props.dart';

/// Text with gradient color
///
/// ```dart
/// // Using gradient string
/// ArcaneGradientText(
///   content: 'Hello World',
///   gradient: 'linear-gradient(135deg, #059669, #0891B2)',
/// )
///
/// // Using start/end colors
/// ArcaneGradientText(
///   content: 'Hello World',
///   gradientStart: '#059669',
///   gradientEnd: '#0891B2',
/// )
///
/// // Using brand gradient (accent colors)
/// ArcaneGradientText.brand(content: 'Hello World')
/// ```
class ArcaneGradientText extends StatelessComponent {
  /// Text content
  final String content;

  /// Full gradient CSS value (takes precedence over start/end)
  final String? gradient;

  /// Gradient start color
  final String? gradientStart;

  /// Gradient end color
  final String? gradientEnd;

  /// Gradient angle
  final String? gradientAngle;

  /// Font size (defaults to 'inherit' for inline use)
  final String fontSize;

  /// Font weight (defaults to 'inherit' for inline use)
  final String fontWeight;

  const ArcaneGradientText({
    required this.content,
    this.gradient,
    this.gradientStart,
    this.gradientEnd,
    this.gradientAngle,
    this.fontSize = 'inherit',
    this.fontWeight = 'inherit',
    super.key,
  });

  /// Creates gradient text using the brand/accent gradient
  const ArcaneGradientText.brand({
    required this.content,
    this.fontSize = 'inherit',
    this.fontWeight = 'inherit',
    super.key,
  })  : gradient = 'linear-gradient(135deg, var(--accent) 0%, hsl(199 89% 48%) 100%)',
        gradientStart = null,
        gradientEnd = null,
        gradientAngle = null;

  /// Creates gradient text using accent to info colors
  const ArcaneGradientText.accent({
    required this.content,
    this.fontSize = 'inherit',
    this.fontWeight = 'inherit',
    super.key,
  })  : gradient = null,
        gradientStart = 'var(--accent)',
        gradientEnd = 'hsl(199 89% 48%)',
        gradientAngle = '135deg';

  @override
  Component build(BuildContext context) {
    return context.renderers.gradientText(GradientTextProps(
      content: content,
      gradient: gradient,
      gradientStart: gradientStart,
      gradientEnd: gradientEnd,
      gradientAngle: gradientAngle,
      fontSize: fontSize,
      fontWeight: fontWeight,
    ));
  }
}

/// Animated gradient text with color shift
class ArcaneAnimatedGradientText extends StatelessComponent {
  /// Text content
  final String content;

  /// Font size
  final String fontSize;

  /// Font weight
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

/// Glow text effect
class ArcaneGlowText extends StatelessComponent {
  /// Text content
  final String content;

  /// Glow color
  final String? glowColor;

  /// Font size
  final String fontSize;

  /// Font weight
  final String fontWeight;

  /// Glow intensity
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

/// Outline text effect
class ArcaneOutlineText extends StatelessComponent {
  /// Text content
  final String content;

  /// Stroke color
  final String? strokeColor;

  /// Fill color (null for transparent)
  final String? fillColor;

  /// Font size
  final String fontSize;

  /// Font weight
  final String fontWeight;

  /// Stroke width
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
