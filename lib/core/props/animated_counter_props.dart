import 'package:jaspr/jaspr.dart';

/// Animated counter component properties.
class AnimatedCounterProps {
  final String value;
  final String? prefix;
  final String? suffix;
  final String? label;
  final String fontSize;
  final String? color;
  final String? gradientStart;
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

/// Counter row component properties.
class CounterRowProps {
  final List<Component> counters;
  final String gap;

  const CounterRowProps({
    required this.counters,
    this.gap = '48px',
  });
}

/// Metric display component properties.
class MetricDisplayProps {
  final String value;
  final String label;
  final String? icon;
  final String? trend;
  final bool trendPositive;

  const MetricDisplayProps({
    required this.value,
    required this.label,
    this.icon,
    this.trend,
    this.trendPositive = true,
  });
}
