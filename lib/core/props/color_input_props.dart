/// Color input size variants.
enum ColorInputSize {
  /// Small size
  sm,

  /// Medium/default size
  md,

  /// Large size
  lg,
}

/// Properties for color input components.
///
/// This is the shared props class used by all stylesheet renderers.
class ColorInputProps {
  /// Current color value (hex string)
  final String value;

  /// Callback when color changes
  final void Function(String color)? onChanged;

  /// Size variant
  final ColorInputSize size;

  /// Whether the input is disabled
  final bool disabled;

  /// Label text
  final String? label;

  /// Preset color swatches
  final List<String>? presets;

  /// Whether to show the hex text input
  final bool showHexInput;

  /// Optional element ID
  final String? id;

  /// Additional HTML attributes
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

  /// Common color presets
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

  /// Create a copy with modified properties
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
