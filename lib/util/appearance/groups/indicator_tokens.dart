import '../tokens/animation_preset.dart';
import '../tokens/border_weight.dart';
import '../tokens/component_shape.dart';

/// Tokens for indicator elements (checkboxes, radios, toggle switches).
///
/// These tokens control the visual appearance of selection indicator components,
/// allowing stylesheets to define radically different indicator styles
/// (e.g., circular radios vs square radios, circular thumbs vs rounded-square thumbs).
class IndicatorTokens {
  // ===========================================================================
  // CHECKBOX
  // ===========================================================================

  /// Shape for checkbox indicators
  final ComponentShape checkboxShape;

  /// Custom radius for checkbox (used when shape is ComponentShape.custom)
  final String? checkboxCustomRadius;

  /// Border weight for checkboxes (unchecked state)
  final BorderWeight checkboxBorder;

  // ===========================================================================
  // RADIO
  // ===========================================================================

  /// Shape for radio indicators (can be circle, rounded, or even sharp!)
  final ComponentShape radioShape;

  /// Custom radius for radio (used when shape is ComponentShape.custom)
  final String? radioCustomRadius;

  /// Border weight for radios (unchecked state)
  final BorderWeight radioBorder;

  // ===========================================================================
  // TOGGLE SWITCH
  // ===========================================================================

  /// Shape for toggle switch track
  final ComponentShape toggleTrackShape;

  /// Custom radius for toggle track (used when shape is ComponentShape.custom)
  final String? toggleTrackCustomRadius;

  /// Shape for toggle switch thumb
  final ComponentShape toggleThumbShape;

  /// Custom radius for toggle thumb (used when shape is ComponentShape.custom)
  final String? toggleThumbCustomRadius;

  /// Whether toggle thumb should have shadow
  final bool thumbShadow;

  // ===========================================================================
  // TOGGLE THUMB COLOR STATES
  // ===========================================================================

  /// Thumb color when toggle is ON
  final String thumbOnColor;

  /// Thumb color when toggle is OFF
  final String thumbOffColor;

  /// Track color when toggle is ON
  final String trackOnColor;

  /// Track color when toggle is OFF
  final String trackOffColor;

  // ===========================================================================
  // CHECKED STATE STYLING
  // ===========================================================================

  /// Whether to use gradient fill when checked
  final bool useGradientFill;

  /// Animation preset for check/select animation
  final AnimationPreset checkAnimation;

  // ===========================================================================
  // RAW CSS
  // ===========================================================================

  /// Raw CSS escape hatch for checkbox
  final Map<String, String>? rawCheckboxStyles;

  /// Raw CSS escape hatch for radio
  final Map<String, String>? rawRadioStyles;

  /// Raw CSS escape hatch for toggle
  final Map<String, String>? rawToggleStyles;

  const IndicatorTokens({
    // Checkbox
    this.checkboxShape = ComponentShape.rounded,
    this.checkboxCustomRadius,
    this.checkboxBorder = BorderWeight.medium,
    // Radio
    this.radioShape = ComponentShape.circle,
    this.radioCustomRadius,
    this.radioBorder = BorderWeight.medium,
    // Toggle track
    this.toggleTrackShape = ComponentShape.pill,
    this.toggleTrackCustomRadius,
    // Toggle thumb
    this.toggleThumbShape = ComponentShape.circle,
    this.toggleThumbCustomRadius,
    this.thumbShadow = true,
    // Toggle colors
    this.thumbOnColor = 'var(--arcane-background)',
    this.thumbOffColor = 'var(--arcane-background)',
    this.trackOnColor = 'var(--arcane-primary)',
    this.trackOffColor = 'var(--arcane-input)',
    // Checked state
    this.useGradientFill = false,
    this.checkAnimation = AnimationPreset.none,
    // Raw CSS
    this.rawCheckboxStyles,
    this.rawRadioStyles,
    this.rawToggleStyles,
  });

  /// Create a copy with modified values
  IndicatorTokens copyWith({
    // Checkbox
    ComponentShape? checkboxShape,
    String? checkboxCustomRadius,
    BorderWeight? checkboxBorder,
    // Radio
    ComponentShape? radioShape,
    String? radioCustomRadius,
    BorderWeight? radioBorder,
    // Toggle track
    ComponentShape? toggleTrackShape,
    String? toggleTrackCustomRadius,
    // Toggle thumb
    ComponentShape? toggleThumbShape,
    String? toggleThumbCustomRadius,
    bool? thumbShadow,
    // Toggle colors
    String? thumbOnColor,
    String? thumbOffColor,
    String? trackOnColor,
    String? trackOffColor,
    // Checked state
    bool? useGradientFill,
    AnimationPreset? checkAnimation,
    // Raw CSS
    Map<String, String>? rawCheckboxStyles,
    Map<String, String>? rawRadioStyles,
    Map<String, String>? rawToggleStyles,
  }) {
    return IndicatorTokens(
      checkboxShape: checkboxShape ?? this.checkboxShape,
      checkboxCustomRadius: checkboxCustomRadius ?? this.checkboxCustomRadius,
      checkboxBorder: checkboxBorder ?? this.checkboxBorder,
      radioShape: radioShape ?? this.radioShape,
      radioCustomRadius: radioCustomRadius ?? this.radioCustomRadius,
      radioBorder: radioBorder ?? this.radioBorder,
      toggleTrackShape: toggleTrackShape ?? this.toggleTrackShape,
      toggleTrackCustomRadius:
          toggleTrackCustomRadius ?? this.toggleTrackCustomRadius,
      toggleThumbShape: toggleThumbShape ?? this.toggleThumbShape,
      toggleThumbCustomRadius:
          toggleThumbCustomRadius ?? this.toggleThumbCustomRadius,
      thumbShadow: thumbShadow ?? this.thumbShadow,
      thumbOnColor: thumbOnColor ?? this.thumbOnColor,
      thumbOffColor: thumbOffColor ?? this.thumbOffColor,
      trackOnColor: trackOnColor ?? this.trackOnColor,
      trackOffColor: trackOffColor ?? this.trackOffColor,
      useGradientFill: useGradientFill ?? this.useGradientFill,
      checkAnimation: checkAnimation ?? this.checkAnimation,
      rawCheckboxStyles: rawCheckboxStyles ?? this.rawCheckboxStyles,
      rawRadioStyles: rawRadioStyles ?? this.rawRadioStyles,
      rawToggleStyles: rawToggleStyles ?? this.rawToggleStyles,
    );
  }
}
