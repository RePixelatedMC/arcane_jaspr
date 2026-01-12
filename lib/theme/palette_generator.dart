import 'dart:math' as math;

import 'color_seed.dart';
import 'palette.dart';

/// Generates a complete [ThemePalette] from a [ThemeSeed].
///
/// This is the "black box" that derives all colors from minimal input.
/// Uses WCAG contrast algorithms for foreground colors.
abstract class PaletteGenerator {
  PaletteGenerator._();

  /// Generate a full palette from seed colors.
  static ThemePalette generate(ThemeSeed seed) {
    final bool isDark = seed.isDark;
    final int primary = seed.primary;

    // Resolve background
    final int background = seed.background ?? (isDark ? 0xFF000000 : 0xFFffffff);
    final int foreground = contrastingForeground(background);

    // Resolve secondary (slightly off from background)
    // Light mode: tint with primary hue to add life
    // Dark mode: just lighten for subtle elevation
    final int secondary = seed.secondary ?? (isDark
        ? lighten(background, 0.06) // Dark: slightly lighter
        : _tintedSurface(background, primary, 0.04, 0.08)); // Light: darken + tint

    // Resolve accent - more prominent tinting for light mode
    final int accent = seed.accent ?? (isDark
        ? secondary
        : _tintedSurface(background, primary, 0.06, 0.12));

    // Resolve border - light mode gets subtle primary tint for cohesion
    final int border = seed.border ?? (isDark
        ? lighten(background, 0.18)
        : _tintedSurface(background, primary, 0.12, 0.06));

    // Card is same as background or slightly elevated
    // Light mode: subtle primary tint for warmth
    final int card = isDark
        ? lighten(background, 0.04)
        : _tintedSurface(background, primary, 0.01, 0.03);
    final int cardHover = isDark
        ? lighten(card, 0.04)
        : _tintedSurface(card, primary, 0.02, 0.04);

    // Muted - light mode gets subtle tinting
    final int muted = isDark ? secondary : _tintedSurface(background, primary, 0.03, 0.06);
    // Note: Use blendColors for both modes since setAlpha doesn't work
    // with hex output (toHex strips alpha channel)
    final int mutedForeground = blendColors(
      foreground,
      background,
      isDark ? 0.60 : 0.45,
    );

    // Primary foreground
    final int primaryForeground = contrastingForeground(primary);

    // Semantic colors
    final int destructive = seed.destructive;
    final int success = seed.success;
    final int warning = seed.warning;
    final int info = seed.info;

    // Glow color for shadows
    final int? glowColor = seed.accentGlow ? (seed.glowColor ?? primary) : null;

    return ThemePalette(
      isDark: isDark,

      // Core
      background: background,
      foreground: foreground,

      // Card
      card: card,
      cardForeground: foreground,
      cardHover: cardHover,
      popover: card,
      popoverForeground: foreground,

      // Primary
      primary: primary,
      primaryForeground: primaryForeground,
      primaryContainer: container(background, primary),

      // Secondary
      secondary: secondary,
      secondaryForeground: foreground,
      secondaryContainer: container(background, secondary),

      // Accent
      accent: accent,
      accentForeground: foreground,
      accentHover: isDark ? lighten(accent, 0.05) : darken(accent, 0.05),
      accentContainer: container(background, accent),

      // Muted
      muted: muted,
      mutedForeground: mutedForeground,

      // Destructive
      destructive: destructive,
      destructiveForeground: contrastingForeground(destructive),
      destructiveHover: isDark ? lighten(destructive, 0.10) : darken(destructive, 0.10),
      destructiveContainer: container(background, destructive),

      // Success
      success: success,
      successForeground: contrastingForeground(success),
      successHover: isDark ? lighten(success, 0.10) : darken(success, 0.10),
      successContainer: container(background, success),

      // Warning
      warning: warning,
      warningForeground: contrastingForeground(warning),
      warningHover: isDark ? lighten(warning, 0.10) : darken(warning, 0.10),
      warningContainer: container(background, warning),

      // Info
      info: info,
      infoForeground: contrastingForeground(info),
      infoHover: isDark ? lighten(info, 0.10) : darken(info, 0.10),
      infoContainer: container(background, info),

      // Borders
      border: border,
      input: isDark ? darken(border, 0.03) : border,
      ring: isDark ? lighten(primary, 0.2) : primary,

      // Overlays
      overlay: 0x80000000, // 50% black
      navbar: setAlpha(background, 0.8),
      codeBackground: secondary,

      // Shadows
      shadowXs: _shadowXs(isDark, glowColor),
      shadowSm: _shadowSm(isDark, glowColor),
      shadowMd: _shadowMd(isDark, glowColor),
      shadowLg: _shadowLg(isDark, glowColor),
      shadowXl: _shadowXl(isDark, glowColor),
    );
  }

