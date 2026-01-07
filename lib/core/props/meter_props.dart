enum MeterStyleVariant {
  bar,
  gradient,
  segmented,
  circular,
}

enum MeterColorVariant {
  primary,
  success,
  warning,
  error,
  adaptive,
}

enum MeterSizeVariant {
  sm,
  md,
  lg,
}

/// Meter/gauge component properties.
class MeterProps {
  final double value;
  final double min;
  final double max;
  final double? low;
  final double? high;
  final double? optimum;
  final String? label;
  final bool showValue;
  final String? valueSuffix;
  final MeterStyleVariant style;
  final MeterColorVariant color;
  final MeterSizeVariant size;
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

  double get percentage => ((value - min) / (max - min) * 100).clamp(0, 100);

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
