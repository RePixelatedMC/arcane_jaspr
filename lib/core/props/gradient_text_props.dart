/// Gradient text component properties.
class GradientTextProps {
  final String content;
  final String? gradient;
  final String? gradientStart;
  final String? gradientEnd;
  final String? gradientAngle;
  final String fontSize;
  final String fontWeight;

  const GradientTextProps({
    required this.content,
    this.gradient,
    this.gradientStart,
    this.gradientEnd,
    this.gradientAngle,
    this.fontSize = 'inherit',
    this.fontWeight = 'inherit',
  });
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
