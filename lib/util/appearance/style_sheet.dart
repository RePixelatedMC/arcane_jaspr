import 'color_scheme.dart';
import 'colors.dart';
import 'groups/container_tokens.dart';
import 'groups/indicator_tokens.dart';
import 'groups/input_tokens.dart';
import 'groups/interactive_tokens.dart';
import 'stylesheets/codex/codex_style.dart';
import 'stylesheets/shadcn/shadcn_style.dart';
import 'tokens/border_weight.dart';
import 'tokens/component_shape.dart';
import 'tokens/shadow_intensity.dart';

export 'groups/container_tokens.dart';
export 'groups/indicator_tokens.dart';
export 'groups/input_tokens.dart';
export 'groups/interactive_tokens.dart';
export 'tokens/animation_preset.dart';
export 'tokens/border_weight.dart';
export 'tokens/component_shape.dart';
export 'tokens/shadow_intensity.dart';

/// Represents a variant/preset within a stylesheet.
///
/// Used by stylesheets that support multiple color schemes or themes.
/// For example, ShadCN has neutral, slate, zinc, stone, gray presets.
class StyleSheetVariant {
  /// Unique identifier for this variant (used in CSS class names)
  final String id;

  /// Human-readable name for display in UI
  final String displayName;

  /// Optional icon name (for variant picker UI)
  final String? icon;

