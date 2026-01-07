import 'package:jaspr/jaspr.dart';

import '../../core/theme_provider.dart';

export '../../core/props/hero_section_props.dart';

/// A hero section component for landing pages.
class ArcaneHeroSection extends StatelessComponent {
  final String headline;
  final String? subheadline;
  final Component? primaryCta;
  final Component? secondaryCta;
  final Component? badge;
  final Component? media;
  final bool centered;
  final double verticalPadding;
  final double maxWidth;

  const ArcaneHeroSection({
    required this.headline,
    this.subheadline,
    this.primaryCta,
    this.secondaryCta,
    this.badge,
    this.media,
    this.centered = true,
    this.verticalPadding = 80,
    this.maxWidth = 800,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return context.renderers.heroSection(HeroSectionProps(
      headline: headline,
      subheadline: subheadline,
      primaryCta: primaryCta,
      secondaryCta: secondaryCta,
      badge: badge,
      media: media,
      centered: centered,
      verticalPadding: verticalPadding,
      maxWidth: maxWidth,
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
