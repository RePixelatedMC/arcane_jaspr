library;

/// Color themes for Neon stylesheet.
///
/// Each theme defines a primary accent color and supporting light-mode surfaces.
enum NeonTheme {
  /// Emerald green - #10b981
  /// Light mode: Bold mint surfaces
  green(
    color: 0xFF00f5a0,
    lightSecondary: 0xFFe8edf1,
    lightAccent: 0xFFdce9ec,
    lightBorder: 0xFFb6c8cf,
  ),

  /// Bright red - #ef4444
  /// Light mode: Bold coral/rose surfaces
  red(
    color: 0xFFef4444,
    lightSecondary: 0xFFfee2e2,
    lightAccent: 0xFFfecaca,
    lightBorder: 0xFFfca5a5,
  ),

  /// Electric blue - #3b82f6
  /// Light mode: Bold sky blue surfaces
  blue(
    color: 0xFF00d9ff,
    lightSecondary: 0xFFd8fbff,
    lightAccent: 0xFFb6f4ff,
    lightBorder: 0xFF67e8f9,
  ),

  /// Vibrant purple - #8b5cf6
  /// Light mode: Bold lavender surfaces
  purple(
    color: 0xFF8b5cf6,
    lightSecondary: 0xFFede9fe,
    lightAccent: 0xFFddd6fe,
    lightBorder: 0xFFc4b5fd,
  ),

  /// Neon cyan - #22d3ee
  /// Light mode: Bold aqua surfaces
  cyan(
    color: 0xFF00e5ff,
    lightSecondary: 0xFFe7edf2,
    lightAccent: 0xFFdaeaf0,
    lightBorder: 0xFFa7c7d1,
  ),

  /// Hot pink - #ec4899
  /// Light mode: Bold pink surfaces
  pink(
    color: 0xFFff2bd6,
    lightSecondary: 0xFFfce7f3,
    lightAccent: 0xFFfbcfe8,
    lightBorder: 0xFFf9a8d4,
  ),

  /// Bright orange - #f97316
  /// Light mode: Bold peach/amber surfaces
  orange(
    color: 0xFFf97316,
    lightSecondary: 0xFFffedd5,
    lightAccent: 0xFFfed7aa,
    lightBorder: 0xFFfdba74,
  ),

  /// Rainbow RGB spin - cycles through all colors.
  /// Uses cyan as the base color, with CSS animation override.
  rainbow(
    color: 0xFF00e5ff,
    lightSecondary: 0xFFe7edf2,
    lightAccent: 0xFFdaeaf0,
    lightBorder: 0xFFa7c7d1,
  );

  /// The primary accent color for this theme.
  final int color;

  /// Light mode secondary surface color (cards, elevated surfaces).
  final int lightSecondary;

  /// Light mode accent surface color (hover states, interactive).
  final int lightAccent;

  /// Light mode border color.
  final int lightBorder;

  const NeonTheme({
    required this.color,
    required this.lightSecondary,
    required this.lightAccent,
    required this.lightBorder,
  });
}
