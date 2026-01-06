import 'package:jaspr/jaspr.dart';

import '../../core/theme_provider.dart';

// Re-export props for usage
export '../../core/props/stat_card_props.dart';

/// Stat card for displaying metrics with optional trend indicator
class ArcaneStatCard extends StatelessComponent {
  /// Label text
  final String label;

  /// Value to display
  final String value;

  /// Optional icon
  final String? icon;

  /// Trend value (e.g., "+12.5%")
  final String? trend;

  /// Whether the trend is positive
  final bool trendPositive;

  /// Additional description
  final String? description;

  /// Custom icon background
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

/// A row of stat cards
class ArcaneStatCardRow extends StatelessComponent {
  /// Stat cards to display
  final List<ArcaneStatCard> cards;

  /// Number of columns
  final int columns;

  /// Gap between cards
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
