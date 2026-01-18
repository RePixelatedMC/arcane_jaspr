import 'package:jaspr/jaspr.dart';

enum TextInputSize {
  sm,
  md,
  lg,
}

enum TextInputVariant {
  outline,
  filled,
  underline,
}

enum TextInputType {
  text,
  email,
  password,
  number,
  tel,
  url,
  search,
}

/// Text input component properties.
class TextInputProps {
  final String? placeholder;
  final TextInputType type;
  final String? value;
  final String? name;
  final String? id;
  final TextInputSize size;
  final TextInputVariant variant;
  final bool disabled;
  final bool required;
  final bool readOnly;
  final bool fullWidth;
  final String? label;
  final String? helperText;
  final String? error;
  final Component? prefix;
  final Component? suffix;
  final void Function(String)? onChanged;
  final void Function()? onFocus;
  final void Function()? onBlur;
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

// ============================================================================
// RENDERER CONTRACT
// ============================================================================

/// Mixin defining the renderer method for text input components.
mixin TextInputRendererContract {
  /// Render a text input component.
  Component textInput(TextInputProps props);
}
