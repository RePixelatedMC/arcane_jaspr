import 'package:jaspr/jaspr.dart';

/// Hero section component properties.
class HeroSectionProps {
  final String headline;
  final String? subheadline;
  final Component? primaryCta;
  final Component? secondaryCta;
  final Component? badge;
  final Component? media;
  final bool centered;
  final double verticalPadding;
  final double maxWidth;

  const HeroSectionProps({
    required this.headline,
    this.subheadline,
    this.primaryCta,
    this.secondaryCta,
    this.badge,
    this.media,
    this.centered = true,
    this.verticalPadding = 80,
    this.maxWidth = 800,
  });
}

/// CTA group component properties.
class CtaGroupProps {
  final Component primaryCta;
  final Component? secondaryCta;
  final bool centered;
  final double gap;

  const CtaGroupProps({
    required this.primaryCta,
    this.secondaryCta,
    this.centered = false,
    this.gap = 12,
  });
}

// ============================================================================
// RENDERER CONTRACT
// ============================================================================

/// Mixin defining the renderer methods for hero section components.
mixin HeroSectionRendererContract {
  Component heroSection(HeroSectionProps props);
  Component ctaGroup(CtaGroupProps props);
}
