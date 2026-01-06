import '../../colors.dart';

/// Gray scale presets available for ShadCN stylesheet.
///
/// Each preset uses a different gray scale from the Tailwind CSS palette.
/// These affect all neutral colors in the theme (background, foreground,
/// card, border, muted, etc.)
enum ShadcnColorPreset {
  /// Pure grayscale with no color tint.
  /// Uses Tailwind's neutral palette (oklch with 0 saturation).
  neutral,

  /// Warm gray with subtle yellow/brown undertones.
  /// Uses Tailwind's stone palette.
  stone,

  /// Cool gray with subtle purple undertones.
  /// Uses Tailwind's zinc palette.
  zinc,

  /// Balanced gray with slight blue undertones.
  /// Uses Tailwind's gray palette.
  gray,

  /// Blue-tinted gray for a cooler appearance.
  /// Uses Tailwind's slate palette.
  slate,
}

/// Extension to get display name for presets
extension ShadcnColorPresetExtension on ShadcnColorPreset {
  String get displayName {
    switch (this) {
      case ShadcnColorPreset.neutral:
        return 'Neutral';
      case ShadcnColorPreset.stone:
        return 'Stone';
      case ShadcnColorPreset.zinc:
        return 'Zinc';
      case ShadcnColorPreset.gray:
        return 'Gray';
      case ShadcnColorPreset.slate:
        return 'Slate';
    }
  }
}

/// Color data for a ShadCN preset.
///
/// Contains all the oklch color values for both light and dark modes.
class ShadcnPresetColors {
  // Light mode
  final String lightBackground;
  final String lightForeground;
  final String lightCard;
  final String lightCardForeground;
  final String lightPopover;
  final String lightPopoverForeground;
  final String lightPrimary;
  final String lightPrimaryForeground;
  final String lightSecondary;
  final String lightSecondaryForeground;
  final String lightMuted;
  final String lightMutedForeground;
  final String lightAccent;
  final String lightAccentForeground;
  final String lightDestructive;
  final String lightDestructiveForeground;
  final String lightBorder;
  final String lightInput;
  final String lightRing;

  // Light mode sidebar
  final String lightSidebarBackground;
  final String lightSidebarForeground;
  final String lightSidebarPrimary;
  final String lightSidebarPrimaryForeground;
  final String lightSidebarAccent;
  final String lightSidebarAccentForeground;
  final String lightSidebarBorder;
  final String lightSidebarRing;

  // Dark mode
  final String darkBackground;
  final String darkForeground;
  final String darkCard;
  final String darkCardForeground;
  final String darkPopover;
  final String darkPopoverForeground;
  final String darkPrimary;
  final String darkPrimaryForeground;
  final String darkSecondary;
  final String darkSecondaryForeground;
  final String darkMuted;
  final String darkMutedForeground;
  final String darkAccent;
  final String darkAccentForeground;
  final String darkDestructive;
  final String darkDestructiveForeground;
  final String darkBorder;
  final String darkInput;
  final String darkRing;

  // Dark mode sidebar
  final String darkSidebarBackground;
  final String darkSidebarForeground;
  final String darkSidebarPrimary;
  final String darkSidebarPrimaryForeground;
  final String darkSidebarAccent;
  final String darkSidebarAccentForeground;
  final String darkSidebarBorder;
  final String darkSidebarRing;

  // Color objects for RGB channel generation
  final Color lightBackgroundColor;
  final Color lightForegroundColor;
  final Color lightCardColor;
  final Color lightCardForegroundColor;
  final Color lightPrimaryColor;
  final Color lightPrimaryForegroundColor;
  final Color lightSecondaryColor;
  final Color lightSecondaryForegroundColor;
  final Color lightMutedForegroundColor;
  final Color lightAccentColor;
  final Color lightBorderColor;
  final Color lightInputColor;

  final Color darkBackgroundColor;
  final Color darkForegroundColor;
  final Color darkCardColor;
  final Color darkCardForegroundColor;
  final Color darkPrimaryColor;
  final Color darkPrimaryForegroundColor;
  final Color darkSecondaryColor;
  final Color darkSecondaryForegroundColor;
  final Color darkMutedForegroundColor;
  final Color darkAccentColor;
  final Color darkBorderColor;
  final Color darkInputColor;
  final Color darkDestructiveColor;
  final Color darkDestructiveForegroundColor;

