import 'package:jaspr/jaspr.dart';
import '../interaction/interaction.dart';
import '../shared/shared.dart';

export '../shared/shared.dart' show ComponentSize, ColorVariant;

/// Toggle switch component properties.
class ToggleSwitchProps {
  final String id;
  final bool value;
  final void Function(bool)? onChanged;
  final ArcaneInteraction? onChangeAction;
  final bool disabled;
  final ComponentSize size;
  final ColorVariant color;
  final String? label;
  final bool labelLeft;
  final String? group;
  final String? itemValue;

  const ToggleSwitchProps({
    required this.id,
    required this.value,
    this.onChanged,
    this.onChangeAction,
    this.disabled = false,
    this.size = ComponentSize.md,
    this.color = ColorVariant.primary,
    this.label,
    this.labelLeft = false,
    this.group,
    this.itemValue,
  });

  ToggleSwitchProps copyWith({
    String? id,
    bool? value,
    void Function(bool)? onChanged,
    ArcaneInteraction? onChangeAction,
    bool? disabled,
    ComponentSize? size,
    ColorVariant? color,
    String? label,
    bool? labelLeft,
    String? group,
    String? itemValue,
  }) {
    return ToggleSwitchProps(
      id: id ?? this.id,
      value: value ?? this.value,
      onChanged: onChanged ?? this.onChanged,
      onChangeAction: onChangeAction ?? this.onChangeAction,
      disabled: disabled ?? this.disabled,
      size: size ?? this.size,
      color: color ?? this.color,
      label: label ?? this.label,
      labelLeft: labelLeft ?? this.labelLeft,
      group: group ?? this.group,
      itemValue: itemValue ?? this.itemValue,
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
