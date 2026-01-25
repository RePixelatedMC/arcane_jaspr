import 'package:jaspr/jaspr.dart';
import '../shared/shared.dart';

export '../shared/shared.dart' show ComponentSize, ColorVariant;

/// Checkbox component properties.
class CheckboxProps {
  final bool checked;
  final String? label;
  final String? description;
  final ComponentSize size;
  final ColorVariant color;
  final bool disabled;
  final void Function(bool)? onChanged;

  const CheckboxProps({
    required this.checked,
    this.label,
    this.description,
    this.size = ComponentSize.md,
    this.color = ColorVariant.primary,
    this.disabled = false,
    this.onChanged,
  });

  CheckboxProps copyWith({
    bool? checked,
    String? label,
    String? description,
    ComponentSize? size,
    ColorVariant? color,
    bool? disabled,
    void Function(bool)? onChanged,
  }) {
    return CheckboxProps(
      checked: checked ?? this.checked,
      label: label ?? this.label,
      description: description ?? this.description,
      size: size ?? this.size,
      color: color ?? this.color,
      disabled: disabled ?? this.disabled,
      onChanged: onChanged ?? this.onChanged,
    );
  }
}

// ============================================================================
// RENDERER CONTRACT
// ============================================================================

/// Mixin defining the renderer method for checkbox components.
mixin CheckboxRendererContract {
  /// Render a checkbox component.
  Component checkbox(CheckboxProps props);
}