  // ============================================
  // Color Math Utilities
  // ============================================

  /// Get a contrasting foreground color (black or white) for a background.
  /// Uses WCAG relative luminance formula.
  static int contrastingForeground(int color) {
    final double luminance = relativeLuminance(color);
    // Use white text on dark backgrounds, black on light
    return luminance > 0.179 ? 0xFF000000 : 0xFFffffff;
  }

  /// Calculate relative luminance (0.0 - 1.0) per WCAG 2.1.
  static double relativeLuminance(int color) {
    final double r = _linearize((color >> 16) & 0xFF);
    final double g = _linearize((color >> 8) & 0xFF);
    final double b = _linearize(color & 0xFF);
    return 0.2126 * r + 0.7152 * g + 0.0722 * b;
  }

  static double _linearize(int channel) {
    final double c = channel / 255.0;
    return c <= 0.03928 ? c / 12.92 : math.pow((c + 0.055) / 1.055, 2.4).toDouble();
  }

  /// Darken a color by a percentage (0.0 - 1.0).
  static int darken(int color, double amount) {
    final int a = (color >> 24) & 0xFF;
    int r = (color >> 16) & 0xFF;
    int g = (color >> 8) & 0xFF;
    int b = color & 0xFF;

    r = (r * (1 - amount)).round().clamp(0, 255);
    g = (g * (1 - amount)).round().clamp(0, 255);
    b = (b * (1 - amount)).round().clamp(0, 255);

    return (a << 24) | (r << 16) | (g << 8) | b;
  }

  /// Lighten a color by a percentage (0.0 - 1.0).
  static int lighten(int color, double amount) {
    final int a = (color >> 24) & 0xFF;
    int r = (color >> 16) & 0xFF;
    int g = (color >> 8) & 0xFF;
    int b = color & 0xFF;

    r = (r + ((255 - r) * amount)).round().clamp(0, 255);
    g = (g + ((255 - g) * amount)).round().clamp(0, 255);
    b = (b + ((255 - b) * amount)).round().clamp(0, 255);

    return (a << 24) | (r << 16) | (g << 8) | b;
  }

  /// Create a container color (background with color overlay at opacity).
  static int container(int background, int color, {double opacity = 0.1}) {
    return blendColors(color, background, opacity);
  }

  /// Blend two colors together.
  /// [amount] is the weight of [color1] (0.0 = all color2, 1.0 = all color1).
  static int blendColors(int color1, int color2, double amount) {
    final int r1 = (color1 >> 16) & 0xFF;
    final int g1 = (color1 >> 8) & 0xFF;
    final int b1 = color1 & 0xFF;

    final int r2 = (color2 >> 16) & 0xFF;
    final int g2 = (color2 >> 8) & 0xFF;
    final int b2 = color2 & 0xFF;

    final int r = (r1 * amount + r2 * (1 - amount)).round().clamp(0, 255);
    final int g = (g1 * amount + g2 * (1 - amount)).round().clamp(0, 255);
    final int b = (b1 * amount + b2 * (1 - amount)).round().clamp(0, 255);

    return 0xFF000000 | (r << 16) | (g << 8) | b;
  }

  /// Set the alpha channel of a color (0.0 - 1.0).
  static int setAlpha(int color, double alpha) {
    final int a = (alpha * 255).round().clamp(0, 255);
    return (a << 24) | (color & 0x00FFFFFF);
  }

  /// Extract RGB as string for CSS: "255, 255, 255"
  static String toRgbString(int color) {
    final int r = (color >> 16) & 0xFF;
    final int g = (color >> 8) & 0xFF;
    final int b = color & 0xFF;
    return '$r, $g, $b';
  }

