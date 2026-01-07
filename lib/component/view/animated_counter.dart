import 'package:jaspr/jaspr.dart';

import '../../core/theme_provider.dart';

export '../../core/props/animated_counter_props.dart';

/// Animated counter display for statistics.
class ArcaneAnimatedCounter extends StatelessComponent {
  final String value;
  final String? prefix;
  final String? suffix;
  final String? label;
  final String fontSize;
  final String? color;
  final String? gradientStart;
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

/// Counter row for displaying multiple stats.
class ArcaneCounterRow extends StatelessComponent {
  final List<ArcaneAnimatedCounter> counters;
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

/// A metric display with label.
class ArcaneMetricDisplay extends StatelessComponent {
  final String value;
  final String label;
  final String? icon;
  final String? trend;
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
