import 'package:jaspr/jaspr.dart';

import '../../core/props/animated_counter_props.dart';
import '../../core/theme_provider.dart';

// Re-export props for usage
export '../../core/props/animated_counter_props.dart';

/// Animated counter display for statistics
class ArcaneAnimatedCounter extends StatelessComponent {
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

  const ArcaneAnimatedCounter({
    required this.value,
    this.prefix,
    this.suffix,
    this.label,
    this.fontSize = '48px',
    this.color,
    this.gradientStart,
    this.gradientEnd,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return context.renderers.animatedCounter(AnimatedCounterProps(
      value: value,
      prefix: prefix,
      suffix: suffix,
      label: label,
      fontSize: fontSize,
      color: color,
      gradientStart: gradientStart,
      gradientEnd: gradientEnd,
    ));
  }
}

/// Counter row for displaying multiple stats
class ArcaneCounterRow extends StatelessComponent {
  /// Counters to display
  final List<ArcaneAnimatedCounter> counters;

  /// Gap between counters
  final String gap;

  const ArcaneCounterRow({
    required this.counters,
    this.gap = '48px',
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return context.renderers.counterRow(CounterRowProps(
      counters: counters,
      gap: gap,
    ));
  }
}

/// A metric display with label
class ArcaneMetricDisplay extends StatelessComponent {
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

  const ArcaneMetricDisplay({
    required this.value,
    required this.label,
    this.icon,
    this.trend,
    this.trendPositive = true,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return context.renderers.metricDisplay(MetricDisplayProps(
      value: value,
      label: label,
      icon: icon,
      trend: trend,
      trendPositive: trendPositive,
    ));
  }
}