  const ShadcnPresetColors({
    // Light mode oklch
    required this.lightBackground,
    required this.lightForeground,
    required this.lightCard,
    required this.lightCardForeground,
    required this.lightPopover,
    required this.lightPopoverForeground,
    required this.lightPrimary,
    required this.lightPrimaryForeground,
    required this.lightSecondary,
    required this.lightSecondaryForeground,
    required this.lightMuted,
    required this.lightMutedForeground,
    required this.lightAccent,
    required this.lightAccentForeground,
    required this.lightDestructive,
    required this.lightDestructiveForeground,
    required this.lightBorder,
    required this.lightInput,
    required this.lightRing,
    // Light sidebar
    required this.lightSidebarBackground,
    required this.lightSidebarForeground,
    required this.lightSidebarPrimary,
    required this.lightSidebarPrimaryForeground,
    required this.lightSidebarAccent,
    required this.lightSidebarAccentForeground,
    required this.lightSidebarBorder,
    required this.lightSidebarRing,
    // Dark mode oklch
    required this.darkBackground,
    required this.darkForeground,
    required this.darkCard,
    required this.darkCardForeground,
    required this.darkPopover,
    required this.darkPopoverForeground,
    required this.darkPrimary,
    required this.darkPrimaryForeground,
    required this.darkSecondary,
    required this.darkSecondaryForeground,
    required this.darkMuted,
    required this.darkMutedForeground,
    required this.darkAccent,
    required this.darkAccentForeground,
    required this.darkDestructive,
    required this.darkDestructiveForeground,
    required this.darkBorder,
    required this.darkInput,
    required this.darkRing,
    // Dark sidebar
    required this.darkSidebarBackground,
    required this.darkSidebarForeground,
    required this.darkSidebarPrimary,
    required this.darkSidebarPrimaryForeground,
    required this.darkSidebarAccent,
    required this.darkSidebarAccentForeground,
    required this.darkSidebarBorder,
    required this.darkSidebarRing,
    // Color objects for RGB
    required this.lightBackgroundColor,
    required this.lightForegroundColor,
    required this.lightCardColor,
    required this.lightCardForegroundColor,
    required this.lightPrimaryColor,
    required this.lightPrimaryForegroundColor,
    required this.lightSecondaryColor,
    required this.lightSecondaryForegroundColor,
    required this.lightMutedForegroundColor,
    required this.lightAccentColor,
    required this.lightBorderColor,
    required this.lightInputColor,
    required this.darkBackgroundColor,
    required this.darkForegroundColor,
    required this.darkCardColor,
    required this.darkCardForegroundColor,
    required this.darkPrimaryColor,
    required this.darkPrimaryForegroundColor,
    required this.darkSecondaryColor,
    required this.darkSecondaryForegroundColor,
    required this.darkMutedForegroundColor,
    required this.darkAccentColor,
    required this.darkBorderColor,
    required this.darkInputColor,
    required this.darkDestructiveColor,
    required this.darkDestructiveForegroundColor,
  });
}

/// Preset color definitions for each ShadCN gray scale.
///
/// Based on ui.shadcn.com/docs/theming with Tailwind CSS color palettes.
class ShadcnPresets {
  ShadcnPresets._();

  /// Get colors for a specific preset
  static ShadcnPresetColors getColors(ShadcnColorPreset preset) {
    switch (preset) {
      case ShadcnColorPreset.neutral:
        return neutral;
      case ShadcnColorPreset.stone:
        return stone;
      case ShadcnColorPreset.zinc:
        return zinc;
      case ShadcnColorPreset.gray:
        return gray;
      case ShadcnColorPreset.slate:
        return slate;
    }
  }

