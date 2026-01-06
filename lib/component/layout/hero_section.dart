import 'package:jaspr/jaspr.dart';

import '../../core/theme_provider.dart';

export '../../core/props/hero_section_props.dart';

/// A hero section component (Supabase-style)
class ArcaneHeroSection extends StatelessComponent {
  /// Main headline text
  final String headline;

  /// Subheadline/description text
  final String? subheadline;

  /// Primary CTA component
  final Component? primaryCta;

  /// Secondary CTA component
  final Component? secondaryCta;

  /// Optional badge/pill above headline
  final Component? badge;

  /// Optional media (video, image, etc.)
  final Component? media;

  /// Whether to center content
  final bool centered;

  /// Vertical padding
  final double verticalPadding;

  /// Maximum content width
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

/// A CTA button group component
class ArcaneCtaGroup extends StatelessComponent {
  /// Primary CTA component
  final Component primaryCta;

  /// Secondary CTA component
  final Component? secondaryCta;

  /// Whether to center the CTAs
  final bool centered;

  /// Gap between buttons
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
