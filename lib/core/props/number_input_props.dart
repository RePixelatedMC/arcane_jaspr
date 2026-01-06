/// Number input size variants.
enum NumberInputSize {
  /// Small size
  sm,

  /// Medium/default size
  md,

  /// Large size
  lg,
}

/// Properties for number input components.
///
/// This is the shared props class used by all stylesheet renderers.
class NumberInputProps {
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

  /// Create a copy with modified properties
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
