import 'package:jaspr/jaspr.dart';

import '../../core/theme_provider.dart';

// Re-export props for usage
export '../../core/props/pricing_card_props.dart';

/// A pricing card component (Supabase-style)
class ArcanePricingCard extends StatelessComponent {
  /// The pricing tier data
  final PricingTier tier;

  /// Click handler for CTA
  final void Function()? onCtaPressed;

  const ArcanePricingCard({
    required this.tier,
    this.onCtaPressed,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return context.renderers.pricingCard(PricingCardProps(
      tier: tier,
      onCtaPressed: onCtaPressed,
    ));
  }
}

/// A pricing grid for displaying multiple tiers
class ArcanePricingGrid extends StatelessComponent {
  /// The pricing tiers to display
  final List<PricingTier> tiers;

  /// Callback when a tier's CTA is pressed
  final void Function(PricingTier tier)? onTierSelected;

  /// Number of columns (auto-calculated if null)
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
