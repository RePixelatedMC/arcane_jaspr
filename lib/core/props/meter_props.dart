/// Meter style variants
enum MeterStyleVariant {
  /// Standard horizontal bar
  bar,

  /// Gradient bar
  gradient,

  /// Segmented/stepped meter
  segmented,

  /// Circular/radial meter
  circular,
}

/// Meter color variants
enum MeterColorVariant {
  /// Primary accent color
  primary,

  /// Success/green
  success,

  /// Warning/amber
  warning,

  /// Error/red
  error,

  /// Gradient based on value (green->yellow->red)
  adaptive,
}

/// Meter size variants
enum MeterSizeVariant {
  sm,
  md,
  lg,
}

/// Properties for meter/gauge components.
class MeterProps {
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
  final MeterStyleVariant style;

  /// Color variant
  final MeterColorVariant color;

  /// Size variant
  final MeterSizeVariant size;

  /// Number of segments (for segmented style)
  final int segments;

  const MeterProps({
    required this.value,
    this.min = 0,
    this.max = 100,
    this.low,
    this.high,
    this.optimum,
    this.label,
    this.showValue = true,
    this.valueSuffix,
    this.style = MeterStyleVariant.bar,
    this.color = MeterColorVariant.primary,
    this.size = MeterSizeVariant.md,
    this.segments = 10,
  });

  /// Get the percentage value
  double get percentage => ((value - min) / (max - min) * 100).clamp(0, 100);

  /// Create a copy with modified properties
  MeterProps copyWith({
    double? value,
    double? min,
    double? max,
    double? low,
    double? high,
    double? optimum,
    String? label,
    bool? showValue,
    String? valueSuffix,
    MeterStyleVariant? style,
    MeterColorVariant? color,
    MeterSizeVariant? size,
    int? segments,
  }) {
    return MeterProps(
      value: value ?? this.value,
      min: min ?? this.min,
      max: max ?? this.max,
      low: low ?? this.low,
      high: high ?? this.high,
      optimum: optimum ?? this.optimum,
      label: label ?? this.label,
      showValue: showValue ?? this.showValue,
      valueSuffix: valueSuffix ?? this.valueSuffix,
      style: style ?? this.style,
      color: color ?? this.color,
      size: size ?? this.size,
      segments: segments ?? this.segments,
    );
  }
}
