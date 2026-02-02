import 'package:jaspr/jaspr.dart';

import '../../core/theme_provider.dart';

export '../../core/props/feature_card_props.dart';

/// Feature card for showcasing product features with icon, title, and description.
class ArcaneFeatureCard extends StatelessComponent {
  final String title;
  final String description;
  final Component? icon;
  final String? href;
  final void Function()? onTap;
  final bool showArrow;
  final bool horizontal;

  /// Custom accent color for theming (CSS color value).
  /// When set, applies accent styling to icon container and gradient border.
  final String? accentColor;

  /// Custom CTA button text. Defaults to 'Learn More' or 'View Docs' for external.
  final String? ctaText;

  /// Whether the link opens in a new tab (external link).
  final bool isExternal;

  /// Whether to show CTA button at the bottom.
  final bool showCta;

  const ArcaneFeatureCard({
    required this.title,
    required this.description,
    this.icon,
    this.href,
    this.onTap,
    this.showArrow = false,
    this.horizontal = false,
    this.accentColor,
    this.ctaText,
    this.isExternal = false,
    this.showCta = false,
    super.key,
  });

  /// Creates a feature card with accent color styling and CTA button.
  /// This is the style used for InfoTile-like cards.
  const ArcaneFeatureCard.accented({
    required this.title,
    required this.description,
    required this.icon,
    required String this.accentColor,
    this.href,
    this.onTap,
    this.ctaText,
    this.isExternal = false,
    super.key,
  })  : showArrow = false,
        horizontal = false,
        showCta = true;

  @override
  Component build(BuildContext context) {
    return context.renderers.featureCard(FeatureCardProps(
      title: title,
      description: description,
      icon: icon,
      href: href,
      onTap: onTap,
      showArrow: showArrow,
      horizontal: horizontal,
      accentColor: accentColor,
      ctaText: ctaText,
      isExternal: isExternal,
      showCta: showCta,
    ));
  }
}

/// Simple icon card for feature grids.
class ArcaneIconCard extends StatelessComponent {
  final String title;
  final String? subtitle;
  final Component icon;
  final void Function()? onTap;
  final String? href;

  const ArcaneIconCard({
    required this.title,
    required this.icon,
    this.subtitle,
    this.onTap,
    this.href,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return context.renderers.iconCard(IconCardProps(
      title: title,
      icon: icon,
      subtitle: subtitle,
      onTap: onTap,
      href: href,
    ));
  }
}
