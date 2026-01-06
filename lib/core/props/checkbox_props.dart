/// Checkbox size variants.
enum CheckboxSize {
  /// Small checkbox (14px)
  small,

  /// Medium/Default checkbox (16px)
  medium,

  /// Large checkbox (20px)
  large,
}

/// Checkbox color variant.
enum CheckboxVariant {
  /// Primary color
  primary,

  /// Success/green color
  success,

  /// Warning/amber color
  warning,

  /// Error/destructive color
  error,
}

/// Properties for checkbox components.
class CheckboxProps {
  /// Whether the checkbox is checked
  final bool checked;

  /// Label text
  final String? label;

  /// Description text below label
  final String? description;

  /// Size variant
  final CheckboxSize size;

  /// Color variant
  final CheckboxVariant variant;

  /// Whether the checkbox is disabled
  final bool disabled;

  /// Called when the checkbox state changes
  final void Function(bool)? onChanged;

  const CheckboxProps({
    required this.checked,
    this.label,
    this.description,
    this.size = CheckboxSize.medium,
    this.variant = CheckboxVariant.primary,
    this.disabled = false,
    this.onChanged,
  });

  /// Create a copy with modified properties
  CheckboxProps copyWith({
    bool? checked,
    String? label,
    String? description,
    CheckboxSize? size,
    CheckboxVariant? variant,
    bool? disabled,
    void Function(bool)? onChanged,
  }) {
    return CheckboxProps(
      checked: checked ?? this.checked,
      label: label ?? this.label,
      description: description ?? this.description,
      size: size ?? this.size,
      variant: variant ?? this.variant,
      disabled: disabled ?? this.disabled,
      onChanged: onChanged ?? this.onChanged,
    );
  }
}
