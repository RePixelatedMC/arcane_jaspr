import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

export '../../core/props/slider_props.dart' show SliderSize, SliderVariant;

import '../../core/theme_provider.dart';

/// Slider input component matching shadcn/ui design.
///
/// Supports both single value mode and range mode with two handles.
///
/// ## Basic Usage
///
/// ```dart
/// ArcaneSlider(
///   value: 50,
///   onChanged: (v) => setState(() => value = v),
/// )
/// ```
///
/// ## Range Mode
///
/// ```dart
/// ArcaneSlider.range(
///   minValue: 20,
///   maxValue: 80,
///   onRangeChanged: (min, max) => setState(() {
///     minValue = min;
///     maxValue = max;
///   }),
/// )
/// ```
///
/// ## With Label and Value Display
///
/// ```dart
/// ArcaneSlider(
///   value: 75,
///   label: 'Volume',
///   showValue: true,
///   valueSuffix: '%',
///   onChanged: (v) => setState(() => volume = v),
/// )
/// ```
///
/// ## Variants
///
/// ```dart
/// ArcaneSlider.primary(value: 50, label: 'Primary')
/// ArcaneSlider.success(value: 50, label: 'Success')
/// ```
class ArcaneSlider extends StatelessComponent {
  /// Current value (single mode)
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

  /// Whether this is a range slider
  final bool isRange;

  /// Current minimum value (range mode)
  final double? rangeMin;

  /// Current maximum value (range mode)
  final double? rangeMax;

  /// Callback when range changes (range mode)
  final void Function(double min, double max)? onRangeChanged;

  const ArcaneSlider({
    required this.value,
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
    super.key,
  })  : isRange = false,
        rangeMin = null,
        rangeMax = null,
        onRangeChanged = null;

  /// Creates a range slider with two handles
  const ArcaneSlider.range({
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
    super.key,
  })  : value = 0,
        onChanged = null,
        isRange = true,
        rangeMin = minValue,
        rangeMax = maxValue;

  /// Primary styled slider
  const ArcaneSlider.primary({
    required this.value,
    this.min = 0,
    this.max = 100,
    this.step,
    this.label,
    this.showValue = true,
    this.valuePrefix,
    this.valueSuffix,
    this.valueDecimals = 0,
    this.size = SliderSize.md,
    this.showSteps = false,
    this.disabled = false,
    this.onChanged,
    super.key,
  })  : variant = SliderVariant.primary,
        isRange = false,
        rangeMin = null,
        rangeMax = null,
        onRangeChanged = null;

  /// Success styled slider
  const ArcaneSlider.success({
    required this.value,
    this.min = 0,
    this.max = 100,
    this.step,
    this.label,
    this.showValue = true,
    this.valuePrefix,
    this.valueSuffix,
    this.valueDecimals = 0,
    this.size = SliderSize.md,
    this.showSteps = false,
    this.disabled = false,
    this.onChanged,
    super.key,
  })  : variant = SliderVariant.success,
        isRange = false,
        rangeMin = null,
        rangeMax = null,
        onRangeChanged = null;

  /// Warning styled slider
  const ArcaneSlider.warning({
    required this.value,
    this.min = 0,
    this.max = 100,
    this.step,
    this.label,
    this.showValue = true,
    this.valuePrefix,
    this.valueSuffix,
    this.valueDecimals = 0,
    this.size = SliderSize.md,
    this.showSteps = false,
    this.disabled = false,
    this.onChanged,
    super.key,
  })  : variant = SliderVariant.warning,
        isRange = false,
        rangeMin = null,
        rangeMax = null,
        onRangeChanged = null;

  /// Error styled slider
  const ArcaneSlider.error({
    required this.value,
    this.min = 0,
    this.max = 100,
    this.step,
    this.label,
    this.showValue = true,
    this.valuePrefix,
    this.valueSuffix,
    this.valueDecimals = 0,
    this.size = SliderSize.md,
    this.showSteps = false,
    this.disabled = false,
    this.onChanged,
    super.key,
  })  : variant = SliderVariant.error,
        isRange = false,
        rangeMin = null,
        rangeMax = null,
        onRangeChanged = null;

  @override
  Component build(BuildContext context) {
    // Delegate to the current stylesheet's slider renderer
    return context.renderers.slider(SliderProps(
      value: value,
      min: min,
      max: max,
      step: step,
      label: label,
      showValue: showValue,
      valuePrefix: valuePrefix,
      valueSuffix: valueSuffix,
      valueDecimals: valueDecimals,
      variant: variant,
      size: size,
      showSteps: showSteps,
      disabled: disabled,
      onChanged: onChanged,
      isRange: isRange,
      rangeMin: rangeMin,
      rangeMax: rangeMax,
      onRangeChanged: onRangeChanged,
    ));
  }
}

/// Alias for backwards compatibility.
/// @deprecated Use [ArcaneSlider.range] instead.
typedef ArcaneRangeSlider = _DeprecatedRangeSlider;

/// Temporary wrapper for deprecated ArcaneRangeSlider.
/// Delegates to ArcaneSlider.range().
class _DeprecatedRangeSlider extends StatelessComponent {
  final double minValue;
  final double maxValue;
  final double min;
  final double max;
  final double? step;
  final String? label;
  final bool showValues;
  final SliderVariant variant;
  final SliderSize size;
  final bool disabled;
  final void Function(double min, double max)? onChanged;

  const _DeprecatedRangeSlider({
    required this.minValue,
    required this.maxValue,
    this.min = 0,
    this.max = 100,
    this.step,
    this.label,
    this.showValues = true,
    this.variant = SliderVariant.primary,
    this.size = SliderSize.md,
    this.disabled = false,
    this.onChanged,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return ArcaneSlider.range(
      minValue: minValue,
      maxValue: maxValue,
      min: min,
      max: max,
      step: step,
      label: label,
      showValue: showValues,
      variant: variant,
      size: size,
      disabled: disabled,
      onRangeChanged: onChanged,
    );
  }
}