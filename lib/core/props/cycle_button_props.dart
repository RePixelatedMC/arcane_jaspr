import 'package:jaspr/jaspr.dart';

/// Cycle button size variants.
enum CycleButtonSize {
  /// Small button
  small,

  /// Medium button (default)
  medium,

  /// Large button
  large,

  /// Icon-only button
  icon,

  /// Small icon button
  iconSmall,

  /// Large icon button
  iconLarge,
}

/// Cycle button style variants.
enum CycleButtonVariant {
  /// Default/outline style
  outline,

  /// Primary/filled style
  primary,

  /// Secondary style
  secondary,

  /// Ghost/transparent style
  ghost,

  /// Destructive style
  destructive,
}

/// An option for cycle button.
class CycleOption<T> {
  /// The value this option represents
  final T value;

  /// Optional display label
  final String? label;

  /// Optional icon
  final Component? icon;

  const CycleOption({
    required this.value,
    this.label,
    this.icon,
  });
}

/// Properties for cycle button components.
class CycleButtonProps<T> {
  /// The available options
  final List<CycleOption<T>> options;

  /// The current value
  final T value;

  /// Callback when value changes
  final void Function(T value)? onChanged;

  /// Style variant
  final CycleButtonVariant variant;

  /// Button size
  final CycleButtonSize size;

  /// Whether the button is disabled
  final bool disabled;

  /// Optional element ID
  final String? id;

  /// Additional HTML attributes
  final Map<String, String>? attributes;

  const CycleButtonProps({
    required this.options,
    required this.value,
    this.onChanged,
    this.variant = CycleButtonVariant.outline,
    this.size = CycleButtonSize.medium,
    this.disabled = false,
    this.id,
    this.attributes,
  });

  /// Create a copy with modified properties
  CycleButtonProps<T> copyWith({
    List<CycleOption<T>>? options,
    T? value,
    void Function(T value)? onChanged,
    CycleButtonVariant? variant,
    CycleButtonSize? size,
    bool? disabled,
    String? id,
    Map<String, String>? attributes,
  }) {
    return CycleButtonProps<T>(
      options: options ?? this.options,
      value: value ?? this.value,
      onChanged: onChanged ?? this.onChanged,
      variant: variant ?? this.variant,
      size: size ?? this.size,
      disabled: disabled ?? this.disabled,
      id: id ?? this.id,
      attributes: attributes ?? this.attributes,
    );
  }
}

/// Properties for toggle button components.
class ToggleButtonProps {
  /// Whether the button is pressed/active
  final bool value;

  /// Callback when value changes
  final void Function(bool value)? onChanged;

  /// Optional label text
  final String? label;

  /// Optional icon
  final Component? icon;

  /// Button size
  final CycleButtonSize size;

  /// Whether the button is disabled
  final bool disabled;

  /// Optional element ID
  final String? id;

  /// Additional HTML attributes
  final Map<String, String>? attributes;

  const ToggleButtonProps({
    required this.value,
    this.onChanged,
    this.label,
    this.icon,
    this.size = CycleButtonSize.medium,
    this.disabled = false,
    this.id,
    this.attributes,
  });

  /// Create a copy with modified properties
  ToggleButtonProps copyWith({
    bool? value,
    void Function(bool value)? onChanged,
    String? label,
    Component? icon,
    CycleButtonSize? size,
    bool? disabled,
    String? id,
    Map<String, String>? attributes,
  }) {
    return ToggleButtonProps(
      value: value ?? this.value,
      onChanged: onChanged ?? this.onChanged,
      label: label ?? this.label,
      icon: icon ?? this.icon,
      size: size ?? this.size,
      disabled: disabled ?? this.disabled,
      id: id ?? this.id,
      attributes: attributes ?? this.attributes,
    );
  }
}
