import 'package:jaspr/jaspr.dart';

import '../../core/theme_provider.dart';

export '../../core/props/number_input_props.dart' show NumberInputSize;

/// Numeric input with increment/decrement controls.
class ArcaneNumberInput extends StatelessComponent {
  final num value;
  final num min;
  final num max;
  final num step;
  final void Function(num)? onChanged;
  final NumberInputSize size;
  final bool disabled;
  final String? label;
  final String? prefix;
  final String? suffix;
  final int decimals;
  final String? id;
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
