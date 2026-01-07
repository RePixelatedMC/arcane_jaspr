import 'package:jaspr/jaspr.dart';

import '../../core/theme_provider.dart';

export '../../core/props/stat_display_props.dart';

/// A metric/stat display with large value and label.
class ArcaneStatDisplay extends StatelessComponent {
  final String value;
  final String label;
  final StatDisplayLayout layout;
  final String? valueColor;
  final String? labelColor;
  final String? valueFontSize;
  final String? labelFontSize;
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
class ArcaneStatRow extends StatelessComponent {
  final List<Component> stats;
  final String? gap;
  final bool wrap;
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
