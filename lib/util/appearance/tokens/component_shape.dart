/// Shape variants for components - maps to border-radius values.
///
/// Used by stylesheets to define the visual shape of component groups.
enum ComponentShape {
  /// Sharp corners (0-2px radius) - technical/industrial look
  sharp,

  /// Rounded corners (4-8px) - default/balanced look
  rounded,

  /// Soft rounded corners (10-16px) - friendly/approachable look
  softRounded,

  /// Pill/capsule shape (9999px) - for buttons, tags, badges
  pill,

  /// Perfect circle (50%) - for indicators, avatars
  circle,

  /// Custom radius - use customRadius parameter to specify value
  custom,
}

/// Extension to convert ComponentShape to CSS values
extension ComponentShapeExtension on ComponentShape {
  /// Default CSS value for this shape (can be overridden by stylesheet)
  String get defaultCss => switch (this) {
        ComponentShape.sharp => '2px',
        ComponentShape.rounded => '6px',
        ComponentShape.softRounded => '12px',
        ComponentShape.pill => '9999px',
        ComponentShape.circle => '50%',
        ComponentShape.custom => '0',
      };
}