  /// Neutral - Pure grayscale (no color tint)
  static const ShadcnPresetColors neutral = ShadcnPresetColors(
    // Light mode oklch
    lightBackground: 'oklch(1 0 0)',
    lightForeground: 'oklch(0.145 0 0)',
    lightCard: 'oklch(1 0 0)',
    lightCardForeground: 'oklch(0.145 0 0)',
    lightPopover: 'oklch(1 0 0)',
    lightPopoverForeground: 'oklch(0.145 0 0)',
    lightPrimary: 'oklch(0.205 0 0)',
    lightPrimaryForeground: 'oklch(0.985 0 0)',
    lightSecondary: 'oklch(0.97 0 0)',
    lightSecondaryForeground: 'oklch(0.205 0 0)',
    lightMuted: 'oklch(0.97 0 0)',
    lightMutedForeground: 'oklch(0.556 0 0)',
    lightAccent: 'oklch(0.97 0 0)',
    lightAccentForeground: 'oklch(0.205 0 0)',
    lightDestructive: 'oklch(0.577 0.245 27.325)',
    lightDestructiveForeground: 'oklch(1 0 0)',
    lightBorder: 'oklch(0.922 0 0)',
    lightInput: 'oklch(0.922 0 0)',
    lightRing: 'oklch(0.708 0 0)',
    // Light sidebar
    lightSidebarBackground: 'oklch(0.985 0 0)',
    lightSidebarForeground: 'oklch(0.145 0 0)',
    lightSidebarPrimary: 'oklch(0.205 0 0)',
    lightSidebarPrimaryForeground: 'oklch(0.985 0 0)',
    lightSidebarAccent: 'oklch(0.97 0 0)',
    lightSidebarAccentForeground: 'oklch(0.205 0 0)',
    lightSidebarBorder: 'oklch(0.922 0 0)',
    lightSidebarRing: 'oklch(0.708 0 0)',
    // Dark mode oklch
    darkBackground: 'oklch(0.145 0 0)',
    darkForeground: 'oklch(0.985 0 0)',
    darkCard: 'oklch(0.205 0 0)',
    darkCardForeground: 'oklch(0.985 0 0)',
    darkPopover: 'oklch(0.205 0 0)',
    darkPopoverForeground: 'oklch(0.985 0 0)',
    darkPrimary: 'oklch(0.922 0 0)',
    darkPrimaryForeground: 'oklch(0.205 0 0)',
    darkSecondary: 'oklch(0.269 0 0)',
    darkSecondaryForeground: 'oklch(0.985 0 0)',
    darkMuted: 'oklch(0.269 0 0)',
    darkMutedForeground: 'oklch(0.708 0 0)',
    darkAccent: 'oklch(0.269 0 0)',
    darkAccentForeground: 'oklch(0.985 0 0)',
    darkDestructive: 'oklch(0.704 0.191 22.216)',
    darkDestructiveForeground: 'oklch(0.985 0 0)',
    darkBorder: 'oklch(0.269 0 0)',
    darkInput: 'oklch(0.269 0 0)',
    darkRing: 'oklch(0.556 0 0)',
    // Dark sidebar
    darkSidebarBackground: 'oklch(0.205 0 0)',
    darkSidebarForeground: 'oklch(0.985 0 0)',
    darkSidebarPrimary: 'oklch(0.922 0 0)',
    darkSidebarPrimaryForeground: 'oklch(0.205 0 0)',
    darkSidebarAccent: 'oklch(0.269 0 0)',
    darkSidebarAccentForeground: 'oklch(0.985 0 0)',
    darkSidebarBorder: 'oklch(0.269 0 0)',
    darkSidebarRing: 'oklch(0.556 0 0)',
    // Color objects - Neutral (pure gray)
    lightBackgroundColor: Colors.white,
    lightForegroundColor: Color(0xFF1A1A1A),
    lightCardColor: Colors.white,
    lightCardForegroundColor: Color(0xFF1A1A1A),
    lightPrimaryColor: Color(0xFF262626),
    lightPrimaryForegroundColor: Color(0xFFFAFAFA),
    lightSecondaryColor: Color(0xFFF5F5F5),
    lightSecondaryForegroundColor: Color(0xFF262626),
    lightMutedForegroundColor: Color(0xFF737373),
    lightAccentColor: Color(0xFFF5F5F5),
    lightBorderColor: Color(0xFFE5E5E5),
    lightInputColor: Color(0xFFE5E5E5),
    darkBackgroundColor: Color(0xFF1A1A1A),
    darkForegroundColor: Color(0xFFFAFAFA),
    darkCardColor: Color(0xFF262626),
    darkCardForegroundColor: Color(0xFFFAFAFA),
    darkPrimaryColor: Color(0xFFE5E5E5),
    darkPrimaryForegroundColor: Color(0xFF262626),
    darkSecondaryColor: Color(0xFF333333),
    darkSecondaryForegroundColor: Color(0xFFFAFAFA),
    darkMutedForegroundColor: Color(0xFFA3A3A3),
    darkAccentColor: Color(0xFF333333),
    darkBorderColor: Color(0xFF333333),
    darkInputColor: Color(0xFF333333),
    darkDestructiveColor: Color(0xFFDC4A4A),
    darkDestructiveForegroundColor: Color(0xFFFAFAFA),
  );

