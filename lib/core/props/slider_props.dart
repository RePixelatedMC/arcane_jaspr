/// Slider size variants.
enum SliderSize {
  /// Small - 6px track, 16px thumb
  sm,

  /// Medium (default) - 8px track, 20px thumb (shadcn default)
  md,

  /// Large - 10px track, 24px thumb
  lg,
}

/// Slider color variant.
enum SliderVariant {
  /// Primary color (default)
  primary,

  /// Success/green color
  success,

  /// Warning/amber color
  warning,

  /// Error/destructive color
  error,
}

/// Properties for slider components.
///
/// Supports both single value and range modes.
class SliderProps {
  /// Current value (for single mode)
  final double value;

  /// Minimum allowed value
  final double min;

  /// Maximum allowed value
  final double max;

  /// Step increment (null for continuous)
  final double? step;

  /// Label text displayed above the slider
  final String? label;

  /// Whether to show the current value
  final bool showValue;

  /// Prefix for the value display (e.g., "$")
  final String? valuePrefix;

  /// Suffix for the value display (e.g., "%")
  final String? valueSuffix;

  /// Number of decimal places for value display
  final int valueDecimals;

  /// Color variant
  final SliderVariant variant;

  /// Size variant
  final SliderSize size;

  /// Whether to show step markers on the track
  final bool showSteps;

  /// Whether the slider is disabled
  final bool disabled;

  /// Callback when value changes (single mode)
  final void Function(double)? onChanged;

  // Range mode properties

  /// Whether this is a range slider with two handles
  final bool isRange;

  /// Current minimum value (range mode only)
  final double? rangeMin;

  /// Current maximum value (range mode only)
  final double? rangeMax;

  /// Callback when range values change (range mode only)
  final void Function(double min, double max)? onRangeChanged;

  const SliderProps({
    this.value = 0,
    this.min = 0,
    this.max = 100,
    this.step,
    this.label,
    this.showValue = true,
    this.valuePrefix,
    this.valueSuffix,
    this.valueDecimals = 0,
    this.variant = SliderVariant.primary,
    this.size = SliderSize.md,
    this.showSteps = false,
    this.disabled = false,
    this.onChanged,
    this.isRange = false,
    this.rangeMin,
    this.rangeMax,
    this.onRangeChanged,
  });

  /// Creates props for a range slider
  const SliderProps.range({
    required double minValue,
    required double maxValue,
    this.min = 0,
    this.max = 100,
    this.step,
    this.label,
    this.showValue = true,
    this.valuePrefix,
    this.valueSuffix,
    this.valueDecimals = 0,
    this.variant = SliderVariant.primary,
    this.size = SliderSize.md,
    this.showSteps = false,
    this.disabled = false,
    this.onRangeChanged,
  })  : value = 0,
        onChanged = null,
        isRange = true,
        rangeMin = minValue,
        rangeMax = maxValue;

  /// Create a copy with modified properties
  SliderProps copyWith({
    double? value,
    double? min,
    double? max,
    double? step,
    String? label,
    bool? showValue,
    String? valuePrefix,
    String? valueSuffix,
    int? valueDecimals,
    SliderVariant? variant,
    SliderSize? size,
    bool? showSteps,
    bool? disabled,
    void Function(double)? onChanged,
    bool? isRange,
    double? rangeMin,
    double? rangeMax,
    void Function(double min, double max)? onRangeChanged,
  }) {
    return SliderProps(
      value: value ?? this.value,
      min: min ?? this.min,
      max: max ?? this.max,
      step: step ?? this.step,
      label: label ?? this.label,
      showValue: showValue ?? this.showValue,
      valuePrefix: valuePrefix ?? this.valuePrefix,
      valueSuffix: valueSuffix ?? this.valueSuffix,
      valueDecimals: valueDecimals ?? this.valueDecimals,
      variant: variant ?? this.variant,
      size: size ?? this.size,
      showSteps: showSteps ?? this.showSteps,
      disabled: disabled ?? this.disabled,
      onChanged: onChanged ?? this.onChanged,
      isRange: isRange ?? this.isRange,
      rangeMin: rangeMin ?? this.rangeMin,
      rangeMax: rangeMax ?? this.rangeMax,
      onRangeChanged: onRangeChanged ?? this.onRangeChanged,
    );
  }
}
