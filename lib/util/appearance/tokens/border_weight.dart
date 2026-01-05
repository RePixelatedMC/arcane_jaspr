/// Border weight presets for components.
///
/// Used by stylesheets to define border thickness.
enum BorderWeight {
  /// No border (0px)
  none,

  /// Hairline border (0.5px or 1px)
  hairline,

  /// Standard border (1px)
  standard,

  /// Medium border (2px)
  medium,

  /// Heavy border (3px)
  heavy,
}

/// Extension to convert BorderWeight to CSS values
extension BorderWeightExtension on BorderWeight {
  /// CSS border-width value
  String get css => switch (this) {
        BorderWeight.none => '0',
        BorderWeight.hairline => '1px',
        BorderWeight.standard => '1px',
        BorderWeight.medium => '2px',
        BorderWeight.heavy => '3px',
      };
}
