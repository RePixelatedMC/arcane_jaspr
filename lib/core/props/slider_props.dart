enum SliderSize {
  sm,
  md,
  lg,
}

enum SliderVariant {
  primary,
  success,
  warning,
  error,
}

/// Slider component properties.
class SliderProps {
  final double value;
  final double min;
  final double max;
  final double? step;
  final String? label;
  final bool showValue;
  final String? valuePrefix;
  final String? valueSuffix;
  final int valueDecimals;
  final SliderVariant variant;
  final SliderSize size;
  final bool showSteps;
  final bool disabled;
  final void Function(double)? onChanged;
  final bool isRange;
  final double? rangeMin;
  final double? rangeMax;
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
