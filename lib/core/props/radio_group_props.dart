import 'package:jaspr/jaspr.dart';

enum RadioGroupLayout {
  vertical,
  horizontal,
  grid,
}

enum RadioGroupVariant {
  standard,
  cards,
  buttons,
  chips,
}

/// Radio option data.
class RadioOptionProps<T> {
  final T value;
  final String label;
  final String? description;
  final bool disabled;
  final Component? icon;

  const RadioOptionProps({
    required this.value,
    required this.label,
    this.description,
    this.disabled = false,
    this.icon,
  });
}

/// Radio group component properties.
class RadioGroupProps<T> {
  final T? value;
  final List<RadioOptionProps<T>> options;
  final void Function(T value)? onChanged;
  final String? name;
  final RadioGroupLayout layout;
  final RadioGroupVariant variant;
  final bool disabled;
  final String? label;
  final String? helperText;
  final String? error;
  final bool required;
  final String gap;
  final int gridColumns;

  const RadioGroupProps({
    required this.options,
    this.value,
    this.onChanged,
    this.name,
    this.layout = RadioGroupLayout.vertical,
    this.variant = RadioGroupVariant.standard,
    this.disabled = false,
    this.label,
    this.helperText,
    this.error,
    this.required = false,
    this.gap = '0.5rem',
    this.gridColumns = 2,
  });

  RadioGroupProps<T> copyWith({
    T? value,
    List<RadioOptionProps<T>>? options,
    void Function(T value)? onChanged,
    String? name,
    RadioGroupLayout? layout,
    RadioGroupVariant? variant,
    bool? disabled,
    String? label,
    String? helperText,
    String? error,
    bool? required,
    String? gap,
    int? gridColumns,
  }) {
    return RadioGroupProps<T>(
      value: value ?? this.value,
      options: options ?? this.options,
      onChanged: onChanged ?? this.onChanged,
      name: name ?? this.name,
      layout: layout ?? this.layout,
      variant: variant ?? this.variant,
      disabled: disabled ?? this.disabled,
      label: label ?? this.label,
      helperText: helperText ?? this.helperText,
      error: error ?? this.error,
      required: required ?? this.required,
      gap: gap ?? this.gap,
      gridColumns: gridColumns ?? this.gridColumns,
    );
  }
}

// ============================================================================
// RENDERER CONTRACT
// ============================================================================

/// Mixin defining the renderer method for radio group components.
mixin RadioGroupRendererContract {
  /// Render a radio group component.
  Component radioGroup<T>(RadioGroupProps<T> props);
}
