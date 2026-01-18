import 'package:jaspr/jaspr.dart';

enum ColorInputSize {
  sm,
  md,
  lg,
}

/// Color input component properties.
class ColorInputProps {
  final String value;
  final void Function(String color)? onChanged;
  final ColorInputSize size;
  final bool disabled;
  final String? label;
  final List<String>? presets;
  final bool showHexInput;
  final String? id;
  final Map<String, String>? attributes;

  const ColorInputProps({
    required this.value,
    this.onChanged,
    this.size = ColorInputSize.md,
    this.disabled = false,
    this.label,
    this.presets,
    this.showHexInput = true,
    this.id,
    this.attributes,
  });

  static const List<String> defaultPresets = [
    '#ef4444',
    '#f97316',
    '#eab308',
    '#22c55e',
    '#14b8a6',
    '#3b82f6',
    '#8b5cf6',
    '#ec4899',
    '#6b7280',
    '#000000',
  ];

  ColorInputProps copyWith({
    String? value,
    void Function(String color)? onChanged,
    ColorInputSize? size,
    bool? disabled,
    String? label,
    List<String>? presets,
    bool? showHexInput,
    String? id,
    Map<String, String>? attributes,
  }) {
    return ColorInputProps(
      value: value ?? this.value,
      onChanged: onChanged ?? this.onChanged,
      size: size ?? this.size,
      disabled: disabled ?? this.disabled,
      label: label ?? this.label,
      presets: presets ?? this.presets,
      showHexInput: showHexInput ?? this.showHexInput,
      id: id ?? this.id,
      attributes: attributes ?? this.attributes,
    );
  }
}

// ============================================================================
// RENDERER CONTRACT
// ============================================================================

/// Mixin defining the renderer method for color input components.
mixin ColorInputRendererContract {
  /// Render a color input component.
  Component colorInput(ColorInputProps props);
}