  const StyleSheetVariant({
    required this.id,
    required this.displayName,
    this.icon,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StyleSheetVariant &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}

/// Complete design system - colors, typography, layout, and component variants.
///
/// Each stylesheet is a self-contained design system that defines:
/// 1. ALL colors for light and dark modes
/// 2. Typography including font loading (Google Fonts or custom @font-face)
/// 3. Layout tokens (radius, shadows, spacing)
/// 4. Component variant defaults
///
/// Usage:
/// ```dart
/// ArcaneApp(
///   theme: ArcaneTheme(styleSheet: ArcaneStyleSheet.shadcn),
///   child: MyApp(),
/// )
/// ```
abstract class ArcaneStyleSheet {
  const ArcaneStyleSheet();

  // ===========================================================================
  // IDENTITY
  // ===========================================================================

  /// Unique identifier for this stylesheet
  String get id;

  /// Human-readable name
  String get name;

  // ===========================================================================
  // COLOR SYSTEM - Light Mode (19 core colors)
  // ===========================================================================

  /// Background color for light mode
  Color get backgroundLight;

  /// Foreground (text) color for light mode
  Color get foregroundLight;

  /// Card background for light mode
  Color get cardLight;

  /// Card foreground for light mode
  Color get cardForegroundLight;

  /// Popover background for light mode
  Color get popoverLight;

  /// Popover foreground for light mode
  Color get popoverForegroundLight;

  /// Primary action color for light mode
  Color get primaryLight;

  /// Primary foreground for light mode
  Color get primaryForegroundLight;

  /// Secondary color for light mode
  Color get secondaryLight;

  /// Secondary foreground for light mode
  Color get secondaryForegroundLight;

  /// Muted/subtle color for light mode
  Color get mutedLight;

  /// Muted foreground for light mode
  Color get mutedForegroundLight;

  /// Accent color for light mode
  Color get accentLight;

  /// Accent foreground for light mode
  Color get accentForegroundLight;

  /// Destructive/error color for light mode
  Color get destructiveLight;

  /// Destructive foreground for light mode
  Color get destructiveForegroundLight;

  /// Border color for light mode
  Color get borderLight;

  /// Input border color for light mode
  Color get inputLight;

  /// Focus ring color for light mode
  Color get ringLight;

  // ===========================================================================
  // COLOR SYSTEM - Dark Mode (19 core colors)
  // ===========================================================================

  /// Background color for dark mode
  Color get backgroundDark;

  /// Foreground (text) color for dark mode
  Color get foregroundDark;

  /// Card background for dark mode
  Color get cardDark;

  /// Card foreground for dark mode
  Color get cardForegroundDark;

  /// Popover background for dark mode
  Color get popoverDark;

  /// Popover foreground for dark mode
  Color get popoverForegroundDark;

  /// Primary action color for dark mode
  Color get primaryDark;

  /// Primary foreground for dark mode
  Color get primaryForegroundDark;

  /// Secondary color for dark mode
  Color get secondaryDark;

  /// Secondary foreground for dark mode
  Color get secondaryForegroundDark;

  /// Muted/subtle color for dark mode
  Color get mutedDark;

  /// Muted foreground for dark mode
  Color get mutedForegroundDark;

  /// Accent color for dark mode
  Color get accentDark;

  /// Accent foreground for dark mode
  Color get accentForegroundDark;

  /// Destructive/error color for dark mode
  Color get destructiveDark;

  /// Destructive foreground for dark mode
  Color get destructiveForegroundDark;

  /// Border color for dark mode
  Color get borderDark;

  /// Input border color for dark mode
  Color get inputDark;

  /// Focus ring color for dark mode
  Color get ringDark;

  // ===========================================================================
  // SEMANTIC COLORS (defaults provided, can override)
  // ===========================================================================

  /// Success color for light mode
  Color get successLight => Colors.emerald600;

  /// Success foreground for light mode
  Color get successForegroundLight => Colors.white;

  /// Success color for dark mode
  Color get successDark => Colors.emerald400;

  /// Success foreground for dark mode
  Color get successForegroundDark => const Color(0xFF09090B);

  /// Warning color for light mode
  Color get warningLight => Colors.amber600;

  /// Warning foreground for light mode
  Color get warningForegroundLight => const Color(0xFF09090B);

  /// Warning color for dark mode
  Color get warningDark => Colors.amber400;

  /// Warning foreground for dark mode
  Color get warningForegroundDark => const Color(0xFF09090B);

  /// Info color for light mode
  Color get infoLight => Colors.cyan600;

  /// Info foreground for light mode
  Color get infoForegroundLight => Colors.white;

  /// Info color for dark mode
  Color get infoDark => Colors.cyan400;

  /// Info foreground for dark mode
  Color get infoForegroundDark => const Color(0xFF09090B);

  // ===========================================================================
  // CHART COLORS (5 colors per mode)
  // ===========================================================================

  /// Chart color palette for light mode
  List<Color> get chartColorsLight => const [
        Color(0xFFE5484D), // Red
        Color(0xFF0091FF), // Blue
        Color(0xFFFFB224), // Amber
        Color(0xFF30A46C), // Green
        Color(0xFF9B59B6), // Purple
      ];

  /// Chart color palette for dark mode
  List<Color> get chartColorsDark => const [
        Color(0xFF3B82F6), // Blue
        Color(0xFF22C55E), // Green
        Color(0xFFF59E0B), // Amber
        Color(0xFFA855F7), // Purple
        Color(0xFFEC4899), // Pink
      ];

  // ===========================================================================
  // SIDEBAR COLORS (defaults to main colors, can override)
  // ===========================================================================

  /// Sidebar background for light mode
  Color get sidebarBackgroundLight => backgroundLight;

  /// Sidebar foreground for light mode
  Color get sidebarForegroundLight => foregroundLight;

  /// Sidebar primary for light mode
  Color get sidebarPrimaryLight => primaryLight;

  /// Sidebar primary foreground for light mode
  Color get sidebarPrimaryForegroundLight => primaryForegroundLight;

  /// Sidebar accent for light mode
  Color get sidebarAccentLight => accentLight;

  /// Sidebar accent foreground for light mode
  Color get sidebarAccentForegroundLight => accentForegroundLight;

  /// Sidebar border for light mode
  Color get sidebarBorderLight => borderLight;

  /// Sidebar ring for light mode
  Color get sidebarRingLight => ringLight;

  /// Sidebar background for dark mode
  Color get sidebarBackgroundDark => backgroundDark;

  /// Sidebar foreground for dark mode
  Color get sidebarForegroundDark => foregroundDark;

  /// Sidebar primary for dark mode
  Color get sidebarPrimaryDark => primaryDark;

  /// Sidebar primary foreground for dark mode
  Color get sidebarPrimaryForegroundDark => primaryForegroundDark;

  /// Sidebar accent for dark mode
  Color get sidebarAccentDark => accentDark;

  /// Sidebar accent foreground for dark mode
  Color get sidebarAccentForegroundDark => accentForegroundDark;

  /// Sidebar border for dark mode
  Color get sidebarBorderDark => borderDark;

  /// Sidebar ring for dark mode
  Color get sidebarRingDark => ringDark;

  // ===========================================================================
  // TYPOGRAPHY
  // ===========================================================================

  /// Primary sans-serif font family for body text
  String get fontSans;

  /// Font family for headings
  String get fontHeading;

  /// Monospace font family for code
  String get fontMono;

  /// Default letter spacing
  String get letterSpacing => '0em';

  /// Google Fonts URL to load (null if using custom @font-face)
  ///
  /// Example: 'https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap'
  String? get googleFontUrl => null;

  /// Custom @font-face CSS declarations (null if using Google Fonts)
  ///
  /// Should return complete @font-face blocks for custom fonts.
  String? get fontFaceCss => null;

  // ===========================================================================
  // RADIUS & CORNERS
  // ===========================================================================

  /// Base border radius scale factor (0.0 = square, 1.0 = fully rounded)
  double get radiusScale;

  /// Base radius value (e.g., '0.625rem' for shadcn)
  String get radius;

  /// Border radius for extra small elements
  String get radiusXs;

  /// Border radius for small components (buttons, inputs)
  String get radiusSm;

  /// Border radius for medium components (cards, dialogs)
  String get radiusMd;

  /// Border radius for large components (modals, sheets)
  String get radiusLg;

  /// Border radius for extra large components
  String get radiusXl;

  /// Border radius for 2xl components
  String get radius2xl;

  // ===========================================================================
  // SPACING
  // ===========================================================================

  /// Base spacing unit (e.g., '0.25rem' for shadcn)
  String get spacing => '0.25rem';

  /// Base spacing unit in pixels
  double get spacingUnit => 4.0;

  /// Spacing scale factor
  double get spacingScale => 1.0;

  // ===========================================================================
  // SHADOWS & DEPTH
  // ===========================================================================

  /// Whether to use shadows for elevation
  bool get useShadows;

  /// Shadow intensity multiplier (0.0 = no shadows, 1.0 = full)
  double get shadowIntensity;

  /// Shadow color
  Color get shadowColor => Colors.black;

  /// Shadow opacity (0.0 to 1.0)
  double get shadowOpacity => 0.1;

  /// Extra small shadow (subtle)
  String get shadowXs;

  /// Small shadow
  String get shadowSm;

  /// Medium shadow (default)
  String get shadowMd;

  /// Large shadow
  String get shadowLg;

  /// Extra large shadow
  String get shadowXl;

  // ===========================================================================
  // BORDERS
  // ===========================================================================

  /// Default border width
  String get borderWidth;

  /// Whether borders are more prominent than shadows (shadcn-style)
  bool get borderFocused;

  // ===========================================================================
  // ANIMATION & TRANSITIONS
  // ===========================================================================

  /// Transition duration fast (ms)
  int get transitionFast;

  /// Transition duration normal (ms)
  int get transitionNormal;

  /// Transition duration slow (ms)
  int get transitionSlow;

  /// Default easing function
  String get easingDefault;

  // ===========================================================================
  // SURFACE EFFECTS
  // ===========================================================================

  /// Default surface opacity for glass effects (dark mode)
  double get surfaceOpacity;

  /// Default surface opacity for light mode
  double get surfaceOpacityLight;

  /// Default blur radius for backdrop effects
  double get surfaceBlur;

  /// Whether to use glass/frosted effects
  bool get useGlassEffects;

  // ===========================================================================
  // COMPONENT DEFAULTS
  // ===========================================================================

  /// Default button style variant name
  String get buttonDefaultVariant;

  /// Default card style variant name
  String get cardDefaultVariant;

  /// Default input focus ring style
  String get focusRingStyle;

  // ===========================================================================
  // CSS VARIABLE GENERATION
  // ===========================================================================

  /// Generate complete CSS variables for this stylesheet
  ///
  /// Includes all colors (mode-specific), typography, layout tokens.
  /// This is the single source of truth for the entire design system.
  Map<String, String> toCssVariables(Brightness brightness) {
    final bool isDark = brightness == Brightness.dark;
    String rgb(Color color) => '${color.red}, ${color.green}, ${color.blue}';

    // Select colors based on brightness
    final Color background = isDark ? backgroundDark : backgroundLight;
    final Color foreground = isDark ? foregroundDark : foregroundLight;
    final Color card = isDark ? cardDark : cardLight;
    final Color cardForeground = isDark ? cardForegroundDark : cardForegroundLight;
    final Color popover = isDark ? popoverDark : popoverLight;
    final Color popoverForeground = isDark ? popoverForegroundDark : popoverForegroundLight;
    final Color primary = isDark ? primaryDark : primaryLight;
    final Color primaryForeground = isDark ? primaryForegroundDark : primaryForegroundLight;
    final Color secondary = isDark ? secondaryDark : secondaryLight;
    final Color secondaryForeground = isDark ? secondaryForegroundDark : secondaryForegroundLight;
    final Color muted = isDark ? mutedDark : mutedLight;
    final Color mutedForeground = isDark ? mutedForegroundDark : mutedForegroundLight;
    final Color accent = isDark ? accentDark : accentLight;
    final Color accentForeground = isDark ? accentForegroundDark : accentForegroundLight;
    final Color destructive = isDark ? destructiveDark : destructiveLight;
    final Color destructiveForeground = isDark ? destructiveForegroundDark : destructiveForegroundLight;
    final Color border = isDark ? borderDark : borderLight;
    final Color input = isDark ? inputDark : inputLight;
    final Color ring = isDark ? ringDark : ringLight;

    // Semantic colors
    final Color success = isDark ? successDark : successLight;
    final Color successForeground = isDark ? successForegroundDark : successForegroundLight;
    final Color warning = isDark ? warningDark : warningLight;
    final Color warningForeground = isDark ? warningForegroundDark : warningForegroundLight;
    final Color info = isDark ? infoDark : infoLight;
    final Color infoForeground = isDark ? infoForegroundDark : infoForegroundLight;

    // Sidebar colors
    final Color sidebarBackground = isDark ? sidebarBackgroundDark : sidebarBackgroundLight;
    final Color sidebarForeground = isDark ? sidebarForegroundDark : sidebarForegroundLight;
    final Color sidebarPrimary = isDark ? sidebarPrimaryDark : sidebarPrimaryLight;
    final Color sidebarPrimaryForeground = isDark ? sidebarPrimaryForegroundDark : sidebarPrimaryForegroundLight;
    final Color sidebarAccent = isDark ? sidebarAccentDark : sidebarAccentLight;
    final Color sidebarAccentForeground = isDark ? sidebarAccentForegroundDark : sidebarAccentForegroundLight;
    final Color sidebarBorder = isDark ? sidebarBorderDark : sidebarBorderLight;
    final Color sidebarRing = isDark ? sidebarRingDark : sidebarRingLight;

    // Chart colors
    final List<Color> chartColors = isDark ? chartColorsDark : chartColorsLight;

    // Surface opacity based on mode
    final double effectiveSurfaceOpacity = isDark ? surfaceOpacity : surfaceOpacityLight;

    return {
      // =====================================================================
      // IDENTITY
      // =====================================================================
      '--arcane-style-id': id,
      '--arcane-style-name': name,

      // =====================================================================
      // CORE COLORS
      // =====================================================================
      '--arcane-background': background.css,
      '--arcane-foreground': foreground.css,
      '--arcane-card': card.css,
      '--arcane-card-foreground': cardForeground.css,
      '--arcane-popover': popover.css,
      '--arcane-popover-foreground': popoverForeground.css,
      '--arcane-primary': primary.css,
      '--arcane-primary-foreground': primaryForeground.css,
      '--arcane-on-primary': primaryForeground.css,
      '--arcane-secondary': secondary.css,
      '--arcane-secondary-foreground': secondaryForeground.css,
      '--arcane-on-secondary': secondaryForeground.css,
      '--arcane-muted': muted.css,
      '--arcane-muted-foreground': mutedForeground.css,
      '--arcane-accent': accent.css,
      '--arcane-accent-foreground': accentForeground.css,
      '--arcane-destructive': destructive.css,
      '--arcane-destructive-foreground': destructiveForeground.css,
      '--arcane-border': border.css,
      '--arcane-input': input.css,
      '--arcane-ring': ring.css,

      // Material-style aliases for compatibility
      '--arcane-on-background': foreground.css,
      '--arcane-surface': card.css,
      '--arcane-on-surface': cardForeground.css,
      '--arcane-surface-variant': secondary.css,
      '--arcane-on-surface-variant': secondaryForeground.css,
      '--arcane-outline': border.css,
      '--arcane-outline-variant': input.css,
      '--arcane-error': destructive.css,
      '--arcane-on-error': destructiveForeground.css,
      '--arcane-tertiary': accent.css,
      '--arcane-on-tertiary': accentForeground.css,

      // =====================================================================
      // SEMANTIC COLORS
      // =====================================================================
      '--arcane-success': success.css,
      '--arcane-success-foreground': successForeground.css,
      '--arcane-success-hover': (isDark ? Colors.emerald300 : Colors.emerald700).css,
      '--arcane-success-container': 'rgba(${rgb(success)}, 0.1)',

      '--arcane-warning': warning.css,
      '--arcane-warning-foreground': warningForeground.css,
      '--arcane-warning-hover': (isDark ? Colors.amber300 : Colors.amber700).css,
      '--arcane-warning-container': 'rgba(${rgb(warning)}, 0.1)',

      '--arcane-info': info.css,
      '--arcane-info-foreground': infoForeground.css,
      '--arcane-info-hover': (isDark ? Colors.cyan300 : Colors.cyan700).css,
      '--arcane-info-container': 'rgba(${rgb(info)}, 0.1)',

      '--arcane-destructive-hover': (isDark ? Colors.red300 : Colors.red700).css,
      '--arcane-destructive-container': 'rgba(${rgb(destructive)}, 0.1)',

      // =====================================================================
      // EXTENDED COLORS
      // =====================================================================
      '--arcane-accent-hover': (isDark ? accent.lighten(10) : accent.darken(10)).css,
      '--arcane-accent-container': 'rgba(${rgb(accent)}, 0.1)',
      '--arcane-card-hover': isDark
          ? 'rgba(${rgb(foreground)}, 0.05)'
          : 'rgba(${rgb(foreground)}, 0.02)',
      '--arcane-card-alt': secondary.css,
      '--arcane-input-foreground': foreground.css,
      '--arcane-border-subtle': input.css,
      '--arcane-navbar': 'rgba(${rgb(background)}, $effectiveSurfaceOpacity)',
      '--arcane-background-secondary': (isDark ? background.lighten(3) : background.darken(3)).css,
      '--arcane-background-tertiary': (isDark ? background.lighten(6) : background.darken(6)).css,
      '--arcane-text-subtle': 'rgba(${rgb(mutedForeground)}, 0.85)',
      '--arcane-text-faint': 'rgba(${rgb(mutedForeground)}, 0.65)',
      '--arcane-overlay': 'rgba(0, 0, 0, 0.5)',
      '--arcane-overlay-strong': 'rgba(0, 0, 0, 0.7)',
      '--arcane-scrim': 'rgba(0, 0, 0, 0.5)',
      '--arcane-tooltip': popover.css,
      '--arcane-tooltip-foreground': popoverForeground.css,
      '--arcane-code-background': secondary.css,
      '--arcane-inverse-surface': (isDark ? Colors.white : Colors.black).css,
      '--arcane-on-inverse-surface': (isDark ? Colors.black : Colors.white).css,
      '--arcane-surface-tint': accent.css,
      '--arcane-shadow-color': shadowColor.css,
      '--arcane-barrier-color': 'rgba(0, 0, 0, 0.5)',

      // =====================================================================
      // CHART COLORS
      // =====================================================================
      '--arcane-chart-1': chartColors[0].css,
      '--arcane-chart-2': chartColors[1].css,
      '--arcane-chart-3': chartColors[2].css,
      '--arcane-chart-4': chartColors[3].css,
      '--arcane-chart-5': chartColors[4].css,

      // =====================================================================
      // SIDEBAR COLORS
      // =====================================================================
      '--arcane-sidebar-background': sidebarBackground.css,
      '--arcane-sidebar-foreground': sidebarForeground.css,
      '--arcane-sidebar-primary': sidebarPrimary.css,
      '--arcane-sidebar-primary-foreground': sidebarPrimaryForeground.css,
      '--arcane-sidebar-accent': sidebarAccent.css,
      '--arcane-sidebar-accent-foreground': sidebarAccentForeground.css,
      '--arcane-sidebar-border': sidebarBorder.css,
      '--arcane-sidebar-ring': sidebarRing.css,

      // =====================================================================
      // RGB CHANNELS (for alpha compositing)
      // =====================================================================
      '--arcane-background-rgb': rgb(background),
      '--arcane-foreground-rgb': rgb(foreground),
      '--arcane-primary-rgb': rgb(primary),
      '--arcane-secondary-rgb': rgb(secondary),
      '--arcane-tertiary-rgb': rgb(accent),
      '--arcane-accent-rgb': rgb(accent),
      '--arcane-accent-hover-rgb': rgb(isDark ? accent.lighten(10) : accent.darken(10)),
      '--arcane-accent-container-rgb': rgb(accent),
      '--arcane-muted-rgb': rgb(mutedForeground),
      '--arcane-destructive-rgb': rgb(destructive),
      '--arcane-success-rgb': rgb(success),
      '--arcane-warning-rgb': rgb(warning),
      '--arcane-info-rgb': rgb(info),
      '--arcane-error-rgb': rgb(destructive),
      '--arcane-on-error-rgb': rgb(destructiveForeground),
      '--arcane-on-background-rgb': rgb(foreground),
      '--arcane-surface-rgb': rgb(card),
      '--arcane-on-surface-rgb': rgb(cardForeground),
      '--arcane-surface-variant-rgb': rgb(secondary),
      '--arcane-on-surface-variant-rgb': rgb(secondaryForeground),
      '--arcane-outline-rgb': rgb(border),
      '--arcane-outline-variant-rgb': rgb(input),
      '--arcane-border-rgb': rgb(border),
      '--arcane-card-rgb': rgb(card),
      '--arcane-input-rgb': rgb(input),

      // =====================================================================
      // TYPOGRAPHY
      // =====================================================================
      '--arcane-font-sans': fontSans,
      '--arcane-font-heading': fontHeading,
      '--arcane-font-mono': fontMono,
      '--arcane-letter-spacing': letterSpacing,
      '--arcane-style-font-sans': fontSans,
      '--arcane-style-font-heading': fontHeading,
      '--arcane-style-font-mono': fontMono,

      // =====================================================================
      // RADIUS
      // =====================================================================
      '--arcane-radius': radius,
      '--arcane-radius-xs': radiusXs,
      '--arcane-radius-sm': radiusSm,
      '--arcane-radius-md': radiusMd,
      '--arcane-radius-lg': radiusLg,
      '--arcane-radius-xl': radiusXl,
      '--arcane-radius-2xl': radius2xl,
      '--arcane-radius-full': '9999px',
      '--arcane-style-radius-xs': radiusXs,
      '--arcane-style-radius-sm': radiusSm,
      '--arcane-style-radius-md': radiusMd,
      '--arcane-style-radius-lg': radiusLg,
      '--arcane-style-radius-xl': radiusXl,
      '--arcane-style-radius-2xl': radius2xl,

      // =====================================================================
      // SPACING
      // =====================================================================
      '--arcane-spacing': spacing,
      '--arcane-scaling': '${spacingScale}',

      // =====================================================================
      // SHADOWS
      // =====================================================================
      '--arcane-shadow-xs': shadowXs,
      '--arcane-shadow-sm': shadowSm,
      '--arcane-shadow': shadowMd,
      '--arcane-shadow-md': shadowMd,
      '--arcane-shadow-lg': shadowLg,
      '--arcane-shadow-xl': shadowXl,
      '--arcane-style-shadow-xs': shadowXs,
      '--arcane-style-shadow-sm': shadowSm,
      '--arcane-style-shadow-md': shadowMd,
      '--arcane-style-shadow-lg': shadowLg,
      '--arcane-style-shadow-xl': shadowXl,

      // =====================================================================
      // EFFECTS & TRANSITIONS
      // =====================================================================
      '--arcane-surface-opacity': '$effectiveSurfaceOpacity',
      '--arcane-surface-blur': '${surfaceBlur}px',
      '--arcane-style-surface-blur': '${surfaceBlur}px',
      '--arcane-style-glass-enabled': useGlassEffects ? '1' : '0',
      '--arcane-transition-fast': '${transitionFast}ms $easingDefault',
      '--arcane-transition': '${transitionNormal}ms $easingDefault',
      '--arcane-transition-slow': '${transitionSlow}ms $easingDefault',
      '--arcane-style-transition-fast': '${transitionFast}ms $easingDefault',
      '--arcane-style-transition': '${transitionNormal}ms $easingDefault',
      '--arcane-style-transition-slow': '${transitionSlow}ms $easingDefault',
      '--arcane-style-easing': easingDefault,

      // =====================================================================
      // BORDERS
      // =====================================================================
      '--arcane-style-border-width': borderWidth,
      '--arcane-style-focus-ring': focusRingStyle,

      // =====================================================================
      // GLOWS
      // =====================================================================
      '--arcane-accent-glow': 'rgba(${rgb(accent)}, 0.10)',
      '--arcane-secondary-glow': 'rgba(${rgb(secondary)}, 0.10)',
      '--arcane-grid-color': 'rgba(${rgb(accent)}, 0.03)',
    };
  }

  // ===========================================================================
  // VARIANT SYSTEM
  // ===========================================================================

  /// Available variants for this stylesheet.
  /// Stylesheets with multiple color presets should override this.
  /// Default returns a single variant representing the current configuration.
  List<StyleSheetVariant> get variants => [
        StyleSheetVariant(id: id, displayName: name),
      ];

  /// The currently selected variant ID.
  /// Should match one of the IDs in [variants].
  String get currentVariantId => id;

  /// Create a new stylesheet instance with a different variant.
  /// Override in subclasses that support multiple variants.
  ///
  /// Returns this instance if variantId matches current or is not supported.
  ArcaneStyleSheet withVariant(String variantId) => this;

  /// Generate CSS class name for a variant.
  /// Uses the format: arcane-{stylesheet-id}
  String cssClassForVariant(String variantId) => 'arcane-$variantId';

  /// Generate CSS variables for all variants of this stylesheet.
  ///
  /// Returns a map of variant ID -> CSS variable map for that variant.
  /// Each entry can be output as a CSS class selector.
  ///
  /// ```dart
  /// final allCss = stylesheet.generateAllVariantsCss(Brightness.dark);
  /// for (final entry in allCss.entries) {
  ///   // .arcane-{variantId}.arcane-dark { ... }
  /// }
  /// ```
  Map<String, Map<String, String>> generateAllVariantsCss(Brightness brightness) {
    final Map<String, Map<String, String>> result = {};
    for (final variant in variants) {
      final variantSheet = withVariant(variant.id);
      result[variant.id] = variantSheet.toCssVariables(brightness);
    }
    return result;
  }

  /// Generate complete CSS string for all variants (both light and dark modes).
  ///
  /// Output format:
  /// ```css
  /// .arcane-{variantId}.arcane-dark { ... }
  /// .arcane-{variantId}.arcane-light { ... }
  /// ```
  String generateCompleteCss() {
    final buffer = StringBuffer();

    for (final variant in variants) {
      final variantSheet = withVariant(variant.id);
      final className = cssClassForVariant(variant.id);

      // Dark mode
      buffer.writeln('.$className.arcane-dark {');
      final darkVars = variantSheet.toCssVariables(Brightness.dark);
      for (final entry in darkVars.entries) {
        buffer.writeln('  ${entry.key}: ${entry.value};');
      }
      buffer.writeln('}');

      // Light mode
      buffer.writeln('.$className.arcane-light {');
      final lightVars = variantSheet.toCssVariables(Brightness.light);
      for (final entry in lightVars.entries) {
        buffer.writeln('  ${entry.key}: ${entry.value};');
      }
      buffer.writeln('}');
    }

    // Default :root fallback (first variant, dark mode)
    buffer.writeln(':root {');
    final defaultVars = toCssVariables(Brightness.dark);
    for (final entry in defaultVars.entries) {
      buffer.writeln('  ${entry.key}: ${entry.value};');
    }
    buffer.writeln('}');

    return buffer.toString();
  }

  // ===========================================================================
  // STATIC PRESETS
  // ===========================================================================

  /// Codex design language (gaming aesthetic)
  ///
  /// Characteristics:
  /// - Sharp corners (smaller radius)
  /// - Rich shadows for depth
  /// - Glass/frosted effects
  /// - Custom premium fonts (Akzidenz-GroteskPro, ITCAvantGardeStd)
  /// - Smooth, moderate animations
  static const ArcaneStyleSheet codex = CodexStyleSheet();

  /// ShadCN design language (minimal, accessible, modern)
  ///
  /// Characteristics:
  /// - Rounded corners (0.625rem / 10px default)
  /// - Minimal shadows (border-focused)
  /// - No glass effects (clean, solid surfaces)
  /// - Google Fonts (Inter)
  /// - Quick, subtle animations
  static const ArcaneStyleSheet shadcn = ShadcnStyleSheet();
}
