import 'package:jaspr/jaspr.dart';

/// Text input size variants.
enum TextInputSize {
  /// Small - compact size
  sm,

  /// Medium (default)
  md,

  /// Large - more padding
  lg,
}

/// Text input variant styles.
enum TextInputVariant {
  /// Default outline style
  outline,

  /// Filled/subtle background style
  filled,

  /// Underline only (no border)
  underline,
}

/// Text input type (maps to HTML input types).
enum TextInputType {
  text,
  email,
  password,
  number,
  tel,
  url,
  search,
}

/// Properties for text input components.
class TextInputProps {
  /// Input placeholder text
  final String? placeholder;

  /// Input type
  final TextInputType type;

  /// Current value
  final String? value;

  /// Input name (for forms)
  final String? name;

  /// Input ID
  final String? id;

  /// Size variant
  final TextInputSize size;

  /// Visual variant
  final TextInputVariant variant;

  /// Whether the input is disabled
  final bool disabled;

  /// Whether the input is required
  final bool required;

  /// Whether the input is read-only
  final bool readOnly;

  /// Whether the input takes full width
  final bool fullWidth;

  /// Label text displayed above the input
  final String? label;

  /// Helper text displayed below the input
  final String? helperText;

  /// Error message (displays in error state)
  final String? error;

  /// Prefix component (icon/text before input)
  final Component? prefix;

  /// Suffix component (icon/text after input)
  final Component? suffix;

  /// Callback when value changes
  final void Function(String)? onChanged;

  /// Callback when input gains focus
  final void Function()? onFocus;

  /// Callback when input loses focus
  final void Function()? onBlur;

  /// Callback when Enter key is pressed
  final void Function(String)? onSubmit;

  const TextInputProps({
    this.placeholder,
    this.type = TextInputType.text,
    this.value,
    this.name,
    this.id,
    this.size = TextInputSize.md,
    this.variant = TextInputVariant.outline,
    this.disabled = false,
    this.required = false,
    this.readOnly = false,
    this.fullWidth = false,
    this.label,
    this.helperText,
    this.error,
    this.prefix,
    this.suffix,
    this.onChanged,
    this.onFocus,
    this.onBlur,
    this.onSubmit,
  });

  /// Create a copy with modified properties
  TextInputProps copyWith({
    String? placeholder,
    TextInputType? type,
    String? value,
    String? name,
    String? id,
    TextInputSize? size,
    TextInputVariant? variant,
    bool? disabled,
    bool? required,
    bool? readOnly,
    bool? fullWidth,
    String? label,
    String? helperText,
    String? error,
    Component? prefix,
    Component? suffix,
    void Function(String)? onChanged,
    void Function()? onFocus,
    void Function()? onBlur,
    void Function(String)? onSubmit,
  }) {
    return TextInputProps(
      placeholder: placeholder ?? this.placeholder,
      type: type ?? this.type,
      value: value ?? this.value,
      name: name ?? this.name,
      id: id ?? this.id,
      size: size ?? this.size,
      variant: variant ?? this.variant,
      disabled: disabled ?? this.disabled,
      required: required ?? this.required,
      readOnly: readOnly ?? this.readOnly,
      fullWidth: fullWidth ?? this.fullWidth,
      label: label ?? this.label,
      helperText: helperText ?? this.helperText,
      error: error ?? this.error,
      prefix: prefix ?? this.prefix,
      suffix: suffix ?? this.suffix,
      onChanged: onChanged ?? this.onChanged,
      onFocus: onFocus ?? this.onFocus,
      onBlur: onBlur ?? this.onBlur,
      onSubmit: onSubmit ?? this.onSubmit,
    );
  }
}
