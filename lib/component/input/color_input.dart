import 'package:jaspr/jaspr.dart';

import '../../core/theme_provider.dart';

export '../../core/props/color_input_props.dart' show ColorInputSize, ColorInputProps;

/// Color picker/input component with swatch preview and hex input.
///
/// Uses native color picker with custom styling for consistent appearance.
///
/// ```dart
/// ArcaneColorInput(
///   value: '#10b981',
///   onChanged: (color) => print(color),
/// )
/// ```
class ArcaneColorInput extends StatelessComponent {
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

  const ArcaneColorInput({
    required this.value,
    this.onChanged,
    this.size = ColorInputSize.md,
    this.disabled = false,
    this.label,
    this.presets,
    this.showHexInput = true,
    this.id,
    this.attributes,
    super.key,
  });

  /// Common color presets
  static const List<String> defaultPresets = ColorInputProps.defaultPresets;

  @override
  Component build(BuildContext context) {
    return context.renderers.colorInput(ColorInputProps(
      value: value,
      onChanged: onChanged,
      size: size,
      disabled: disabled,
      label: label,
      presets: presets,
      showHexInput: showHexInput,
      id: id,
      attributes: attributes,
    ));
  }
}
