import 'package:jaspr/jaspr.dart';

import '../../core/theme_provider.dart';

export '../../core/props/stat_card_props.dart';

/// Stat card for displaying metrics with optional trend indicator.
class ArcaneStatCard extends StatelessComponent {
  final String label;
  final String value;
  final String? icon;
  final String? trend;
  final bool trendPositive;
  final String? description;
  final String? iconBackground;

  const ArcaneStatCard({
    required this.label,
    required this.value,
    this.icon,
    this.trend,
    this.trendPositive = true,
    this.description,
    this.iconBackground,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return context.renderers.statCard(StatCardProps(
      label: label,
      value: value,
      icon: icon,
      trend: trend,
      trendPositive: trendPositive,
      description: description,
      iconBackground: iconBackground,
    ));
  }
}

/// Row layout for multiple stat cards.
class ArcaneStatCardRow extends StatelessComponent {
  final List<ArcaneStatCard> cards;
  final int columns;
  final double gap;

  const ArcaneStatCardRow({
    required this.cards,
    this.columns = 4,
    this.gap = 24,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return context.renderers.statCardRow(StatCardRowProps(
      cards: cards,
      columns: columns,
      gap: '${gap}px',
    ));
  }
}
