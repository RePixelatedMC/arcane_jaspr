/// A pricing tier data class
class PricingTier {
  /// Tier name (e.g., "Free", "Pro", "Team")
  final String name;

  /// Price amount (null for custom/enterprise)
  final double? price;

  /// Price period (e.g., "month", "year")
  final String period;

  /// Currency symbol
  final String currency;

  /// Short description/tagline
  final String description;

  /// List of features included
  final List<String> features;

  /// CTA button text
  final String ctaText;

  /// Whether this is the recommended/popular tier
  final bool isPopular;

  /// Whether this tier is highlighted
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

/// Props for pricing card component.
class PricingCardProps {
  /// The pricing tier data
  final PricingTier tier;

  /// Click handler for CTA
  final void Function()? onCtaPressed;

  const PricingCardProps({
    required this.tier,
    this.onCtaPressed,
  });
}

/// Props for pricing grid component.
class PricingGridProps {
  /// The pricing tiers to display
  final List<PricingTier> tiers;

  /// Callback when a tier's CTA is pressed
  final void Function(PricingTier tier)? onTierSelected;

  /// Number of columns (auto-calculated if null)
  final int? columns;

  const PricingGridProps({
    required this.tiers,
    this.onTierSelected,
    this.columns,
  });
}
