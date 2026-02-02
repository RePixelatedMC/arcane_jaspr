import 'package:jaspr/jaspr.dart';

import '../../core/theme_provider.dart';

export '../../core/props/hero_section_props.dart';

/// A hero section component for landing pages.
class ArcaneHeroSection extends StatelessComponent {
  /// Plain text headline. Use `headlineComponent` for rich content.
  final String? headline;

  /// Custom headline component (e.g., with gradient text).
  final Component? headlineComponent;

  final String? subheadline;
  final Component? primaryCta;
  final Component? secondaryCta;
  final Component? badge;
  final Component? promoBanner;
  final Component? media;
  final bool centered;
  final double verticalPadding;
  final double maxWidth;
  final List<HeroStatItem>? stats;
  final bool showBackgroundGlow;
  final String? glowColor;

  const ArcaneHeroSection({
    this.headline,
    this.headlineComponent,
    this.subheadline,
    this.primaryCta,
    this.secondaryCta,
    this.badge,
    this.promoBanner,
    this.media,
    this.centered = true,
    this.verticalPadding = 80,
    this.maxWidth = 800,
    this.stats,
    this.showBackgroundGlow = false,
    this.glowColor,
    super.key,
  }) : assert(headline != null || headlineComponent != null,
            'Either headline or headlineComponent must be provided');

  /// Creates a hero section with stats row and background glow.
  const ArcaneHeroSection.withStats({
    this.headline,
    this.headlineComponent,
    this.subheadline,
    this.primaryCta,
    this.secondaryCta,
    this.badge,
    this.promoBanner,
    this.media,
    this.centered = true,
    this.verticalPadding = 80,
    this.maxWidth = 800,
    required this.stats,
    this.glowColor,
    super.key,
  })  : showBackgroundGlow = true,
        assert(headline != null || headlineComponent != null,
            'Either headline or headlineComponent must be provided');

  @override
  Component build(BuildContext context) {
    return context.renderers.heroSection(HeroSectionProps(
      headline: headline,
      headlineComponent: headlineComponent,
      subheadline: subheadline,
      primaryCta: primaryCta,
      secondaryCta: secondaryCta,
      badge: badge,
      promoBanner: promoBanner,
      media: media,
      centered: centered,
      verticalPadding: verticalPadding,
      maxWidth: maxWidth,
      stats: stats,
      showBackgroundGlow: showBackgroundGlow,
      glowColor: glowColor,
    ));
  }
}

/// A CTA button group component.
class ArcaneCtaGroup extends StatelessComponent {
  final Component primaryCta;
  final Component? secondaryCta;
  final bool centered;
  final double gap;

  const ArcaneCtaGroup({
    required this.primaryCta,
    this.secondaryCta,
    this.centered = false,
    this.gap = 12,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return context.renderers.ctaGroup(CtaGroupProps(
      primaryCta: primaryCta,
      secondaryCta: secondaryCta,
      centered: centered,
      gap: gap,
    ));
  }
}
