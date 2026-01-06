import 'package:jaspr/jaspr.dart';

import '../../core/theme_provider.dart';

// Re-export props for usage
export '../../core/props/stat_display_props.dart';

/// A metric/stat display with large value and label.
///
/// Common for trust indicators, hero stats, and dashboard metrics.
///
/// ```dart
/// ArcaneStatDisplay(
///   value: '99.9%',
///   label: 'Uptime SLA',
/// )
///
/// ArcaneStatDisplay.accent(
///   value: '10K+',
///   label: 'Active Servers',
/// )
/// ```
class ArcaneStatDisplay extends StatelessComponent {
  /// The main value (e.g., '99.9%', '10K+', '<60s')
  final String value;

  /// The label describing the value
  final String label;

  /// Layout direction
  final StatDisplayLayout layout;

  /// Value text color
  final String? valueColor;

  /// Label text color
  final String? labelColor;

  /// Value font size
  final String? valueFontSize;

  /// Label font size
  final String? labelFontSize;

  /// Text alignment
  final String? textAlign;

  const ArcaneStatDisplay({
    required this.value,
    required this.label,
    this.layout = StatDisplayLayout.vertical,
    this.valueColor,
    this.labelColor,
    this.valueFontSize,
    this.labelFontSize,
    this.textAlign,
    super.key,
  });

  /// Create with accent-colored value
  const ArcaneStatDisplay.accent({
    required this.value,
    required this.label,
    this.layout = StatDisplayLayout.vertical,
    this.labelColor,
    this.valueFontSize,
    this.labelFontSize,
    this.textAlign,
    super.key,
  }) : valueColor = 'var(--primary)';

  /// Create with brand-colored value
  const ArcaneStatDisplay.brand({
    required this.value,
    required this.label,
    this.layout = StatDisplayLayout.vertical,
    this.labelColor,
    this.valueFontSize,
    this.labelFontSize,
    this.textAlign,
    super.key,
  }) : valueColor = 'var(--primary)';

  @override
  Component build(BuildContext context) {
    return context.renderers.statDisplay(StatDisplayProps(
      value: value,
      label: label,
      layout: layout,
      valueColor: valueColor,
      labelColor: labelColor,
      valueFontSize: valueFontSize,
      labelFontSize: labelFontSize,
      textAlign: textAlign,
    ));
  }
}

/// A row of stat displays for trust indicators.
///
/// ```dart
/// ArcaneStatRow(
///   stats: [
///     ArcaneStatDisplay(value: '99.9%', label: 'Uptime'),
///     ArcaneStatDisplay(value: '10K+', label: 'Servers'),
///     ArcaneStatDisplay(value: '<60s', label: 'Deploy'),
///   ],
/// )
/// ```
class ArcaneStatRow extends StatelessComponent {
  /// List of stat displays
  final List<Component> stats;

  /// Gap between stats
  final String? gap;

  /// Whether to wrap on smaller screens
  final bool wrap;

  /// Alignment
  final String? justifyContent;

  const ArcaneStatRow({
    required this.stats,
    this.gap,
    this.wrap = true,
    this.justifyContent,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return context.renderers.statRow(StatRowProps(
      stats: stats,
      gap: gap,
      wrap: wrap,
      justifyContent: justifyContent,
    ));
  }
}
