import 'package:jaspr/jaspr.dart';

/// Radio group layout direction.
enum RadioGroupLayout {
  /// Vertical stack
  vertical,

  /// Horizontal row
  horizontal,

  /// Grid layout
  grid,
}

/// Radio group visual variant.
enum RadioGroupVariant {
  /// Standard radio buttons
  standard,

  /// Card-style selection (bordered cards)
  cards,

  /// Button group style (segmented control)
  buttons,

  /// Chip/pill style
  chips,
}

/// Radio option model for generic type T.
class RadioOptionProps<T> {
  /// Unique value for this option
  final T value;

  /// Display label
  final String label;

  /// Optional description text
  final String? description;

  /// Whether this option is disabled
  final bool disabled;

  /// Optional icon component
  final Component? icon;

  const RadioOptionProps({
    required this.value,
    required this.label,
    this.description,
    this.disabled = false,
    this.icon,
  });
}

/// Properties for radio group components.
class RadioGroupProps<T> {
  /// Currently selected value
  final T? value;

  /// List of radio options
  final List<RadioOptionProps<T>> options;

  /// Called when selection changes
  final void Function(T value)? onChanged;

  /// Group name (for HTML form association)
  final String? name;

  /// Layout direction
  final RadioGroupLayout layout;

  /// Visual variant
  final RadioGroupVariant variant;

  /// Whether the entire group is disabled
  final bool disabled;

  /// Label text above the group
  final String? label;

  /// Helper text below the group
  final String? helperText;

  /// Error message
  final String? error;

  /// Whether selection is required
  final bool required;

  /// Gap between items
  final String gap;

  /// Number of columns for grid layout
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

  /// Create a copy with modified properties
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
