import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' hide Color, Colors, ColorScheme, Gap, Padding, TextAlign, TextOverflow, Border, BorderRadius, BoxShadow, FontWeight;

import '../../util/tokens/tokens.dart';

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
  })  : gradient = ArcaneColors.accentGradient,
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
        gradientStart = ArcaneColors.accent,
        gradientEnd = ArcaneColors.info,
        gradientAngle = '135deg';

  @override
  Component build(BuildContext context) {
    // Use full gradient if provided, otherwise build from start/end
    final String backgroundGradient;
    if (gradient != null) {
      backgroundGradient = gradient!;
    } else {
      final String start = gradientStart ?? ArcaneColors.success;
      final String end = gradientEnd ?? ArcaneColors.info;
      final String angle = gradientAngle ?? '135deg';
      backgroundGradient = 'linear-gradient($angle, $start 0%, $end 100%)';
    }

    return span(
      classes: 'arcane-gradient-text',
      styles: Styles(raw: {
        'font-size': fontSize,
        'font-weight': fontWeight,
        'background': backgroundGradient,
        '-webkit-background-clip': 'text',
        'background-clip': 'text',
        'color': ArcaneColors.transparent,
      }),
      [Component.text(content)],
    );
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
    return span(
      classes: 'arcane-animated-gradient-text',
      styles: Styles(raw: {
        'font-size': fontSize,
        'font-weight': fontWeight,
        'background':
            'linear-gradient(135deg, ${ArcaneColors.success} 0%, ${ArcaneColors.info} 25%, ${ArcaneColors.accent} 50%, ${ArcaneColors.error} 75%, ${ArcaneColors.success} 100%)',
        'background-size': '200% 200%',
        '-webkit-background-clip': 'text',
        'background-clip': 'text',
        'color': ArcaneColors.transparent,
        'animation': 'arcane-gradient-shift 5s ease infinite',
      }),
      [Component.text(content)],
    );
  }

  @css
  static final List<StyleRule> styles = [
    css('@keyframes arcane-gradient-shift').styles(raw: {
      '0%': 'background-position: 0% 50%',
      '50%': 'background-position: 100% 50%',
      '100%': 'background-position: 0% 50%',
    }),
  ];
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
    final String color = glowColor ?? ArcaneColors.accent;

    return span(
      classes: 'arcane-glow-text',
      styles: Styles(raw: {
        'font-size': fontSize,
        'font-weight': fontWeight,
        'color': color,
        'text-shadow': '0 0 ${10 * intensity}px $color, 0 0 ${20 * intensity}px $color, 0 0 ${40 * intensity}px ${color}60',
      }),
      [Component.text(content)],
    );
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
    final String stroke = strokeColor ?? ArcaneColors.accent;
    final String fill = fillColor ?? ArcaneColors.transparent;

    return span(
      classes: 'arcane-outline-text',
      styles: Styles(raw: {
        'font-size': fontSize,
        'font-weight': fontWeight,
        '-webkit-text-stroke': '${strokeWidth}px $stroke',
        'color': fill,
      }),
      [Component.text(content)],
    );
  }
}
