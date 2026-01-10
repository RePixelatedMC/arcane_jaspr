import 'font_config.dart';
import 'palette.dart';
import 'palette_generator.dart';
import 'radius_config.dart';

/// Generates CSS variable blocks from [ThemePalette].
abstract class CssGenerator {
  CssGenerator._();

  /// Generate CSS variables for a single palette.
  ///
  /// [selector] is the CSS selector (`:root` or `.dark`).
  static String generate(
    ThemePalette palette, {
    String selector = ':root',
    FontConfig fonts = const FontConfig(),
    RadiusConfig radius = const RadiusConfig(),
    bool includeStatic = true,
  }) {
    final StringBuffer buffer = StringBuffer();
    buffer.writeln('$selector {');

    // Core colors
    _writeColor(buffer, 'background', palette.background);
    _writeColor(buffer, 'foreground', palette.foreground);
    buffer.writeln();

    // Card / Popover
    _writeColor(buffer, 'card', palette.card);
    _writeColor(buffer, 'card-foreground', palette.cardForeground);
    _writeColor(buffer, 'card-hover', palette.cardHover);
    _writeColor(buffer, 'popover', palette.popover);
    _writeColor(buffer, 'popover-foreground', palette.popoverForeground);
    buffer.writeln();

    // Primary
    _writeColor(buffer, 'primary', palette.primary);
    _writeColor(buffer, 'primary-foreground', palette.primaryForeground);
    _writeColor(buffer, 'primary-container', palette.primaryContainer);
    buffer.writeln();

    // Secondary
    _writeColor(buffer, 'secondary', palette.secondary);
    _writeColor(buffer, 'secondary-foreground', palette.secondaryForeground);
    _writeColor(buffer, 'secondary-container', palette.secondaryContainer);
    buffer.writeln();

    // Accent
    _writeColor(buffer, 'accent', palette.accent);
    _writeColor(buffer, 'accent-foreground', palette.accentForeground);
    _writeColor(buffer, 'accent-hover', palette.accentHover);
    _writeColor(buffer, 'accent-container', palette.accentContainer);
    buffer.writeln();

    // Muted
    _writeColor(buffer, 'muted', palette.muted);
    _writeColor(buffer, 'muted-foreground', palette.mutedForeground);
    buffer.writeln();

    // Destructive
    _writeColor(buffer, 'destructive', palette.destructive);
    _writeColor(buffer, 'destructive-foreground', palette.destructiveForeground);
    _writeColor(buffer, 'destructive-hover', palette.destructiveHover);
    _writeColor(buffer, 'destructive-container', palette.destructiveContainer);
    buffer.writeln();

    // Success
    _writeColor(buffer, 'success', palette.success);
    _writeColor(buffer, 'success-foreground', palette.successForeground);
    _writeColor(buffer, 'success-hover', palette.successHover);
    _writeColor(buffer, 'success-container', palette.successContainer);
    buffer.writeln();

    // Warning
    _writeColor(buffer, 'warning', palette.warning);
    _writeColor(buffer, 'warning-foreground', palette.warningForeground);
    _writeColor(buffer, 'warning-hover', palette.warningHover);
    _writeColor(buffer, 'warning-container', palette.warningContainer);
    buffer.writeln();

    // Info
    _writeColor(buffer, 'info', palette.info);
    _writeColor(buffer, 'info-foreground', palette.infoForeground);
    _writeColor(buffer, 'info-hover', palette.infoHover);
    _writeColor(buffer, 'info-container', palette.infoContainer);
    buffer.writeln();

    // Borders
    _writeColor(buffer, 'border', palette.border);
    _writeColor(buffer, 'input', palette.input);
    _writeColor(buffer, 'ring', palette.ring);
    buffer.writeln();

    // Overlays
    _writeRgba(buffer, 'overlay', palette.overlay);
    _writeRgba(buffer, 'navbar', palette.navbar);
    _writeColor(buffer, 'code-background', palette.codeBackground);
    buffer.writeln();

    // RGB values for compositing
    _writeRgb(buffer, 'background-rgb', palette.background);
    _writeRgb(buffer, 'foreground-rgb', palette.foreground);
    _writeRgb(buffer, 'primary-rgb', palette.primary);
    _writeRgb(buffer, 'secondary-rgb', palette.secondary);
    _writeRgb(buffer, 'accent-rgb', palette.accent);
    _writeRgb(buffer, 'muted-rgb', palette.mutedForeground);
    _writeRgb(buffer, 'destructive-rgb', palette.destructive);
    _writeRgb(buffer, 'success-rgb', palette.success);
    _writeRgb(buffer, 'warning-rgb', palette.warning);
    _writeRgb(buffer, 'info-rgb', palette.info);
    _writeRgb(buffer, 'card-rgb', palette.card);
    _writeRgb(buffer, 'border-rgb', palette.border);
    buffer.writeln();

    // Shadows
    buffer.writeln('  --shadow-xs: ${palette.shadowXs};');
    buffer.writeln('  --shadow-sm: ${palette.shadowSm};');
    buffer.writeln('  --shadow-md: ${palette.shadowMd};');
    buffer.writeln('  --shadow-lg: ${palette.shadowLg};');
    buffer.writeln('  --shadow-xl: ${palette.shadowXl};');
    buffer.writeln();

    // Static values (only for :root, not .dark)
    if (includeStatic) {
      // Typography
      buffer.writeln("  --font-sans: ${fonts.sans};");
      buffer.writeln("  --font-heading: ${fonts.headingOrSans};");
      buffer.writeln("  --font-mono: ${fonts.mono};");
      buffer.writeln();

      // Radius
      buffer.writeln('  --radius: ${radius.md};');
      buffer.writeln('  --radius-xs: ${radius.xs};');
      buffer.writeln('  --radius-sm: ${radius.sm};');
      buffer.writeln('  --radius-md: ${radius.md};');
      buffer.writeln('  --radius-lg: ${radius.lg};');
      buffer.writeln('  --radius-xl: ${radius.xl};');
      buffer.writeln('  --radius-2xl: ${radius.xxl};');
      buffer.writeln('  --radius-full: ${radius.full};');
      buffer.writeln();

      // Spacing scale
      buffer.writeln('  --space-0: 0;');
      buffer.writeln('  --space-px: 1px;');
      buffer.writeln('  --space-0-5: 0.125rem;');
      buffer.writeln('  --space-1: 0.25rem;');
      buffer.writeln('  --space-1-5: 0.375rem;');
      buffer.writeln('  --space-2: 0.5rem;');
      buffer.writeln('  --space-2-5: 0.625rem;');
      buffer.writeln('  --space-3: 0.75rem;');
      buffer.writeln('  --space-3-5: 0.875rem;');
      buffer.writeln('  --space-4: 1rem;');
      buffer.writeln('  --space-5: 1.25rem;');
      buffer.writeln('  --space-6: 1.5rem;');
      buffer.writeln('  --space-7: 1.75rem;');
      buffer.writeln('  --space-8: 2rem;');
      buffer.writeln('  --space-9: 2.25rem;');
      buffer.writeln('  --space-10: 2.5rem;');
      buffer.writeln('  --space-12: 3rem;');
      buffer.writeln('  --space-14: 3.5rem;');
      buffer.writeln('  --space-16: 4rem;');
      buffer.writeln('  --space-20: 5rem;');
      buffer.writeln('  --space-24: 6rem;');
      buffer.writeln('  --space-32: 8rem;');
      buffer.writeln();

      // Font sizes
      buffer.writeln('  --font-size-xs: 0.75rem;');
      buffer.writeln('  --font-size-sm: 0.875rem;');
      buffer.writeln('  --font-size-base: 1rem;');
      buffer.writeln('  --font-size-lg: 1.125rem;');
      buffer.writeln('  --font-size-xl: 1.25rem;');
      buffer.writeln('  --font-size-2xl: 1.5rem;');
      buffer.writeln('  --font-size-3xl: 1.875rem;');
      buffer.writeln('  --font-size-4xl: 2.25rem;');
      buffer.writeln('  --font-size-5xl: 3rem;');
      buffer.writeln();

      // Font weights
      buffer.writeln('  --font-weight-normal: 400;');
      buffer.writeln('  --font-weight-medium: 500;');
      buffer.writeln('  --font-weight-semibold: 600;');
      buffer.writeln('  --font-weight-bold: 700;');
      buffer.writeln();

      // Transitions
      buffer.writeln('  --transition-fast: 100ms ease;');
      buffer.writeln('  --transition: 150ms ease;');
      buffer.writeln('  --transition-slow: 200ms ease;');
      buffer.writeln('  --transition-slower: 300ms ease;');
    }

    buffer.writeln('}');
    return buffer.toString();
  }

