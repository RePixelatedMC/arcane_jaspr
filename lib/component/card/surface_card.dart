import 'package:jaspr/jaspr.dart';

import '../../core/theme_provider.dart';

export '../../core/props/surface_card_props.dart';

/// Card with surface effects like blur, frosted glass, or gradients.
class ArcaneSurfaceCard extends StatelessComponent {
  final Component child;
  final SurfaceEffect effect;
  final double blurAmount;
  final double backgroundOpacity;
  final String? backgroundColor;
  final List<String>? gradientColors;
  final int gradientAngle;
  final String? borderRadius;
  final bool showBorder;
  final String? padding;
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

enum ShadowIntensity {
  none,
  sm,
  md,
  lg,
  xl,
}

/// Card with thumbhash or blurhash placeholder background.
class ArcaneThumbHashCard extends StatelessComponent {
  final String hash;
  final Component child;
  final String? borderRadius;
  final String? padding;
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
