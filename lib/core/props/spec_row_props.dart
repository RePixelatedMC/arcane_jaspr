import 'package:jaspr/jaspr.dart';

/// Spec row component properties.
///
/// Displays a label-value pair, commonly used in pricing cards
/// to show specifications like CPU, RAM, Storage, etc.
class SpecRowProps {
  /// The label text (e.g., "RAM", "Storage", "CPU").
  final String label;

  /// The value text (e.g., "8GB", "100GB SSD", "4 vCores").
  final String value;

  /// Whether to highlight the value with brand/primary color.
  /// When false, uses standard foreground color.
  final bool highlight;

  /// Custom label color (CSS value). Overrides default.
  final String? labelColor;

  /// Custom value color (CSS value). Overrides default and highlight.
  final String? valueColor;

  /// Custom font size (CSS value).
  final String? fontSize;

  const SpecRowProps({
    required this.label,
    required this.value,
    this.highlight = false,
    this.labelColor,
    this.valueColor,
    this.fontSize,
  });

  SpecRowProps copyWith({
    String? label,
    String? value,
    bool? highlight,
    String? labelColor,
    String? valueColor,
    String? fontSize,
  }) {
    return SpecRowProps(
      label: label ?? this.label,
      value: value ?? this.value,
      highlight: highlight ?? this.highlight,
      labelColor: labelColor ?? this.labelColor,
      valueColor: valueColor ?? this.valueColor,
      fontSize: fontSize ?? this.fontSize,
    );
  }
}

// ============================================================================
// RENDERER CONTRACT
// ============================================================================

/// Mixin defining the renderer methods for spec row components.
mixin SpecRowRendererContract {
  /// Renders a spec row component.
  Component specRow(SpecRowProps props);
}
