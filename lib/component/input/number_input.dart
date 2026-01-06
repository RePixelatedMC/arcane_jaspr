import 'package:jaspr/jaspr.dart';

import '../../core/theme_provider.dart';

export '../../core/props/number_input_props.dart' show NumberInputSize;

/// Numeric input with increment/decrement controls.
///
/// Clean stepper with +/- buttons and proper data attributes for static site support.
///
/// ```dart
/// ArcaneNumberInput(
///   value: 5,
///   min: 0,
///   max: 100,
///   onChanged: (value) => print(value),
/// )
/// ```
class ArcaneNumberInput extends StatelessComponent {
  /// Current value
  final num value;

  /// Minimum value
  final num min;

  /// Maximum value
  final num max;

  /// Step increment
  final num step;

  /// Callback when value changes
  final void Function(num)? onChanged;

  /// Size variant
  final NumberInputSize size;

  /// Whether the input is disabled
  final bool disabled;

  /// Label text
  final String? label;

  /// Prefix text (e.g., "$")
  final String? prefix;

  /// Suffix text (e.g., "kg")
  final String? suffix;

  /// Number of decimal places to display
  final int decimals;

  /// Optional element ID
  final String? id;

  /// Additional HTML attributes
  final Map<String, String>? attributes;

  const ArcaneNumberInput({
    required this.value,
    this.min = 0,
    this.max = 100,
    this.step = 1,
    this.onChanged,
    this.size = NumberInputSize.md,
    this.disabled = false,
    this.label,
    this.prefix,
    this.suffix,
    this.decimals = 0,
    this.id,
    this.attributes,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return context.renderers.numberInput(NumberInputProps(
      value: value,
      min: min,
      max: max,
      step: step,
      onChanged: onChanged,
      size: size,
      disabled: disabled,
      label: label,
      prefix: prefix,
      suffix: suffix,
      decimals: decimals,
      id: id,
      attributes: attributes,
    ));
  }
}
