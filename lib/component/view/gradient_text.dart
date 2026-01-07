import 'package:jaspr/jaspr.dart';

import '../../core/theme_provider.dart';

export '../../core/props/gradient_text_props.dart';

/// Text with gradient color.
class ArcaneGradientText extends StatelessComponent {
  final String content;
  final String? gradient;
  final String? gradientStart;
  final String? gradientEnd;
  final String? gradientAngle;
  final String fontSize;
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

  const ArcaneGradientText.brand({
    required this.content,
    this.fontSize = 'inherit',
    this.fontWeight = 'inherit',
    super.key,
  })  : gradient = 'linear-gradient(135deg, var(--accent) 0%, hsl(199 89% 48%) 100%)',
        gradientStart = null,
        gradientEnd = null,
        gradientAngle = null;

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
