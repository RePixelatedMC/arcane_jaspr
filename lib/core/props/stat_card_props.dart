import 'package:jaspr/jaspr.dart';

/// Stat card component properties.
class StatCardProps {
  final String label;
  final String value;
  final String? icon;
  final String? trend;
  final bool trendPositive;
  final String? description;
  final String? iconBackground;

  const StatCardProps({
    required this.label,
    required this.value,
    this.icon,
    this.trend,
    this.trendPositive = true,
    this.description,
    this.iconBackground,
  });
}

/// Stat card row component properties.
class StatCardRowProps {
  final List<Component> cards;
  final int columns;
  final String? gap;

  const StatCardRowProps({
    required this.cards,
    this.columns = 4,
    this.gap,
  });
}

// ============================================================================
// RENDERER CONTRACT
// ============================================================================

/// Mixin defining the renderer methods for stat card components.
mixin StatCardRendererContract {
  Component statCard(StatCardProps props);
  Component statCardRow(StatCardRowProps props);
}