  /// Stone - Warm gray with yellow/brown undertones
  static const ShadcnPresetColors stone = ShadcnPresetColors(
    // Light mode oklch
    lightBackground: 'oklch(1 0 0)',
    lightForeground: 'oklch(0.147 0.004 49.25)',
    lightCard: 'oklch(1 0 0)',
    lightCardForeground: 'oklch(0.147 0.004 49.25)',
    lightPopover: 'oklch(1 0 0)',
    lightPopoverForeground: 'oklch(0.147 0.004 49.25)',
    lightPrimary: 'oklch(0.216 0.006 56.043)',
    lightPrimaryForeground: 'oklch(0.985 0.001 106.423)',
    lightSecondary: 'oklch(0.97 0.001 106.424)',
    lightSecondaryForeground: 'oklch(0.216 0.006 56.043)',
    lightMuted: 'oklch(0.97 0.001 106.424)',
    lightMutedForeground: 'oklch(0.553 0.013 58.071)',
    lightAccent: 'oklch(0.97 0.001 106.424)',
    lightAccentForeground: 'oklch(0.216 0.006 56.043)',
    lightDestructive: 'oklch(0.577 0.245 27.325)',
    lightDestructiveForeground: 'oklch(1 0 0)',
    lightBorder: 'oklch(0.923 0.003 48.717)',
    lightInput: 'oklch(0.923 0.003 48.717)',
    lightRing: 'oklch(0.709 0.01 56.259)',
    // Light sidebar
    lightSidebarBackground: 'oklch(0.985 0.001 106.423)',
    lightSidebarForeground: 'oklch(0.147 0.004 49.25)',
    lightSidebarPrimary: 'oklch(0.216 0.006 56.043)',
    lightSidebarPrimaryForeground: 'oklch(0.985 0.001 106.423)',
    lightSidebarAccent: 'oklch(0.97 0.001 106.424)',
    lightSidebarAccentForeground: 'oklch(0.216 0.006 56.043)',
    lightSidebarBorder: 'oklch(0.923 0.003 48.717)',
    lightSidebarRing: 'oklch(0.709 0.01 56.259)',
    // Dark mode oklch
    darkBackground: 'oklch(0.147 0.004 49.25)',
    darkForeground: 'oklch(0.985 0.001 106.423)',
    darkCard: 'oklch(0.216 0.006 56.043)',
    darkCardForeground: 'oklch(0.985 0.001 106.423)',
    darkPopover: 'oklch(0.216 0.006 56.043)',
    darkPopoverForeground: 'oklch(0.985 0.001 106.423)',
    darkPrimary: 'oklch(0.923 0.003 48.717)',
    darkPrimaryForeground: 'oklch(0.216 0.006 56.043)',
    darkSecondary: 'oklch(0.268 0.007 34.298)',
    darkSecondaryForeground: 'oklch(0.985 0.001 106.423)',
    darkMuted: 'oklch(0.268 0.007 34.298)',
    darkMutedForeground: 'oklch(0.709 0.01 56.259)',
    darkAccent: 'oklch(0.268 0.007 34.298)',
    darkAccentForeground: 'oklch(0.985 0.001 106.423)',
    darkDestructive: 'oklch(0.704 0.191 22.216)',
    darkDestructiveForeground: 'oklch(0.985 0.001 106.423)',
    darkBorder: 'oklch(0.268 0.007 34.298)',
    darkInput: 'oklch(0.268 0.007 34.298)',
    darkRing: 'oklch(0.553 0.013 58.071)',
    // Dark sidebar
    darkSidebarBackground: 'oklch(0.216 0.006 56.043)',
    darkSidebarForeground: 'oklch(0.985 0.001 106.423)',
    darkSidebarPrimary: 'oklch(0.923 0.003 48.717)',
    darkSidebarPrimaryForeground: 'oklch(0.216 0.006 56.043)',
    darkSidebarAccent: 'oklch(0.268 0.007 34.298)',
    darkSidebarAccentForeground: 'oklch(0.985 0.001 106.423)',
    darkSidebarBorder: 'oklch(0.268 0.007 34.298)',
    darkSidebarRing: 'oklch(0.553 0.013 58.071)',
    // Color objects - Stone (warm gray)
    lightBackgroundColor: Colors.white,
    lightForegroundColor: Color(0xFF1C1917),
    lightCardColor: Colors.white,
    lightCardForegroundColor: Color(0xFF1C1917),
    lightPrimaryColor: Color(0xFF292524),
    lightPrimaryForegroundColor: Color(0xFFFAFAF9),
    lightSecondaryColor: Color(0xFFF5F5F4),
    lightSecondaryForegroundColor: Color(0xFF292524),
    lightMutedForegroundColor: Color(0xFF78716C),
    lightAccentColor: Color(0xFFF5F5F4),
    lightBorderColor: Color(0xFFE7E5E4),
    lightInputColor: Color(0xFFE7E5E4),
    darkBackgroundColor: Color(0xFF1C1917),
    darkForegroundColor: Color(0xFFFAFAF9),
    darkCardColor: Color(0xFF292524),
    darkCardForegroundColor: Color(0xFFFAFAF9),
    darkPrimaryColor: Color(0xFFE7E5E4),
    darkPrimaryForegroundColor: Color(0xFF292524),
    darkSecondaryColor: Color(0xFF44403C),
    darkSecondaryForegroundColor: Color(0xFFFAFAF9),
    darkMutedForegroundColor: Color(0xFFA8A29E),
    darkAccentColor: Color(0xFF44403C),
    darkBorderColor: Color(0xFF44403C),
    darkInputColor: Color(0xFF44403C),
    darkDestructiveColor: Color(0xFFDC4A4A),
    darkDestructiveForegroundColor: Color(0xFFFAFAF9),
  );

