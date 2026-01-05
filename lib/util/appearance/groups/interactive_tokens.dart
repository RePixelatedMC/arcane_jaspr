import '../tokens/animation_preset.dart';
import '../tokens/border_weight.dart';
import '../tokens/component_shape.dart';
import '../tokens/shadow_intensity.dart';

/// Tokens for interactive elements (buttons, toggles, clickable items).
///
/// These tokens control the visual appearance of all interactive components,
/// allowing stylesheets to define a consistent look for clickable elements.
class InteractiveTokens {
  /// Border radius shape for interactive elements
  final ComponentShape shape;

  /// Custom radius value (used when shape is ComponentShape.custom)
  final String? customRadius;

  /// Shadow intensity on hover/active states
  final ShadowIntensity hoverShadow;

  /// Border weight
  final BorderWeight borderWeight;

  /// Whether to use gradient backgrounds
  final bool useGradients;

  /// Animation preset for hover effects
  final AnimationPreset hoverAnimation;

  /// Focus ring width
  final String focusRingWidth;

  /// Focus ring offset
  final String focusRingOffset;

  /// Raw CSS escape hatch for base state
  final Map<String, String>? rawBaseStyles;

  /// Raw CSS escape hatch for hover state
  final Map<String, String>? rawHoverStyles;

  /// Raw CSS escape hatch for active state
  final Map<String, String>? rawActiveStyles;

  const InteractiveTokens({
    this.shape = ComponentShape.rounded,
    this.customRadius,
    this.hoverShadow = ShadowIntensity.subtle,
    this.borderWeight = BorderWeight.standard,
    this.useGradients = false,
    this.hoverAnimation = AnimationPreset.none,
    this.focusRingWidth = '2px',
    this.focusRingOffset = '2px',
    this.rawBaseStyles,
    this.rawHoverStyles,
    this.rawActiveStyles,
  });

  /// Create a copy with modified values
  InteractiveTokens copyWith({
    ComponentShape? shape,
    String? customRadius,
    ShadowIntensity? hoverShadow,
    BorderWeight? borderWeight,
    bool? useGradients,
    AnimationPreset? hoverAnimation,
    String? focusRingWidth,
    String? focusRingOffset,
    Map<String, String>? rawBaseStyles,
    Map<String, String>? rawHoverStyles,
    Map<String, String>? rawActiveStyles,
  }) {
    return InteractiveTokens(
      shape: shape ?? this.shape,
      customRadius: customRadius ?? this.customRadius,
      hoverShadow: hoverShadow ?? this.hoverShadow,
      borderWeight: borderWeight ?? this.borderWeight,
      useGradients: useGradients ?? this.useGradients,
      hoverAnimation: hoverAnimation ?? this.hoverAnimation,
      focusRingWidth: focusRingWidth ?? this.focusRingWidth,
      focusRingOffset: focusRingOffset ?? this.focusRingOffset,
      rawBaseStyles: rawBaseStyles ?? this.rawBaseStyles,
      rawHoverStyles: rawHoverStyles ?? this.rawHoverStyles,
      rawActiveStyles: rawActiveStyles ?? this.rawActiveStyles,
    );
  }
}