  /// Generate CSS for both light and dark mode.
  static String generateBoth({
    required ThemePalette light,
    required ThemePalette dark,
    FontConfig fonts = const FontConfig(),
    RadiusConfig radius = const RadiusConfig(),
  }) {
    final StringBuffer buffer = StringBuffer();

    // Light mode (includes static values)
    buffer.writeln(generate(
      light,
      selector: ':root',
      fonts: fonts,
      radius: radius,
      includeStatic: true,
    ));

    buffer.writeln();

    // Dark mode (no static values, they inherit from :root)
    buffer.writeln(generate(
      dark,
      selector: '.dark',
      fonts: fonts,
      radius: radius,
      includeStatic: false,
    ));

    return buffer.toString();
  }

  // ============================================
  // Helper Methods
  // ============================================

  static void _writeColor(StringBuffer buffer, String name, int color) {
    buffer.writeln('  --$name: ${PaletteGenerator.toHex(color)};');
  }

  static void _writeRgb(StringBuffer buffer, String name, int color) {
    buffer.writeln('  --$name: ${PaletteGenerator.toRgbString(color)};');
  }

  static void _writeRgba(StringBuffer buffer, String name, int color) {
    buffer.writeln('  --$name: ${PaletteGenerator.toRgba(color)};');
  }
}
