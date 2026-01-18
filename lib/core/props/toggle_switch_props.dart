import 'package:jaspr/jaspr.dart';

enum ToggleSwitchSize {
  small,
  medium,
  large,
}

enum ToggleSwitchVariant {
  primary,
  success,
  warning,
  error,
}

/// Toggle switch component properties.
class ToggleSwitchProps {
  final bool value;
  final void Function(bool)? onChanged;
  final bool disabled;
  final ToggleSwitchSize size;
  final ToggleSwitchVariant variant;
  final String? label;
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

// ============================================================================
// RENDERER CONTRACT
// ============================================================================

/// Mixin defining the renderer method for toggle switch components.
mixin ToggleSwitchRendererContract {
  /// Render a toggle switch component.
  Component toggleSwitch(ToggleSwitchProps props);
}
