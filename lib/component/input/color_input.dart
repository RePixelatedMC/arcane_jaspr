import 'package:jaspr/jaspr.dart';

import '../../core/theme_provider.dart';

export '../../core/props/color_input_props.dart' show ComponentSize, ColorInputProps;

/// Color picker/input component with swatch preview and hex input.
class ArcaneColorInput extends StatelessComponent {
  final String value;
  final void Function(String color)? onChanged;
  final ComponentSize size;
  final bool disabled;
  final String? label;
  final List<String>? presets;
  final bool showHexInput;
  final String? id;
  final Map<String, String>? attributes;

  const ArcaneColorInput({
    required this.value,
    this.onChanged,
    this.size = ComponentSize.md,
    this.disabled = false,
    this.label,
    this.presets,
    this.showHexInput = true,
    this.id,
    this.attributes,
    super.key,
  });

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
