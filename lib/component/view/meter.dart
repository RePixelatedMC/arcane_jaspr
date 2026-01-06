import 'package:jaspr/jaspr.dart';

import '../../core/theme_provider.dart';

export '../../core/props/meter_props.dart'
    show MeterStyleVariant, MeterColorVariant, MeterSizeVariant, MeterProps;

/// Meter style variants (local alias)
typedef MeterStyle = MeterStyleVariant;

/// Meter color variants (local alias)
typedef MeterColor = MeterColorVariant;

/// Meter size variants (local alias)
typedef MeterSize = MeterSizeVariant;

/// Progress meter/gauge component
///
/// Displays a visual representation of a value within a range.
///
/// ```dart
/// ArcaneMeter(
///   value: 75,
///   max: 100,
///   label: 'Storage Used',
///   showValue: true,
/// )
/// ```
class ArcaneMeter extends StatelessComponent {
  /// Current value
  final double value;

  /// Minimum value
  final double min;

  /// Maximum value
  final double max;

  /// Optimal minimum (for adaptive coloring)
  final double? low;

  /// Optimal maximum (for adaptive coloring)
  final double? high;

  /// Optimal value (for adaptive coloring)
  final double? optimum;

  /// Label text
  final String? label;

  /// Whether to show the value
  final bool showValue;

  /// Value format (e.g., "%", "GB", etc.)
  final String? valueSuffix;

  /// Style variant
  final MeterStyle style;

  /// Color variant
  final MeterColor color;

  /// Size variant
  final MeterSize size;

  /// Number of segments (for segmented style)
  final int segments;

  const ArcaneMeter({
    required this.value,
    this.min = 0,
    this.max = 100,
    this.low,
    this.high,
    this.optimum,
    this.label,
    this.showValue = true,
    this.valueSuffix,
    this.style = MeterStyle.bar,
    this.color = MeterColor.primary,
    this.size = MeterSize.md,
    this.segments = 10,
    super.key,
  });

  /// Storage/disk usage meter
  const ArcaneMeter.storage({
    required this.value,
    this.max = 100,
    this.label = 'Storage',
    this.showValue = true,
    this.size = MeterSize.md,
    super.key,
  })  : min = 0,
        low = null,
        high = 80,
        optimum = null,
        valueSuffix = '%',
        style = MeterStyle.bar,
        color = MeterColor.adaptive,
        segments = 10;

  /// Battery level meter
  const ArcaneMeter.battery({
    required this.value,
    this.label,
    this.showValue = true,
    this.size = MeterSize.md,
    super.key,
  })  : min = 0,
        max = 100,
        low = 20,
        high = null,
        optimum = null,
        valueSuffix = '%',
        style = MeterStyle.segmented,
        color = MeterColor.adaptive,
        segments = 5;

  MeterStyleVariant get _propsStyle => switch (style) {
        MeterStyle.bar => MeterStyleVariant.bar,
        MeterStyle.gradient => MeterStyleVariant.gradient,
        MeterStyle.segmented => MeterStyleVariant.segmented,
        MeterStyle.circular => MeterStyleVariant.circular,
      };

  MeterColorVariant get _propsColor => switch (color) {
        MeterColor.primary => MeterColorVariant.primary,
        MeterColor.success => MeterColorVariant.success,
        MeterColor.warning => MeterColorVariant.warning,
        MeterColor.error => MeterColorVariant.error,
        MeterColor.adaptive => MeterColorVariant.adaptive,
      };

  MeterSizeVariant get _propsSize => switch (size) {
        MeterSize.sm => MeterSizeVariant.sm,
        MeterSize.md => MeterSizeVariant.md,
        MeterSize.lg => MeterSizeVariant.lg,
      };

  @override
  Component build(BuildContext context) {
    return context.renderers.meter(MeterProps(
      value: value,
      min: min,
      max: max,
      low: low,
      high: high,
      optimum: optimum,
      label: label,
      showValue: showValue,
      valueSuffix: valueSuffix,
      style: _propsStyle,
      color: _propsColor,
      size: _propsSize,
      segments: segments,
    ));
  }
}