  /// Zinc - Cool gray with purple undertones
  static const ShadcnPresetColors zinc = ShadcnPresetColors(
    // Light mode oklch
    lightBackground: 'oklch(1 0 0)',
    lightForeground: 'oklch(0.141 0.005 285.823)',
    lightCard: 'oklch(1 0 0)',
    lightCardForeground: 'oklch(0.141 0.005 285.823)',
    lightPopover: 'oklch(1 0 0)',
    lightPopoverForeground: 'oklch(0.141 0.005 285.823)',
    lightPrimary: 'oklch(0.21 0.006 285.885)',
    lightPrimaryForeground: 'oklch(0.985 0 0)',
    lightSecondary: 'oklch(0.967 0.001 286.375)',
    lightSecondaryForeground: 'oklch(0.21 0.006 285.885)',
    lightMuted: 'oklch(0.967 0.001 286.375)',
    lightMutedForeground: 'oklch(0.552 0.016 285.938)',
    lightAccent: 'oklch(0.967 0.001 286.375)',
    lightAccentForeground: 'oklch(0.21 0.006 285.885)',
    lightDestructive: 'oklch(0.577 0.245 27.325)',
    lightDestructiveForeground: 'oklch(1 0 0)',
    lightBorder: 'oklch(0.92 0.004 286.32)',
    lightInput: 'oklch(0.92 0.004 286.32)',
    lightRing: 'oklch(0.705 0.015 286.067)',
    // Light sidebar
    lightSidebarBackground: 'oklch(0.985 0 0)',
    lightSidebarForeground: 'oklch(0.141 0.005 285.823)',
    lightSidebarPrimary: 'oklch(0.21 0.006 285.885)',
    lightSidebarPrimaryForeground: 'oklch(0.985 0 0)',
    lightSidebarAccent: 'oklch(0.967 0.001 286.375)',
    lightSidebarAccentForeground: 'oklch(0.21 0.006 285.885)',
    lightSidebarBorder: 'oklch(0.92 0.004 286.32)',
    lightSidebarRing: 'oklch(0.705 0.015 286.067)',
    // Dark mode oklch
    darkBackground: 'oklch(0.141 0.005 285.823)',
    darkForeground: 'oklch(0.985 0 0)',
    darkCard: 'oklch(0.21 0.006 285.885)',
    darkCardForeground: 'oklch(0.985 0 0)',
    darkPopover: 'oklch(0.21 0.006 285.885)',
    darkPopoverForeground: 'oklch(0.985 0 0)',
    darkPrimary: 'oklch(0.92 0.004 286.32)',
    darkPrimaryForeground: 'oklch(0.21 0.006 285.885)',
    darkSecondary: 'oklch(0.274 0.006 286.033)',
    darkSecondaryForeground: 'oklch(0.985 0 0)',
    darkMuted: 'oklch(0.274 0.006 286.033)',
    darkMutedForeground: 'oklch(0.705 0.015 286.067)',
    darkAccent: 'oklch(0.274 0.006 286.033)',
    darkAccentForeground: 'oklch(0.985 0 0)',
    darkDestructive: 'oklch(0.704 0.191 22.216)',
    darkDestructiveForeground: 'oklch(0.985 0 0)',
    darkBorder: 'oklch(0.274 0.006 286.033)',
    darkInput: 'oklch(0.274 0.006 286.033)',
    darkRing: 'oklch(0.552 0.016 285.938)',
    // Dark sidebar
    darkSidebarBackground: 'oklch(0.21 0.006 285.885)',
    darkSidebarForeground: 'oklch(0.985 0 0)',
    darkSidebarPrimary: 'oklch(0.92 0.004 286.32)',
    darkSidebarPrimaryForeground: 'oklch(0.21 0.006 285.885)',
    darkSidebarAccent: 'oklch(0.274 0.006 286.033)',
    darkSidebarAccentForeground: 'oklch(0.985 0 0)',
    darkSidebarBorder: 'oklch(0.274 0.006 286.033)',
    darkSidebarRing: 'oklch(0.552 0.016 285.938)',
    // Color objects - Zinc (cool gray)
    lightBackgroundColor: Colors.white,
    lightForegroundColor: Color(0xFF18181B),
    lightCardColor: Colors.white,
    lightCardForegroundColor: Color(0xFF18181B),
    lightPrimaryColor: Color(0xFF27272A),
    lightPrimaryForegroundColor: Color(0xFFFAFAFA),
    lightSecondaryColor: Color(0xFFF4F4F5),
    lightSecondaryForegroundColor: Color(0xFF27272A),
    lightMutedForegroundColor: Color(0xFF71717A),
    lightAccentColor: Color(0xFFF4F4F5),
    lightBorderColor: Color(0xFFE4E4E7),
    lightInputColor: Color(0xFFE4E4E7),
    darkBackgroundColor: Color(0xFF18181B),
    darkForegroundColor: Color(0xFFFAFAFA),
    darkCardColor: Color(0xFF27272A),
    darkCardForegroundColor: Color(0xFFFAFAFA),
    darkPrimaryColor: Color(0xFFE4E4E7),
    darkPrimaryForegroundColor: Color(0xFF27272A),
    darkSecondaryColor: Color(0xFF3F3F46),
    darkSecondaryForegroundColor: Color(0xFFFAFAFA),
    darkMutedForegroundColor: Color(0xFFA1A1AA),
    darkAccentColor: Color(0xFF3F3F46),
    darkBorderColor: Color(0xFF3F3F46),
    darkInputColor: Color(0xFF3F3F46),
    darkDestructiveColor: Color(0xFFDC4A4A),
    darkDestructiveForegroundColor: Color(0xFFFAFAFA),
  );

