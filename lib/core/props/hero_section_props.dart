import 'package:jaspr/jaspr.dart';

/// Properties for hero section components.
class HeroSectionProps {
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

/// Properties for CTA group components.
class CtaGroupProps {
  /// Primary CTA component
  final Component primaryCta;

  /// Secondary CTA component
  final Component? secondaryCta;

  /// Whether to center the CTAs
  final bool centered;

  /// Gap between buttons
  final double gap;

  const CtaGroupProps({
    required this.primaryCta,
    this.secondaryCta,
    this.centered = false,
    this.gap = 12,
  });
}
