import 'package:jaspr/jaspr.dart';

import '../../core/theme_provider.dart';

// Re-export props for usage
export '../../core/props/surface_card_props.dart';

/// A card with surface effects (blur, frosted glass, etc.)
///
/// ```dart
/// ArcaneSurfaceCard(
///   effect: SurfaceEffect.frosted,
///   child: CardContent(),
/// )
/// ```
class ArcaneSurfaceCard extends StatelessComponent {
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
  final ShadowIntensity shadow;

  const ArcaneSurfaceCard({
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
    this.shadow = ShadowIntensity.md,
    super.key,
  });

  /// Blur effect card
  const ArcaneSurfaceCard.blur({
    required this.child,
    this.blurAmount = 10.0,
    this.backgroundOpacity = 0.8,
    this.backgroundColor,
    this.borderRadius,
    this.showBorder = true,
    this.padding,
    this.shadow = ShadowIntensity.md,
    super.key,
  })  : effect = SurfaceEffect.blur,
        gradientColors = null,
        gradientAngle = 135;

  /// Frosted glass card
  const ArcaneSurfaceCard.frosted({
    required this.child,
    this.blurAmount = 12.0,
    this.backgroundOpacity = 0.6,
    this.backgroundColor,
    this.borderRadius,
    this.showBorder = true,
    this.padding,
    this.shadow = ShadowIntensity.md,
    super.key,
  })  : effect = SurfaceEffect.frosted,
        gradientColors = null,
        gradientAngle = 135;

  /// Glass morphism card
  const ArcaneSurfaceCard.glass({
    required this.child,
    this.blurAmount = 16.0,
    this.backgroundOpacity = 0.4,
    this.backgroundColor,
    this.borderRadius,
    this.showBorder = true,
    this.padding,
    this.shadow = ShadowIntensity.lg,
    super.key,
  })  : effect = SurfaceEffect.glass,
        gradientColors = null,
        gradientAngle = 135;

  /// Gradient background card
  const ArcaneSurfaceCard.gradient({
    required this.child,
    this.gradientColors,
    this.gradientAngle = 135,
    this.borderRadius,
    this.showBorder = false,
    this.padding,
    this.shadow = ShadowIntensity.md,
    super.key,
  })  : effect = SurfaceEffect.gradient,
        blurAmount = 0,
        backgroundOpacity = 1.0,
        backgroundColor = null;

  SurfaceShadow get _surfaceShadow => switch (shadow) {
    ShadowIntensity.none => SurfaceShadow.none,
    ShadowIntensity.sm => SurfaceShadow.sm,
    ShadowIntensity.md => SurfaceShadow.md,
    ShadowIntensity.lg => SurfaceShadow.lg,
    ShadowIntensity.xl => SurfaceShadow.xl,
  };

  @override
  Component build(BuildContext context) {
    return context.renderers.surfaceCard(SurfaceCardProps(
      child: child,
      effect: effect,
      blurAmount: blurAmount,
      backgroundOpacity: backgroundOpacity,
      backgroundColor: backgroundColor,
      gradientColors: gradientColors,
      gradientAngle: gradientAngle,
      borderRadius: borderRadius,
      showBorder: showBorder,
      padding: padding,
      shadow: _surfaceShadow,
    ));
  }
}

/// Shadow intensity levels
enum ShadowIntensity {
  none,
  sm,
  md,
  lg,
  xl,
}

/// A card with a thumbhash or blurhash placeholder background.
///
/// Useful for image cards while loading or as decorative backgrounds.
///
/// Note: Actual thumbhash decoding requires JS interop or a decoder.
/// This component provides the structure for it.
///
/// ```dart
/// ArcaneThumbHashCard(
///   hash: 'H3IFHI4ri5RQpWdCen0rUPLtCQ',
///   child: CardContent(),
/// )
/// ```
class ArcaneThumbHashCard extends StatelessComponent {
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

  const ArcaneThumbHashCard({
    required this.hash,
    required this.child,
    this.borderRadius,
    this.padding,
    this.overlayOpacity = 0.3,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return context.renderers.thumbHashCard(ThumbHashCardProps(
      hash: hash,
      child: child,
      borderRadius: borderRadius,
      padding: padding,
      overlayOpacity: overlayOpacity,
    ));
  }
}
