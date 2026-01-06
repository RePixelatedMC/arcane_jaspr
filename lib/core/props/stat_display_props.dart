import 'package:jaspr/jaspr.dart';

/// Layout direction for stat display
enum StatDisplayLayout {
  /// Value on top, label below (default)
  vertical,

  /// Value and label side by side
  horizontal,
}

/// Properties for stat display components.
class StatDisplayProps {
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

  const StatDisplayProps({
    required this.value,
    required this.label,
    this.layout = StatDisplayLayout.vertical,
    this.valueColor,
    this.labelColor,
    this.valueFontSize,
    this.labelFontSize,
    this.textAlign,
  });
}

/// Properties for stat row components.
class StatRowProps {
  /// List of stat displays
  final List<Component> stats;

  /// Gap between stats
  final String? gap;

  /// Whether to wrap on smaller screens
  final bool wrap;

  /// Alignment
  final String? justifyContent;

  const StatRowProps({
    required this.stats,
    this.gap,
    this.wrap = true,
    this.justifyContent,
  });
}
