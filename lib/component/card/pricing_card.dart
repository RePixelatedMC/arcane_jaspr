import 'package:jaspr/jaspr.dart';

import '../../core/theme_provider.dart';

export '../../core/props/pricing_card_props.dart';

/// Pricing card displaying tier information with features and CTA.
class ArcanePricingCard extends StatelessComponent {
  final PricingTier tier;
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