  /// Convert to CSS hex: "#ffffff"
  static String toHex(int color) {
    final int r = (color >> 16) & 0xFF;
    final int g = (color >> 8) & 0xFF;
    final int b = color & 0xFF;
    return '#${r.toRadixString(16).padLeft(2, '0')}'
        '${g.toRadixString(16).padLeft(2, '0')}'
        '${b.toRadixString(16).padLeft(2, '0')}';
  }

  /// Convert to CSS rgba: "rgba(255, 255, 255, 0.5)"
  static String toRgba(int color) {
    final int a = (color >> 24) & 0xFF;
    final int r = (color >> 16) & 0xFF;
    final int g = (color >> 8) & 0xFF;
    final int b = color & 0xFF;
    final double alpha = a / 255.0;
    return 'rgba($r, $g, $b, ${alpha.toStringAsFixed(2)})';
  }

  // ============================================
  // Light Theme Tinting
  // ============================================

  /// Create a tinted surface color for light themes.
  ///
  /// Combines darkening (for depth) with hue tinting (for life).
  /// [darkenAmount] controls how much darker (0.0-1.0)
  /// [tintAmount] controls how much of the accent color bleeds in (0.0-1.0)
  ///
  /// Example: _tintedSurface(white, blue, 0.04, 0.08)
  /// Result: A slightly darker off-white with a subtle blue tint
  static int _tintedSurface(
    int background,
    int accent,
    double darkenAmount,
    double tintAmount,
  ) {
    // First darken the background for depth
    final int darkened = darken(background, darkenAmount);
    // Then blend in the accent color for hue
    return blendColors(accent, darkened, tintAmount);
  }

  /// Create a more saturated tint for light theme accents.
  ///
  /// Uses the accent color more prominently while keeping it light.
  /// Good for hover states and interactive elements.
  static int _accentTint(int background, int accent, double amount) {
    // Lighten the accent significantly, then blend with background
    final int lightenedAccent = lighten(accent, 0.7);
    return blendColors(lightenedAccent, background, amount);
  }

  // ============================================
  // Shadow Generation
  // ============================================

  static String _shadowXs(bool isDark, int? glowColor) {
    if (glowColor != null && isDark) {
      final String rgb = toRgbString(glowColor);
      return '0 1px 2px rgba(0, 0, 0, 0.05), 0 0 8px rgba($rgb, 0.08)';
    }
    return '0 1px 2px rgba(0, 0, 0, 0.05)';
  }

  static String _shadowSm(bool isDark, int? glowColor) {
    if (glowColor != null && isDark) {
      final String rgb = toRgbString(glowColor);
      return '0 1px 3px rgba(0, 0, 0, 0.1), 0 0 12px rgba($rgb, 0.1)';
    }
    return '0 1px 3px rgba(0, 0, 0, 0.1), 0 1px 2px rgba(0, 0, 0, 0.06)';
  }

  static String _shadowMd(bool isDark, int? glowColor) {
    if (glowColor != null && isDark) {
      final String rgb = toRgbString(glowColor);
      return '0 4px 6px rgba(0, 0, 0, 0.1), 0 0 20px rgba($rgb, 0.15)';
    }
    return '0 4px 6px rgba(0, 0, 0, 0.1), 0 2px 4px rgba(0, 0, 0, 0.06)';
  }

  static String _shadowLg(bool isDark, int? glowColor) {
    if (glowColor != null && isDark) {
      final String rgb = toRgbString(glowColor);
      return '0 10px 15px rgba(0, 0, 0, 0.1), 0 0 30px rgba($rgb, 0.2)';
    }
    return '0 10px 15px rgba(0, 0, 0, 0.1), 0 4px 6px rgba(0, 0, 0, 0.05)';
  }

  static String _shadowXl(bool isDark, int? glowColor) {
    if (glowColor != null && isDark) {
      final String rgb = toRgbString(glowColor);
      return '0 20px 25px rgba(0, 0, 0, 0.15), 0 0 50px rgba($rgb, 0.25)';
    }
    return '0 20px 25px rgba(0, 0, 0, 0.15), 0 8px 10px rgba(0, 0, 0, 0.04)';
  }
}