  /// Gray - Balanced gray with slight blue undertones
  static const ShadcnPresetColors gray = ShadcnPresetColors(
    // Light mode oklch
    lightBackground: 'oklch(1 0 0)',
    lightForeground: 'oklch(0.13 0.028 261.692)',
    lightCard: 'oklch(1 0 0)',
    lightCardForeground: 'oklch(0.13 0.028 261.692)',
    lightPopover: 'oklch(1 0 0)',
    lightPopoverForeground: 'oklch(0.13 0.028 261.692)',
    lightPrimary: 'oklch(0.21 0.034 264.665)',
    lightPrimaryForeground: 'oklch(0.985 0.002 247.839)',
    lightSecondary: 'oklch(0.967 0.003 264.542)',
    lightSecondaryForeground: 'oklch(0.21 0.034 264.665)',
    lightMuted: 'oklch(0.967 0.003 264.542)',
    lightMutedForeground: 'oklch(0.551 0.027 264.364)',
    lightAccent: 'oklch(0.967 0.003 264.542)',
    lightAccentForeground: 'oklch(0.21 0.034 264.665)',
    lightDestructive: 'oklch(0.577 0.245 27.325)',
    lightDestructiveForeground: 'oklch(1 0 0)',
    lightBorder: 'oklch(0.928 0.006 264.531)',
    lightInput: 'oklch(0.928 0.006 264.531)',
    lightRing: 'oklch(0.707 0.022 261.325)',
    // Light sidebar
    lightSidebarBackground: 'oklch(0.985 0.002 247.839)',
    lightSidebarForeground: 'oklch(0.13 0.028 261.692)',
    lightSidebarPrimary: 'oklch(0.21 0.034 264.665)',
    lightSidebarPrimaryForeground: 'oklch(0.985 0.002 247.839)',
    lightSidebarAccent: 'oklch(0.967 0.003 264.542)',
    lightSidebarAccentForeground: 'oklch(0.21 0.034 264.665)',
    lightSidebarBorder: 'oklch(0.928 0.006 264.531)',
    lightSidebarRing: 'oklch(0.707 0.022 261.325)',
    // Dark mode oklch
    darkBackground: 'oklch(0.13 0.028 261.692)',
    darkForeground: 'oklch(0.985 0.002 247.839)',
    darkCard: 'oklch(0.21 0.034 264.665)',
    darkCardForeground: 'oklch(0.985 0.002 247.839)',
    darkPopover: 'oklch(0.21 0.034 264.665)',
    darkPopoverForeground: 'oklch(0.985 0.002 247.839)',
    darkPrimary: 'oklch(0.928 0.006 264.531)',
    darkPrimaryForeground: 'oklch(0.21 0.034 264.665)',
    darkSecondary: 'oklch(0.278 0.033 256.848)',
    darkSecondaryForeground: 'oklch(0.985 0.002 247.839)',
    darkMuted: 'oklch(0.278 0.033 256.848)',
    darkMutedForeground: 'oklch(0.707 0.022 261.325)',
    darkAccent: 'oklch(0.278 0.033 256.848)',
    darkAccentForeground: 'oklch(0.985 0.002 247.839)',
    darkDestructive: 'oklch(0.704 0.191 22.216)',
    darkDestructiveForeground: 'oklch(0.985 0.002 247.839)',
    darkBorder: 'oklch(0.278 0.033 256.848)',
    darkInput: 'oklch(0.278 0.033 256.848)',
    darkRing: 'oklch(0.551 0.027 264.364)',
    // Dark sidebar
    darkSidebarBackground: 'oklch(0.21 0.034 264.665)',
    darkSidebarForeground: 'oklch(0.985 0.002 247.839)',
    darkSidebarPrimary: 'oklch(0.928 0.006 264.531)',
    darkSidebarPrimaryForeground: 'oklch(0.21 0.034 264.665)',
    darkSidebarAccent: 'oklch(0.278 0.033 256.848)',
    darkSidebarAccentForeground: 'oklch(0.985 0.002 247.839)',
    darkSidebarBorder: 'oklch(0.278 0.033 256.848)',
    darkSidebarRing: 'oklch(0.551 0.027 264.364)',
    // Color objects - Gray (balanced gray)
    lightBackgroundColor: Colors.white,
    lightForegroundColor: Color(0xFF111827),
    lightCardColor: Colors.white,
    lightCardForegroundColor: Color(0xFF111827),
    lightPrimaryColor: Color(0xFF1F2937),
    lightPrimaryForegroundColor: Color(0xFFF9FAFB),
    lightSecondaryColor: Color(0xFFF3F4F6),
    lightSecondaryForegroundColor: Color(0xFF1F2937),
    lightMutedForegroundColor: Color(0xFF6B7280),
    lightAccentColor: Color(0xFFF3F4F6),
    lightBorderColor: Color(0xFFE5E7EB),
    lightInputColor: Color(0xFFE5E7EB),
    darkBackgroundColor: Color(0xFF111827),
    darkForegroundColor: Color(0xFFF9FAFB),
    darkCardColor: Color(0xFF1F2937),
    darkCardForegroundColor: Color(0xFFF9FAFB),
    darkPrimaryColor: Color(0xFFE5E7EB),
    darkPrimaryForegroundColor: Color(0xFF1F2937),
    darkSecondaryColor: Color(0xFF374151),
    darkSecondaryForegroundColor: Color(0xFFF9FAFB),
    darkMutedForegroundColor: Color(0xFF9CA3AF),
    darkAccentColor: Color(0xFF374151),
    darkBorderColor: Color(0xFF374151),
    darkInputColor: Color(0xFF374151),
    darkDestructiveColor: Color(0xFFDC4A4A),
    darkDestructiveForegroundColor: Color(0xFFF9FAFB),
  );

