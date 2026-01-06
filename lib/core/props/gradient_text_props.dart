/// Properties for gradient text components.
class GradientTextProps {
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

  /// Font size
  final String fontSize;

  /// Font weight
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

/// Properties for animated gradient text components.
class AnimatedGradientTextProps {
  /// Text content
  final String content;

  /// Font size
  final String fontSize;

  /// Font weight
  final String fontWeight;

  const AnimatedGradientTextProps({
    required this.content,
    this.fontSize = '32px',
    this.fontWeight = '700',
  });
}

/// Properties for glow text components.
class GlowTextProps {
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

  const GlowTextProps({
    required this.content,
    this.glowColor,
    this.fontSize = '32px',
    this.fontWeight = '700',
    this.intensity = 1.0,
  });
}

/// Properties for outline text components.
class OutlineTextProps {
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

  const OutlineTextProps({
    required this.content,
    this.strokeColor,
    this.fillColor,
    this.fontSize = '32px',
    this.fontWeight = '700',
    this.strokeWidth = 2,
  });
}
