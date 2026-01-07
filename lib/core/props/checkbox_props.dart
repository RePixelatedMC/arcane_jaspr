enum CheckboxSize {
  small,
  medium,
  large,
}

enum CheckboxVariant {
  primary,
  success,
  warning,
  error,
}

/// Checkbox component properties.
class CheckboxProps {
  final bool checked;
  final String? label;
  final String? description;
  final CheckboxSize size;
  final CheckboxVariant variant;
  final bool disabled;
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