  /// Slate - Blue-tinted gray
  static const ShadcnPresetColors slate = ShadcnPresetColors(
    // Light mode oklch
    lightBackground: 'oklch(1 0 0)',
    lightForeground: 'oklch(0.129 0.042 264.695)',
    lightCard: 'oklch(1 0 0)',
    lightCardForeground: 'oklch(0.129 0.042 264.695)',
    lightPopover: 'oklch(1 0 0)',
    lightPopoverForeground: 'oklch(0.129 0.042 264.695)',
    lightPrimary: 'oklch(0.208 0.042 265.755)',
    lightPrimaryForeground: 'oklch(0.984 0.003 247.858)',
    lightSecondary: 'oklch(0.968 0.007 247.896)',
    lightSecondaryForeground: 'oklch(0.208 0.042 265.755)',
    lightMuted: 'oklch(0.968 0.007 247.896)',
    lightMutedForeground: 'oklch(0.554 0.046 257.417)',
    lightAccent: 'oklch(0.968 0.007 247.896)',
    lightAccentForeground: 'oklch(0.208 0.042 265.755)',
    lightDestructive: 'oklch(0.577 0.245 27.325)',
    lightDestructiveForeground: 'oklch(1 0 0)',
    lightBorder: 'oklch(0.929 0.013 255.508)',
    lightInput: 'oklch(0.929 0.013 255.508)',
    lightRing: 'oklch(0.704 0.04 256.788)',
    // Light sidebar
    lightSidebarBackground: 'oklch(0.984 0.003 247.858)',
    lightSidebarForeground: 'oklch(0.129 0.042 264.695)',
    lightSidebarPrimary: 'oklch(0.208 0.042 265.755)',
    lightSidebarPrimaryForeground: 'oklch(0.984 0.003 247.858)',
    lightSidebarAccent: 'oklch(0.968 0.007 247.896)',
    lightSidebarAccentForeground: 'oklch(0.208 0.042 265.755)',
    lightSidebarBorder: 'oklch(0.929 0.013 255.508)',
    lightSidebarRing: 'oklch(0.704 0.04 256.788)',
    // Dark mode oklch
    darkBackground: 'oklch(0.129 0.042 264.695)',
    darkForeground: 'oklch(0.984 0.003 247.858)',
    darkCard: 'oklch(0.208 0.042 265.755)',
    darkCardForeground: 'oklch(0.984 0.003 247.858)',
    darkPopover: 'oklch(0.208 0.042 265.755)',
    darkPopoverForeground: 'oklch(0.984 0.003 247.858)',
    darkPrimary: 'oklch(0.929 0.013 255.508)',
    darkPrimaryForeground: 'oklch(0.208 0.042 265.755)',
    darkSecondary: 'oklch(0.279 0.041 260.031)',
    darkSecondaryForeground: 'oklch(0.984 0.003 247.858)',
    darkMuted: 'oklch(0.279 0.041 260.031)',
    darkMutedForeground: 'oklch(0.704 0.04 256.788)',
    darkAccent: 'oklch(0.279 0.041 260.031)',
    darkAccentForeground: 'oklch(0.984 0.003 247.858)',
    darkDestructive: 'oklch(0.704 0.191 22.216)',
    darkDestructiveForeground: 'oklch(0.984 0.003 247.858)',
    darkBorder: 'oklch(0.279 0.041 260.031)',
    darkInput: 'oklch(0.279 0.041 260.031)',
    darkRing: 'oklch(0.554 0.046 257.417)',
    // Dark sidebar
    darkSidebarBackground: 'oklch(0.208 0.042 265.755)',
    darkSidebarForeground: 'oklch(0.984 0.003 247.858)',
    darkSidebarPrimary: 'oklch(0.929 0.013 255.508)',
    darkSidebarPrimaryForeground: 'oklch(0.208 0.042 265.755)',
    darkSidebarAccent: 'oklch(0.279 0.041 260.031)',
    darkSidebarAccentForeground: 'oklch(0.984 0.003 247.858)',
    darkSidebarBorder: 'oklch(0.279 0.041 260.031)',
    darkSidebarRing: 'oklch(0.554 0.046 257.417)',
    // Color objects - Slate (blue-tinted gray)
    lightBackgroundColor: Colors.white,
    lightForegroundColor: Color(0xFF0F172A),
    lightCardColor: Colors.white,
    lightCardForegroundColor: Color(0xFF0F172A),
    lightPrimaryColor: Color(0xFF1E293B),
    lightPrimaryForegroundColor: Color(0xFFF8FAFC),
    lightSecondaryColor: Color(0xFFF1F5F9),
    lightSecondaryForegroundColor: Color(0xFF1E293B),
    lightMutedForegroundColor: Color(0xFF64748B),
    lightAccentColor: Color(0xFFF1F5F9),
    lightBorderColor: Color(0xFFE2E8F0),
    lightInputColor: Color(0xFFE2E8F0),
    darkBackgroundColor: Color(0xFF0F172A),
    darkForegroundColor: Color(0xFFF8FAFC),
    darkCardColor: Color(0xFF1E293B),
    darkCardForegroundColor: Color(0xFFF8FAFC),
    darkPrimaryColor: Color(0xFFE2E8F0),
    darkPrimaryForegroundColor: Color(0xFF1E293B),
    darkSecondaryColor: Color(0xFF334155),
    darkSecondaryForegroundColor: Color(0xFFF8FAFC),
    darkMutedForegroundColor: Color(0xFF94A3B8),
    darkAccentColor: Color(0xFF334155),
    darkBorderColor: Color(0xFF334155),
    darkInputColor: Color(0xFF334155),
    darkDestructiveColor: Color(0xFFDC4A4A),
    darkDestructiveForegroundColor: Color(0xFFF8FAFC),
  );
}
