/// Toggle switch size variants.
enum ToggleSwitchSize {
  /// Small switch - w-9 h-5 (36px x 20px)
  small,

  /// Medium/Default switch - w-11 h-6 (44px x 24px) - shadcn default
  medium,

  /// Large switch - w-14 h-7 (56px x 28px)
  large,
}

/// Toggle switch color variant.
enum ToggleSwitchVariant {
  /// Primary color (default)
  primary,

  /// Success/green color
  success,

  /// Warning/amber color
  warning,

  /// Error/destructive color
  error,
}

/// Properties for toggle switch components.
class ToggleSwitchProps {
  /// Whether the switch is on
  final bool value;

  /// Callback when the switch is toggled
  final void Function(bool)? onChanged;

  /// Whether the switch is disabled
  final bool disabled;

  /// Size variant
  final ToggleSwitchSize size;

  /// Color variant
  final ToggleSwitchVariant variant;

  /// Optional label text
  final String? label;

  /// Whether to show the label on the left side
  final bool labelLeft;

  const ToggleSwitchProps({
    required this.value,
    this.onChanged,
    this.disabled = false,
    this.size = ToggleSwitchSize.medium,
    this.variant = ToggleSwitchVariant.primary,
    this.label,
    this.labelLeft = false,
  });

  /// Create a copy with modified properties
  ToggleSwitchProps copyWith({
    bool? value,
    void Function(bool)? onChanged,
    bool? disabled,
    ToggleSwitchSize? size,
    ToggleSwitchVariant? variant,
    String? label,
    bool? labelLeft,
  }) {
    return ToggleSwitchProps(
      value: value ?? this.value,
      onChanged: onChanged ?? this.onChanged,
      disabled: disabled ?? this.disabled,
      size: size ?? this.size,
      variant: variant ?? this.variant,
      label: label ?? this.label,
      labelLeft: labelLeft ?? this.labelLeft,
    );
  }
}
