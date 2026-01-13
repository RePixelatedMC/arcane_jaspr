import '../core/renderers.dart';
import '../theme/index.dart';

export '../core/renderers.dart' hide SheetPosition;

/// Base class for stylesheets.
///
/// A stylesheet provides:
/// 1. **Theme seeds** - Minimal color input (5-8 colors)
/// 2. **Component renderers** - HTML/CSS output for each component
/// 3. **Font/radius config** - Typography and border radius scales
/// 4. **Custom CSS** - Scrollbars, tree lines, animations, etc.
///
/// The base class automatically generates all CSS variables from seeds.
/// Stylesheets only need to define what's unique to their design language.
///
/// ## Usage
///
/// ```dart
/// ArcaneApp(
///   stylesheet: ShadcnStylesheet(),
///   child: MyApp(),
/// )
/// ```
///
/// ## Creating Custom Stylesheets
///
/// ```dart
/// class MyStylesheet extends ArcaneStylesheet {
///   const MyStylesheet();
///
///   @override
///   String get id => 'my-style';
///
///   @override
///   String get name => 'My Style';
///
///   @override
///   ComponentRenderers get renderers => const MyRenderers();
///
///   @override
///   ThemeSeed get lightSeed => ThemeSeed(
///     primary: 0xFF6366f1,  // Indigo
///     destructive: 0xFFef4444,
///     success: 0xFF22c55e,
///     warning: 0xFFf59e0b,
///     info: 0xFF3b82f6,
///   );
/// }
/// ```
abstract class ArcaneStylesheet {
  const ArcaneStylesheet();

  // ==========================================================================
  // REQUIRED OVERRIDES
  // ==========================================================================

  /// Unique identifier for this stylesheet.
  String get id;

  /// Human-readable display name.
  String get name;

  /// Component renderers for this stylesheet.
  ComponentRenderers get renderers;

  /// Light mode seed colors.
  ///
  /// Only define the essential colors - everything else is derived:
  /// - Foregrounds (auto-calculated for WCAG contrast)
  /// - Containers (10% opacity overlays)
  /// - Hover states (darken/lighten)
  /// - RGB values (for compositing)
  ThemeSeed get lightSeed;

  // ==========================================================================
  // OPTIONAL OVERRIDES
  // ==========================================================================

  /// Dark mode seed colors.
  ///
  /// Default: `lightSeed.toDark()` which:
  /// - Inverts to black background
  /// - Adjusts semantic colors to darker variants
  /// - Preserves primary color
  ThemeSeed get darkSeed => lightSeed.toDark();

  /// Font configuration.
  ///
  /// Default: Inter for sans, system monospace.
  FontConfig get fonts => const FontConfig();

  /// Border radius configuration.
  ///
  /// Default: Standard scale (4px to 18px).
  RadiusConfig get radius => const RadiusConfig();

  /// External CSS URLs to load (Google Fonts, CDN stylesheets, etc.)
  List<String> get externalCssUrls => const [];

  /// Font face declarations (@font-face rules).
  ///
  /// Override this to embed custom fonts.
  String get fontFaces => '';

  /// Component-specific CSS (scrollbars, tree lines, animations, etc.)
  ///
  /// This is where you put CSS that's specific to your design language
  /// but not related to colors (which are auto-generated).
  String get componentCss => '';

  /// Optional CSS class to apply to the body/root element.
  ///
  /// Used for stylesheet-specific features like Codex rainbow mode.
  /// Returns null or empty string by default.
  String? get bodyClass => null;

  // ==========================================================================
  // GENERATED CSS (DO NOT OVERRIDE)
  // ==========================================================================

  /// Complete CSS output including all variables and base styles.
  ///
  /// This is automatically generated from [lightSeed], [darkSeed],
  /// [fonts], [radius], and [componentCss]. Do not override.
  String get baseCss {
    final ThemePalette lightPalette = PaletteGenerator.generate(lightSeed);
    final ThemePalette darkPalette = PaletteGenerator.generate(darkSeed);

    return '''
$fontFaces

${CssGenerator.generateBoth(
      light: lightPalette,
      dark: darkPalette,
      fonts: fonts,
      radius: radius,
    )}

$_sharedBaseCss

$componentCss
''';
  }

  // ==========================================================================
  // DEPRECATED (remove after migration)
  // ==========================================================================

  /// @deprecated Use [componentCss] instead.
  String? get lightModeCss => null;

  /// @deprecated Use [componentCss] instead.
  String? get darkModeCss => null;

  // ==========================================================================
  // SHARED BASE CSS
  // ==========================================================================

