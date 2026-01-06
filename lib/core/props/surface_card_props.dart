import 'package:jaspr/jaspr.dart';

/// Surface effect types for cards.
enum SurfaceEffect {
  /// No effect (plain surface)
  none,

  /// Subtle blur effect
  blur,

  /// Frosted glass effect
  frosted,

  /// Gradient overlay
  gradient,

  /// Glassmorphism effect
  glass,

  /// Ice/crystal effect
  ice,
}

/// Shadow intensity levels.
enum SurfaceShadow {
  none,
  sm,
  md,
  lg,
  xl,
}

/// Props for surface card components.
class SurfaceCardProps {
  /// Card content
  final Component child;

  /// Surface effect to apply
  final SurfaceEffect effect;

  /// Blur amount (for blur-based effects)
  final double blurAmount;

  /// Background opacity (0.0 - 1.0)
  final double backgroundOpacity;

  /// Custom background color
  final String? backgroundColor;

  /// Custom gradient colors (for gradient effect)
  final List<String>? gradientColors;

  /// Gradient direction in degrees
  final int gradientAngle;

  /// Border radius
  final String? borderRadius;

  /// Whether to show border
  final bool showBorder;

  /// Padding
  final String? padding;

  /// Shadow intensity
  final SurfaceShadow shadow;

  const SurfaceCardProps({
    required this.child,
    this.effect = SurfaceEffect.none,
    this.blurAmount = 10.0,
    this.backgroundOpacity = 0.8,
    this.backgroundColor,
    this.gradientColors,
    this.gradientAngle = 135,
    this.borderRadius,
    this.showBorder = true,
    this.padding,
    this.shadow = SurfaceShadow.md,
  });
}

/// Props for thumbhash card components.
class ThumbHashCardProps {
  /// ThumbHash or BlurHash string
  final String hash;

  /// Card content
  final Component child;

  /// Border radius
  final String? borderRadius;

  /// Padding
  final String? padding;

  /// Overlay opacity (to darken for text readability)
  final double overlayOpacity;

  const ThumbHashCardProps({
    required this.hash,
    required this.child,
    this.borderRadius,
    this.padding,
    this.overlayOpacity = 0.3,
  });
}
