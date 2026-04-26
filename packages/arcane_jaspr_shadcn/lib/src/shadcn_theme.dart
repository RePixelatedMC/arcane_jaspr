library;

/// Color themes for ShadCN stylesheet.
///
/// Each theme defines colors for both light and dark modes.
/// For neutral themes, light secondary/accent are null to allow
/// the palette generator to derive them with primary hue tinting.
enum ShadcnTheme {
  // ============================================
  // Neutral Themes (auto-tinted light surfaces)
  // ============================================

  /// OLED-optimized with pure black/white.
  /// Maximum contrast, perfect for AMOLED screens.
  /// Light mode surfaces are auto-tinted with the primary color.
  midnight(
    // Light: pure white background, near-black primary
    // Secondary/accent derived with subtle primary tinting
    lightBackground: 0xFFffffff,
    lightPrimary: 0xFF09090b,
    // Dark: pure black background, near-white primary
    darkBackground: 0xFF000000,
    darkPrimary: 0xFFfafafa,
    darkSecondary: 0xFF151515,
    darkAccent: 0xFF151515,
  ),

  /// Softer dark theme with off-black.
  /// Easier on the eyes in dark environments.
  charcoal(
    // Light: soft white background with auto-tinted surfaces
    lightBackground: 0xFFfafafa,
    lightPrimary: 0xFF18181b,
    // Dark: off-black background (easier on eyes)
    darkBackground: 0xFF0a0a0a,
    darkPrimary: 0xFFfafafa,
    darkSecondary: 0xFF1a1a1a,
    darkAccent: 0xFF262626,
  ),

  /// Warm cream/ivory tones.
  /// Reduces eye strain with warmer whites.
  cream(
    // Light: warm ivory background
    lightBackground: 0xFFfefdfb,
    lightPrimary: 0xFF78716c, // Warm stone primary for cohesive tinting
    // Dark: warm dark brown
    darkBackground: 0xFF0c0a09,
    darkPrimary: 0xFFfafaf9,
    darkSecondary: 0xFF1c1917,
    darkAccent: 0xFF292524,
  ),

  /// Cool slate/gray tones.
  /// Professional, neutral appearance.
  slate(
    // Light: cool gray-white with slate tinting
    lightBackground: 0xFFf8fafc,
    lightPrimary: 0xFF475569, // Slate primary for cool tinting
    // Dark: deep slate
    darkBackground: 0xFF020617,
    darkPrimary: 0xFFf8fafc,
    darkSecondary: 0xFF0f172a,
    darkAccent: 0xFF1e293b,
  ),

  // ============================================
  // Pastel Themes (richer colored surfaces)
  // ============================================

  /// Rose/pink theme.
  /// Warm, elegant, with visible rose surfaces.
  rose(
    // Light: clean white with rich rose-tinted surfaces
    lightBackground: 0xFFffffff,
    lightPrimary: 0xFFe11d48, // Vibrant rose
    lightSecondary: 0xFFfce7f3, // Rich pink surface
    lightAccent: 0xFFfbcfe8, // Deeper pink for interaction
    // Dark: deep rose
    darkBackground: 0xFF0f0506,
    darkPrimary: 0xFFfda4af,
    darkSecondary: 0xFF1f0a0d,
    darkAccent: 0xFF4c0519,
  ),

  /// Lavender/purple theme.
  /// Calming and creative with visible purple surfaces.
  lavender(
    // Light: clean white with rich lavender-tinted surfaces
    lightBackground: 0xFFffffff,
    lightPrimary: 0xFF9333ea, // Vibrant purple
    lightSecondary: 0xFFede9fe, // Rich lavender surface
    lightAccent: 0xFFddd6fe, // Deeper lavender for interaction
    // Dark: deep purple
    darkBackground: 0xFF09050f,
    darkPrimary: 0xFFd8b4fe,
    darkSecondary: 0xFF1a0a2e,
    darkAccent: 0xFF3b0764,
  ),

  /// Mint/green theme.
  /// Fresh and natural with visible green surfaces.
  mint(
    // Light: clean white with rich mint-tinted surfaces
    lightBackground: 0xFFffffff,
    lightPrimary: 0xFF16a34a, // Vibrant green
    lightSecondary: 0xFFdcfce7, // Rich mint surface
    lightAccent: 0xFFbbf7d0, // Deeper mint for interaction
    // Dark: deep forest
    darkBackground: 0xFF030f07,
    darkPrimary: 0xFF86efac,
    darkSecondary: 0xFF052e16,
    darkAccent: 0xFF14532d,
  ),

  /// Sky/blue theme.
  /// Clean and professional with visible blue surfaces.
  sky(
    // Light: clean white with rich sky-tinted surfaces
    lightBackground: 0xFFffffff,
    lightPrimary: 0xFF0284c7, // Vibrant sky blue
    lightSecondary: 0xFFe0f2fe, // Rich sky surface
    lightAccent: 0xFFbae6fd, // Deeper blue for interaction
    // Dark: deep ocean
    darkBackground: 0xFF030a0f,
    darkPrimary: 0xFF7dd3fc,
    darkSecondary: 0xFF0c1929,
    darkAccent: 0xFF0c4a6e,
  ),

  /// Peach/orange theme.
  /// Warm and energetic with visible orange surfaces.
  peach(
    // Light: clean white with rich peach-tinted surfaces
    lightBackground: 0xFFffffff,
    lightPrimary: 0xFFea580c, // Vibrant orange
    lightSecondary: 0xFFffedd5, // Rich peach surface
    lightAccent: 0xFFfed7aa, // Deeper orange for interaction
    // Dark: deep amber
    darkBackground: 0xFF0f0803,
    darkPrimary: 0xFFfdba74,
    darkSecondary: 0xFF1c0f05,
    darkAccent: 0xFF7c2d12,
  ),

  /// Teal/cyan theme.
  /// Modern and vibrant with visible teal surfaces.
  teal(
    // Light: clean white with rich teal-tinted surfaces
    lightBackground: 0xFFffffff,
    lightPrimary: 0xFF0d9488, // Vibrant teal
    lightSecondary: 0xFFccfbf1, // Rich teal surface
    lightAccent: 0xFF99f6e4, // Deeper teal for interaction
    // Dark: deep teal
    darkBackground: 0xFF030f0e,
    darkPrimary: 0xFF5eead4,
    darkSecondary: 0xFF042f2e,
    darkAccent: 0xFF134e4a,
  );

  /// Light mode background color.
  final int lightBackground;

  /// Light mode primary color (used for tinting and interactive elements).
  final int lightPrimary;

  /// Light mode secondary color. If null, derived with primary tinting.
  final int? lightSecondary;

  /// Light mode accent color. If null, derived with primary tinting.
  final int? lightAccent;

  /// Dark mode background color.
  final int darkBackground;

  /// Dark mode primary color.
  final int darkPrimary;

  /// Dark mode secondary color.
  final int darkSecondary;

  /// Dark mode accent color.
  final int darkAccent;

  const ShadcnTheme({
    required this.lightBackground,
    required this.lightPrimary,
    this.lightSecondary,
    this.lightAccent,
    required this.darkBackground,
    required this.darkPrimary,
    required this.darkSecondary,
    required this.darkAccent,
  });
}
