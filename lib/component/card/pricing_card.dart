import 'package:jaspr/jaspr.dart';

import '../../core/theme_provider.dart';

export '../../core/props/pricing_card_props.dart';

/// Pricing card displaying tier information with features and CTA.
///
/// Supports multiple variants:
/// - Default (standard): Full-featured card for hosting plans
/// - Compact: Minimal card for grids
/// - Hero: Large featured card for landing pages
class ArcanePricingCard extends StatelessComponent {
  /// Legacy tier-based construction.
  final PricingTier? tier;

  /// Legacy CTA callback.
  final void Function()? onCtaPressed;

  // ---- Core content ----
  final String? title;
  final String? subtitle;
  final String? price;
  final String period;
  final String? originalPrice;

  // ---- Badge configuration ----
  final String? badge;
  final PricingBadgeVariant badgeVariant;

  // ---- Features and specs ----
  final List<String> features;
  final List<String> excludedFeatures;
  final List<SpecEntry>? specs;

  // ---- Call-to-action ----
  final String buttonText;
  final String? buttonLink;
  final void Function()? onButtonClick;

  // ---- Styling and behavior ----
  final PricingCardVariant variant;
  final bool highlighted;
  final String? accentColor;
  final Component? icon;

  const ArcanePricingCard({
    this.tier,
    this.onCtaPressed,
    this.title,
    this.subtitle,
    this.price,
    this.period = '/month',
    this.originalPrice,
    this.badge,
    this.badgeVariant = PricingBadgeVariant.popular,
    this.features = const [],
    this.excludedFeatures = const [],
    this.specs,
    this.buttonText = 'Get Started',
    this.buttonLink,
    this.onButtonClick,
    this.variant = PricingCardVariant.standard,
    this.highlighted = false,
    this.accentColor,
    this.icon,
    super.key,
  });

  /// Creates a compact pricing card for grids.
  const ArcanePricingCard.compact({
    required String this.title,
    required String this.price,
    this.subtitle,
    this.period = '/month',
    this.originalPrice,
    this.badge,
    this.badgeVariant = PricingBadgeVariant.popular,
    this.features = const [],
    this.excludedFeatures = const [],
    this.specs,
    this.buttonText = 'Get Started',
    this.buttonLink,
    this.onButtonClick,
    this.highlighted = false,
    this.accentColor,
    this.icon,
    super.key,
  })  : tier = null,
        onCtaPressed = null,
        variant = PricingCardVariant.compact;

  /// Creates a hero pricing card for landing pages.
  const ArcanePricingCard.hero({
    required String this.title,
    required String this.price,
    this.subtitle,
    this.period = '/month',
    this.originalPrice,
    this.badge,
    this.badgeVariant = PricingBadgeVariant.popular,
    this.features = const [],
    this.excludedFeatures = const [],
    this.specs,
    this.buttonText = 'Get Started',
    this.buttonLink,
    this.onButtonClick,
    this.highlighted = false,
    this.accentColor,
    this.icon,
    super.key,
  })  : tier = null,
        onCtaPressed = null,
        variant = PricingCardVariant.hero;

  /// Creates a pricing card from a PricingTier (legacy API).
  const ArcanePricingCard.fromTier({
    required PricingTier this.tier,
    this.onCtaPressed,
    super.key,
  })  : title = null,
        subtitle = null,
        price = null,
        period = '/month',
        originalPrice = null,
        badge = null,
        badgeVariant = PricingBadgeVariant.popular,
        features = const [],
        excludedFeatures = const [],
        specs = null,
        buttonText = 'Get Started',
        buttonLink = null,
        onButtonClick = null,
        variant = PricingCardVariant.standard,
        highlighted = false,
        accentColor = null,
        icon = null;

  @override
  Component build(BuildContext context) {
    return context.renderers.pricingCard(PricingCardProps(
      tier: tier,
      onCtaPressed: onCtaPressed,
      title: title,
      subtitle: subtitle,
      price: price,
      period: period,
      originalPrice: originalPrice,
      badge: badge,
      badgeVariant: badgeVariant,
      features: features,
      excludedFeatures: excludedFeatures,
      specs: specs,
      buttonText: buttonText,
      buttonLink: buttonLink,
      onButtonClick: onButtonClick,
      variant: variant,
      highlighted: highlighted,
      accentColor: accentColor,
      icon: icon,
    ));
  }
}

/// Grid layout for displaying multiple pricing tiers.
class ArcanePricingGrid extends StatelessComponent {
  final List<PricingTier> tiers;
  final void Function(PricingTier tier)? onTierSelected;
  final int? columns;

  const ArcanePricingGrid({
    required this.tiers,
    this.onTierSelected,
    this.columns,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return context.renderers.pricingGrid(PricingGridProps(
      tiers: tiers,
      columns: columns,
      onTierSelected: onTierSelected,
    ));
  }
}
