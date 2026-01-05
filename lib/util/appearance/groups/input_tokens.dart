import '../tokens/border_weight.dart';
import '../tokens/component_shape.dart';
import '../tokens/shadow_intensity.dart';

/// Tokens for input elements (text inputs, selects, textareas, comboboxes).
///
/// These tokens control the visual appearance of form input components,
/// allowing stylesheets to define consistent input field styling.
class InputTokens {
  /// Border radius shape for inputs
  final ComponentShape shape;

  /// Custom radius value (used when shape is ComponentShape.custom)
  final String? customRadius;

  /// Border weight
  final BorderWeight borderWeight;

  /// Focus shadow intensity
  final ShadowIntensity focusShadow;

  /// Whether inputs use filled style by default
  final bool filledByDefault;

  /// Raw CSS escape hatch
  final Map<String, String>? rawStyles;

  /// Raw CSS escape hatch for focus state
  final Map<String, String>? rawFocusStyles;

  const InputTokens({
    this.shape = ComponentShape.rounded,
    this.customRadius,
    this.borderWeight = BorderWeight.standard,
    this.focusShadow = ShadowIntensity.subtle,
    this.filledByDefault = false,
    this.rawStyles,
    this.rawFocusStyles,
  });

  /// Create a copy with modified values
  InputTokens copyWith({
    ComponentShape? shape,
    String? customRadius,
    BorderWeight? borderWeight,
    ShadowIntensity? focusShadow,
    bool? filledByDefault,
    Map<String, String>? rawStyles,
    Map<String, String>? rawFocusStyles,
  }) {
    return InputTokens(
      shape: shape ?? this.shape,
      customRadius: customRadius ?? this.customRadius,
      borderWeight: borderWeight ?? this.borderWeight,
      focusShadow: focusShadow ?? this.focusShadow,
      filledByDefault: filledByDefault ?? this.filledByDefault,
      rawStyles: rawStyles ?? this.rawStyles,
      rawFocusStyles: rawFocusStyles ?? this.rawFocusStyles,
    );
  }
}
