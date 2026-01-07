enum NumberInputSize {
  sm,
  md,
  lg,
}

/// Number input component properties.
class NumberInputProps {
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

  const NumberInputProps({
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
  });

  NumberInputProps copyWith({
    num? value,
    num? min,
    num? max,
    num? step,
    void Function(num)? onChanged,
    NumberInputSize? size,
    bool? disabled,
    String? label,
    String? prefix,
    String? suffix,
    int? decimals,
    String? id,
    Map<String, String>? attributes,
  }) {
    return NumberInputProps(
      value: value ?? this.value,
      min: min ?? this.min,
      max: max ?? this.max,
      step: step ?? this.step,
      onChanged: onChanged ?? this.onChanged,
      size: size ?? this.size,
      disabled: disabled ?? this.disabled,
      label: label ?? this.label,
      prefix: prefix ?? this.prefix,
      suffix: suffix ?? this.suffix,
      decimals: decimals ?? this.decimals,
      id: id ?? this.id,
      attributes: attributes ?? this.attributes,
    );
  }
}
