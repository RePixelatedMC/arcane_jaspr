import 'package:jaspr/jaspr.dart';

/// Pricing tier data.
class PricingTier {
  final String name;
  final double? price;
  final String period;
  final String currency;
  final String description;
  final List<String> features;
  final String ctaText;
  final bool isPopular;
  final bool isHighlighted;

  const PricingTier({
    required this.name,
    this.price,
    this.period = 'month',
    this.currency = '\$',
    required this.description,
    required this.features,
    this.ctaText = 'Get Started',
    this.isPopular = false,
    this.isHighlighted = false,
  });
}

/// Pricing card component properties.
class PricingCardProps {
  final PricingTier tier;
  final void Function()? onCtaPressed;

  const PricingCardProps({
    required this.tier,
    this.onCtaPressed,
  });
}

/// Pricing grid component properties.
class PricingGridProps {
  final List<PricingTier> tiers;
  final void Function(PricingTier tier)? onTierSelected;
  final int? columns;

  const PricingGridProps({
    required this.tiers,
    this.onTierSelected,
    this.columns,
  });
}

// ============================================================================
// RENDERER CONTRACT
// ============================================================================

/// Mixin defining the renderer methods for pricing card components.
mixin PricingCardRendererContract {
  Component pricingCard(PricingCardProps props);
  Component pricingGrid(PricingGridProps props);
}
