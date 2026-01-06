import 'package:jaspr/jaspr.dart';

/// Properties for animated counter components.
class AnimatedCounterProps {
  /// The value to display
  final String value;

  /// Prefix (e.g., "$")
  final String? prefix;

  /// Suffix (e.g., "+", "%")
  final String? suffix;

  /// Label text
  final String? label;

  /// Font size
  final String fontSize;

  /// Custom color
  final String? color;

  /// Gradient start color (use with gradientEnd)
  final String? gradientStart;

  /// Gradient end color (use with gradientStart)
  final String? gradientEnd;

  const AnimatedCounterProps({
    required this.value,
    this.prefix,
    this.suffix,
    this.label,
    this.fontSize = '48px',
    this.color,
    this.gradientStart,
    this.gradientEnd,
  });
}

/// Properties for counter row components.
class CounterRowProps {
  /// Counter components to display
  final List<Component> counters;

  /// Gap between counters
  final String gap;

  const CounterRowProps({
    required this.counters,
    this.gap = '48px',
  });
}

/// Properties for metric display components.
class MetricDisplayProps {
  /// Metric value
  final String value;

  /// Metric label
  final String label;

  /// Optional icon
  final String? icon;

  /// Optional trend indicator
  final String? trend;

  /// Whether trend is positive
  final bool trendPositive;

  const MetricDisplayProps({
    required this.value,
    required this.label,
    this.icon,
    this.trend,
    this.trendPositive = true,
  });
}
