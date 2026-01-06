import 'package:jaspr/jaspr.dart';

export '../../core/props/radio_group_props.dart'
    show RadioGroupLayout, RadioGroupVariant, RadioOptionProps;

import '../../core/props/radio_group_props.dart';
import '../../core/theme_provider.dart';

/// Radio button option model
class RadioOption<T> {
  /// Unique value for this option
  final T value;

  /// Display label
  final String label;

  /// Optional description text
  final String? description;

  /// Whether this option is disabled
  final bool disabled;

  /// Optional icon
  final Component? icon;

  const RadioOption({
    required this.value,
    required this.label,
    this.description,
    this.disabled = false,
    this.icon,
  });
}

/// A radio button group component matching shadcn/ui
/// Reference: https://ui.shadcn.com/docs/components/radio-group
///
/// ShadCN Radio Group:
/// - Radio: h-4 w-4 (16px), rounded-full, border border-primary
/// - Selected: inner dot h-2.5 w-2.5 (10px), bg-primary
/// - Focus: ring-2 ring-ring ring-offset-2
/// - Disabled: opacity-50, cursor-not-allowed
///
/// Usage:
/// ```dart
/// ArcaneRadioGroup<String>(
///   value: selectedValue,
///   options: [
///     RadioOption(value: 'a', label: 'Option A'),
///     RadioOption(value: 'b', label: 'Option B'),
///     RadioOption(value: 'c', label: 'Option C'),
///   ],
///   onChanged: (value) => setState(() => selectedValue = value),
/// )
/// ```
class ArcaneRadioGroup<T> extends StatelessComponent {
  /// Currently selected value
  final T? value;

  /// List of radio options
  final List<RadioOption<T>> options;

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

  const ArcaneRadioGroup({
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
    super.key,
  });

  @override
  Component build(BuildContext context) {
    // Map RadioOption to RadioOptionProps for the renderer
    final List<RadioOptionProps<T>> optionProps = options
        .map((opt) => RadioOptionProps<T>(
              value: opt.value,
              label: opt.label,
              description: opt.description,
              disabled: opt.disabled,
              icon: opt.icon,
            ))
        .toList();

    // Delegate to the current stylesheet's radio group renderer
    return context.renderers.radioGroup<T>(RadioGroupProps<T>(
      value: value,
      options: optionProps,
      onChanged: onChanged,
      name: name,
      layout: layout,
      variant: variant,
      disabled: disabled,
      label: label,
      helperText: helperText,
      error: error,
      required: required,
      gap: gap,
      gridColumns: gridColumns,
    ));
  }
}