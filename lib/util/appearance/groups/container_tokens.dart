import '../tokens/border_weight.dart';
import '../tokens/component_shape.dart';
import '../tokens/shadow_intensity.dart';

/// Tokens for container elements (cards, dialogs, sheets, panels).
///
/// These tokens control the visual appearance of container components,
/// allowing stylesheets to define consistent card/dialog styling.
class ContainerTokens {
  /// Border radius shape for containers
  final ComponentShape shape;

  /// Custom radius value (used when shape is ComponentShape.custom)
  final String? customRadius;

  /// Default shadow intensity
  final ShadowIntensity shadow;

  /// Border weight
  final BorderWeight borderWeight;

  /// Whether to use backdrop blur (glass effect)
  final bool useBackdropBlur;

  /// Backdrop blur amount
  final String backdropBlur;

  /// Surface opacity for glass effects (0.0 to 1.0)
  final double surfaceOpacity;

  /// Raw CSS escape hatch
  final Map<String, String>? rawStyles;

  const ContainerTokens({
    this.shape = ComponentShape.rounded,
    this.customRadius,
    this.shadow = ShadowIntensity.standard,
    this.borderWeight = BorderWeight.standard,
    this.useBackdropBlur = false,
    this.backdropBlur = '12px',
    this.surfaceOpacity = 1.0,
    this.rawStyles,
  });

  /// Create a copy with modified values
  ContainerTokens copyWith({
    ComponentShape? shape,
    String? customRadius,
    ShadowIntensity? shadow,
    BorderWeight? borderWeight,
    bool? useBackdropBlur,
    String? backdropBlur,
    double? surfaceOpacity,
    Map<String, String>? rawStyles,
  }) {
    return ContainerTokens(
      shape: shape ?? this.shape,
      customRadius: customRadius ?? this.customRadius,
      shadow: shadow ?? this.shadow,
      borderWeight: borderWeight ?? this.borderWeight,
      useBackdropBlur: useBackdropBlur ?? this.useBackdropBlur,
      backdropBlur: backdropBlur ?? this.backdropBlur,
      surfaceOpacity: surfaceOpacity ?? this.surfaceOpacity,
      rawStyles: rawStyles ?? this.rawStyles,
    );
  }
}
