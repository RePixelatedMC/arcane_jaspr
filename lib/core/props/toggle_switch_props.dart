import 'package:jaspr/jaspr.dart';
import '../shared/shared.dart';

export '../shared/shared.dart' show ComponentSize, ColorVariant;

/// Toggle switch component properties.
class ToggleSwitchProps {
  final bool value;
  final void Function(bool)? onChanged;
  final bool disabled;
  final ComponentSize size;
  final ColorVariant color;
  final String? label;
  final bool labelLeft;

  const ToggleSwitchProps({
    required this.value,
    this.onChanged,
    this.disabled = false,
    this.size = ComponentSize.md,
    this.color = ColorVariant.primary,
    this.label,
    this.labelLeft = false,
  });

  ToggleSwitchProps copyWith({
    bool? value,
    void Function(bool)? onChanged,
    bool? disabled,
    ComponentSize? size,
    ColorVariant? color,
    String? label,
    bool? labelLeft,
  }) {
    return ToggleSwitchProps(
      value: value ?? this.value,
      onChanged: onChanged ?? this.onChanged,
      disabled: disabled ?? this.disabled,
      size: size ?? this.size,
      color: color ?? this.color,
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