  /// Base CSS shared by all stylesheets.
  ///
  /// Includes:
  /// - Box sizing reset
  /// - Body styling
  /// - Scrollbar styling
  /// - Selection highlighting
  /// - Focus ring utility
  /// - Spinner animation
  static const String _sharedBaseCss = '''
/* Base Reset */
*, *::before, *::after {
  box-sizing: border-box;
  margin: 0;
  padding: 0;
}

html, body {
  height: 100%;
  font-family: var(--font-sans);
  background-color: var(--background);
  color: var(--foreground);
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

/* Scrollbars - Themed with accent color */
* {
  scrollbar-width: thin;
  scrollbar-color: var(--primary) transparent;
}

*::-webkit-scrollbar {
  width: 8px;
  height: 8px;
}

*::-webkit-scrollbar-track {
  background: transparent;
}

*::-webkit-scrollbar-thumb {
  background: var(--primary);
  border-radius: 9999px;
  border: 2px solid transparent;
  background-clip: padding-box;
}

*::-webkit-scrollbar-thumb:hover {
  background: color-mix(in srgb, var(--primary) 80%, white);
  border: 2px solid transparent;
  background-clip: padding-box;
}

*::-webkit-scrollbar-corner {
  background: transparent;
}

/* Document-level scrollbar - uses CSS variables from html.dark/html.light */
html.dark, html.dark body,
html.light, html.light body {
  scrollbar-width: thin;
  scrollbar-color: var(--primary) var(--background);
}

html::-webkit-scrollbar,
body::-webkit-scrollbar {
  width: 8px;
  height: 8px;
}

html.dark::-webkit-scrollbar-track,
html.dark body::-webkit-scrollbar-track,
html.light::-webkit-scrollbar-track,
html.light body::-webkit-scrollbar-track {
  background: var(--background);
}

html.dark::-webkit-scrollbar-thumb,
html.dark body::-webkit-scrollbar-thumb,
html.light::-webkit-scrollbar-thumb,
html.light body::-webkit-scrollbar-thumb {
  background: var(--primary);
  border-radius: 9999px;
  border: 2px solid transparent;
  background-clip: padding-box;
}

html.dark::-webkit-scrollbar-thumb:hover,
html.dark body::-webkit-scrollbar-thumb:hover,
html.light::-webkit-scrollbar-thumb:hover,
html.light body::-webkit-scrollbar-thumb:hover {
  background: color-mix(in srgb, var(--primary) 80%, white);
  border: 2px solid transparent;
  background-clip: padding-box;
}

html.dark::-webkit-scrollbar-corner,
html.dark body::-webkit-scrollbar-corner,
html.light::-webkit-scrollbar-corner,
html.light body::-webkit-scrollbar-corner {
  background: var(--background);
}

/* Text Selection */
::selection {
  background: var(--primary);
  color: var(--primary-foreground);
}

::-moz-selection {
  background: var(--primary);
  color: var(--primary-foreground);
}

/* Focus Ring Utility */
.focus-ring:focus-visible {
  outline: none;
  box-shadow: 0 0 0 2px var(--background), 0 0 0 4px var(--ring);
}

/* Spinner Animation */
@keyframes arcane-spin {
  from { transform: rotate(0deg); }
  to { transform: rotate(360deg); }
}

/* Button Hover States */
.arcane-button:hover:not([disabled]) {
  filter: brightness(0.95);
}

.arcane-button:active:not([disabled]) {
  filter: brightness(0.9);
}
''';

  // ==========================================================================
  // PREDEFINED STYLESHEETS
  // ==========================================================================

  /// ShadCN UI stylesheet - minimal, modern, accessible.
  ///
  /// Clean, minimal design based on https://ui.shadcn.com
  /// Use [ShadcnStylesheet] from `shadcn_stylesheet.dart` for full implementation.
  static const ArcaneStylesheet shadcn = _ShadcnStylesheetRef();

  /// Codex stylesheet - gaming aesthetic with neon glows.
  ///
  /// OLED-optimized dark mode, vibrant accents, premium fonts.
  static const ArcaneStylesheet codex = _CodexStylesheetRef();
}

/// Placeholder that gets replaced with actual ShadcnStylesheet at runtime.
/// This allows the base class to reference ShadCN without circular imports.
class _ShadcnStylesheetRef extends ArcaneStylesheet {
  const _ShadcnStylesheetRef();

  @override
  String get id => 'shadcn';

  @override
  String get name => 'ShadCN UI';

  @override
  ComponentRenderers get renderers =>
      throw UnimplementedError('Import shadcn_stylesheet.dart to use ShadCN');

  @override
  ThemeSeed get lightSeed =>
      throw UnimplementedError('Import shadcn_stylesheet.dart to use ShadCN');
}

/// Placeholder for CodexStylesheet
class _CodexStylesheetRef extends ArcaneStylesheet {
  const _CodexStylesheetRef();

  @override
  String get id => 'codex';

  @override
  String get name => 'Codex';

  @override
  ComponentRenderers get renderers =>
      throw UnimplementedError('Import codex_stylesheet.dart to use Codex');

  @override
  ThemeSeed get lightSeed =>
      throw UnimplementedError('Import codex_stylesheet.dart to use Codex');
}
