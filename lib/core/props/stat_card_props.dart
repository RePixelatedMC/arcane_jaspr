import 'package:jaspr/jaspr.dart';

/// Props for stat card components.
class StatCardProps {
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

/// Props for stat card row components.
class StatCardRowProps {
  /// Stat cards to display
  final List<Component> cards;

  /// Number of columns
  final int columns;

  /// Gap between cards
  final String? gap;

  const StatCardRowProps({
    required this.cards,
    this.columns = 4,
    this.gap,
  });
}
