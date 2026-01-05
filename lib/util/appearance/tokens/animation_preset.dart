/// Animation presets for component interactions and transitions.
///
/// Used by stylesheets to define hover effects, transitions, and animations.
enum AnimationPreset {
  // ===========================================================================
  // HOVER EFFECTS
  // ===========================================================================

  /// No animation/effect
  none,

  /// Lift effect - translateY(-2px)
  lift,

  /// Scale effect - scale(1.02)
  scale,

  /// Subtle scale - scale(1.01)
  scaleSubtle,

  /// Glow effect - box-shadow glow
  glow,

  /// Glitch effect - cyberpunk style distortion
  glitch,

  /// Wiggle effect - sketchbook style wobble
  wiggle,

  /// Pop effect - comic book style bounce
  pop,

  // ===========================================================================
  // TRANSITION SPEEDS
  // ===========================================================================

  /// Instant transition (0ms)
  instant,

  /// Fast transition (100ms)
  fast,

  /// Normal transition (200ms)
  normal,

  /// Slow transition (300ms)
  slow,

  /// Bounce transition - elastic easing
  bounce,
}

/// Extension to convert AnimationPreset to CSS values
extension AnimationPresetExtension on AnimationPreset {
  /// CSS transform value for hover effects
  String? get transform => switch (this) {
        AnimationPreset.lift => 'translateY(-2px)',
        AnimationPreset.scale => 'scale(1.02)',
        AnimationPreset.scaleSubtle => 'scale(1.01)',
        AnimationPreset.pop => 'scale(1.05)',
        _ => null,
      };

  /// CSS transition duration
  String? get duration => switch (this) {
        AnimationPreset.instant => '0ms',
        AnimationPreset.fast => '100ms',
        AnimationPreset.normal => '200ms',
        AnimationPreset.slow => '300ms',
        AnimationPreset.bounce => '300ms',
        _ => null,
      };

  /// CSS easing function
  String? get easing => switch (this) {
        AnimationPreset.bounce => 'cubic-bezier(0.68, -0.55, 0.265, 1.55)',
        AnimationPreset.pop => 'cubic-bezier(0.34, 1.56, 0.64, 1)',
        _ => null,
      };
}
