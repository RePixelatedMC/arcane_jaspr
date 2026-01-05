import '../color_scheme.dart';
import '../colors.dart';
import '../style_sheet.dart';
import 'shadcn_presets.dart';

export 'shadcn_presets.dart' show ShadcnColorPreset;

/// ShadCN design language - exact values from ui.shadcn.com/docs/theming
///
/// Uses oklch color format directly from official ShadCN documentation.
/// Loads Inter font from Google Fonts.
///
/// Supports multiple gray scale presets via [colorPreset]:
/// - [ShadcnColorPreset.neutral] - Pure grayscale (default)
/// - [ShadcnColorPreset.stone] - Warm gray with yellow/brown undertones
/// - [ShadcnColorPreset.zinc] - Cool gray with purple undertones
/// - [ShadcnColorPreset.gray] - Balanced gray with slight blue undertones
/// - [ShadcnColorPreset.slate] - Blue-tinted gray
///
/// ```dart
/// // Default (Neutral)
/// ArcaneApp(
///   theme: ArcaneTheme(styleSheet: ShadcnStyleSheet()),
///   child: MyApp(),
/// )
///
/// // Zinc preset
/// ArcaneApp(
///   theme: ArcaneTheme(styleSheet: ShadcnStyleSheet(colorPreset: ShadcnColorPreset.zinc)),
///   child: MyApp(),
/// )
/// ```
class ShadcnStyleSheet extends ArcaneStyleSheet {
  /// The gray scale preset to use for neutral colors.
  final ShadcnColorPreset colorPreset;

  const ShadcnStyleSheet({
    this.colorPreset = ShadcnColorPreset.neutral,
  });

  /// Get the color data for the current preset
  ShadcnPresetColors get _colors => ShadcnPresets.getColors(colorPreset);

  // ===========================================================================
  // IDENTITY
  // ===========================================================================

  @override
  String get id => 'shadcn-${colorPreset.name}';

  @override
  String get name => 'ShadCN ${colorPreset.displayName}';

  // ===========================================================================
  // VARIANT SYSTEM
  // ===========================================================================

  @override
  List<StyleSheetVariant> get variants => [
        for (final preset in ShadcnColorPreset.values)
          StyleSheetVariant(
            id: 'shadcn-${preset.name}',
            displayName: preset.displayName,
          ),
      ];

  @override
  String get currentVariantId => id;

  @override
  ArcaneStyleSheet withVariant(String variantId) {
    // Parse variant ID (format: shadcn-{presetName})
    if (!variantId.startsWith('shadcn-')) return this;

    final presetName = variantId.substring(7); // Remove 'shadcn-' prefix
    for (final preset in ShadcnColorPreset.values) {
      if (preset.name == presetName) {
        return ShadcnStyleSheet(colorPreset: preset);
      }
    }
    return this;
  }

  // ===========================================================================
  // COLORS - Light Mode
  // ===========================================================================

  @override
  Color get backgroundLight => _colors.lightBackgroundColor;

  @override
  Color get foregroundLight => _colors.lightForegroundColor;

  @override
  Color get cardLight => _colors.lightCardColor;

  @override
  Color get cardForegroundLight => _colors.lightCardForegroundColor;

  @override
  Color get popoverLight => _colors.lightCardColor;

  @override
  Color get popoverForegroundLight => _colors.lightCardForegroundColor;

  @override
  Color get primaryLight => _colors.lightPrimaryColor;

  @override
  Color get primaryForegroundLight => _colors.lightPrimaryForegroundColor;

  @override
  Color get secondaryLight => _colors.lightSecondaryColor;

  @override
  Color get secondaryForegroundLight => _colors.lightSecondaryForegroundColor;

  @override
  Color get mutedLight => _colors.lightSecondaryColor;

  @override
  Color get mutedForegroundLight => _colors.lightMutedForegroundColor;

  @override
  Color get accentLight => _colors.lightAccentColor;

  @override
  Color get accentForegroundLight => _colors.lightSecondaryForegroundColor;

  @override
  Color get destructiveLight => const Color(0xFFEF4444);

  @override
  Color get destructiveForegroundLight => Colors.white;

  @override
  Color get borderLight => _colors.lightBorderColor;

  @override
  Color get inputLight => _colors.lightInputColor;

  @override
  Color get ringLight => const Color(0xFFA3A3A3);

  // ===========================================================================
  // COLORS - Dark Mode
  // ===========================================================================

  @override
  Color get backgroundDark => _colors.darkBackgroundColor;

  @override
  Color get foregroundDark => _colors.darkForegroundColor;

  @override
  Color get cardDark => _colors.darkCardColor;

  @override
  Color get cardForegroundDark => _colors.darkCardForegroundColor;

  @override
  Color get popoverDark => _colors.darkCardColor;

  @override
  Color get popoverForegroundDark => _colors.darkCardForegroundColor;

  @override
  Color get primaryDark => _colors.darkPrimaryColor;

  @override
  Color get primaryForegroundDark => _colors.darkPrimaryForegroundColor;

  @override
  Color get secondaryDark => _colors.darkSecondaryColor;

  @override
  Color get secondaryForegroundDark => _colors.darkSecondaryForegroundColor;

  @override
  Color get mutedDark => _colors.darkSecondaryColor;

  @override
  Color get mutedForegroundDark => _colors.darkMutedForegroundColor;

  @override
  Color get accentDark => _colors.darkAccentColor;

  @override
  Color get accentForegroundDark => _colors.darkSecondaryForegroundColor;

  @override
  Color get destructiveDark => _colors.darkDestructiveColor;

  @override
  Color get destructiveForegroundDark => _colors.darkDestructiveForegroundColor;

  @override
  Color get borderDark => _colors.darkBorderColor;

  @override
  Color get inputDark => _colors.darkInputColor;

  @override
  Color get ringDark => const Color(0xFF737373);

  // ===========================================================================
  // CHART COLORS
  // ===========================================================================

  @override
  List<Color> get chartColorsLight => const [
        Color(0xFF8CB4E0),
        Color(0xFF5B73C4),
        Color(0xFF4A5BB6),
        Color(0xFF3D4CA8),
        Color(0xFF323E8E),
      ];

  @override
  List<Color> get chartColorsDark => const [
        Color(0xFF8CB4E0),
        Color(0xFF5B73C4),
        Color(0xFF4A5BB6),
        Color(0xFF3D4CA8),
        Color(0xFF323E8E),
      ];

  // ===========================================================================
  // SIDEBAR COLORS
  // ===========================================================================

  @override
  Color get sidebarBackgroundLight => _colors.lightSecondaryColor;

  @override
  Color get sidebarForegroundLight => _colors.lightForegroundColor;

  @override
  Color get sidebarPrimaryLight => _colors.lightPrimaryColor;

  @override
  Color get sidebarPrimaryForegroundLight => _colors.lightPrimaryForegroundColor;

  @override
  Color get sidebarAccentLight => _colors.lightAccentColor;

  @override
  Color get sidebarAccentForegroundLight => _colors.lightSecondaryForegroundColor;

  @override
  Color get sidebarBorderLight => _colors.lightBorderColor;

  @override
  Color get sidebarRingLight => ringLight;

  @override
  Color get sidebarBackgroundDark => _colors.darkCardColor;

  @override
  Color get sidebarForegroundDark => _colors.darkForegroundColor;

  @override
  Color get sidebarPrimaryDark => _colors.darkPrimaryColor;

  @override
  Color get sidebarPrimaryForegroundDark => _colors.darkPrimaryForegroundColor;

  @override
  Color get sidebarAccentDark => _colors.darkAccentColor;

  @override
  Color get sidebarAccentForegroundDark => _colors.darkSecondaryForegroundColor;

  @override
  Color get sidebarBorderDark => _colors.darkBorderColor;

  @override
  Color get sidebarRingDark => ringDark;

  // ===========================================================================
  // TYPOGRAPHY
  // ===========================================================================

  @override
  String get fontSans =>
      "'Inter', ui-sans-serif, system-ui, -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, 'Helvetica Neue', Arial, sans-serif";

  @override
  String get fontHeading =>
      "'Inter', ui-sans-serif, system-ui, -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, 'Helvetica Neue', Arial, sans-serif";

  @override
  String get fontMono =>
      "ui-monospace, SFMono-Regular, Menlo, Monaco, Consolas, 'Liberation Mono', 'Courier New', monospace";

  @override
  String get letterSpacing => '0em';

  @override
  String? get googleFontUrl =>
      'https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap';

  @override
  String? get fontFaceCss => null;

  // ===========================================================================
  // RADIUS
  // ===========================================================================

  @override
  double get radiusScale => 0.625;

  @override
  String get radius => '0.625rem';

  @override
  String get radiusXs => '4px';

  @override
  String get radiusSm => '6px';

  @override
  String get radiusMd => '8px';

  @override
  String get radiusLg => '10px';

  @override
  String get radiusXl => '14px';

  @override
  String get radius2xl => '18px';

  // ===========================================================================
  // SHADOWS
  // ===========================================================================

  @override
  bool get useShadows => true;

  @override
  double get shadowIntensity => 0.1;

  @override
  String get shadowXs => '0 1px 3px 0px hsl(0 0% 0% / 0.05)';

  @override
  String get shadowSm =>
      '0 1px 3px 0px hsl(0 0% 0% / 0.10), 0 1px 2px -1px hsl(0 0% 0% / 0.10)';

  @override
  String get shadowMd =>
      '0 1px 3px 0px hsl(0 0% 0% / 0.10), 0 2px 4px -1px hsl(0 0% 0% / 0.10)';

  @override
  String get shadowLg =>
      '0 1px 3px 0px hsl(0 0% 0% / 0.10), 0 4px 6px -1px hsl(0 0% 0% / 0.10)';

  @override
  String get shadowXl =>
      '0 1px 3px 0px hsl(0 0% 0% / 0.10), 0 8px 10px -1px hsl(0 0% 0% / 0.10)';

  // ===========================================================================
  // BORDERS
  // ===========================================================================

  @override
  String get borderWidth => '1px';

  @override
  bool get borderFocused => true;

  // ===========================================================================
  // TRANSITIONS
  // ===========================================================================

  @override
  int get transitionFast => 100;

  @override
  int get transitionNormal => 150;

  @override
  int get transitionSlow => 200;

  @override
  String get easingDefault => 'cubic-bezier(0.4, 0, 0.2, 1)';

  // ===========================================================================
  // SURFACE EFFECTS
  // ===========================================================================

  @override
  double get surfaceOpacity => 1.0;

  @override
  double get surfaceOpacityLight => 1.0;

  @override
  double get surfaceBlur => 0.0;

  @override
  bool get useGlassEffects => false;

  // ===========================================================================
  // COMPONENT DEFAULTS
  // ===========================================================================

  @override
  String get buttonDefaultVariant => 'default';

  @override
  String get cardDefaultVariant => 'default';

  @override
  String get focusRingStyle => '2px solid var(--arcane-ring)';

  // ===========================================================================
  // CSS VARIABLE GENERATION - Output oklch directly
  // ===========================================================================

  @override
  Map<String, String> toCssVariables(Brightness brightness) {
    final bool isDark = brightness == Brightness.dark;
    final ShadcnPresetColors colors = _colors;

    // RGB helper for rgba() compositing
    String rgb(Color color) => '${color.red}, ${color.green}, ${color.blue}';

    // Select oklch values based on brightness
    final background = isDark ? colors.darkBackground : colors.lightBackground;
    final foreground = isDark ? colors.darkForeground : colors.lightForeground;
    final card = isDark ? colors.darkCard : colors.lightCard;
    final cardForeground = isDark ? colors.darkCardForeground : colors.lightCardForeground;
    final popover = isDark ? colors.darkPopover : colors.lightPopover;
    final popoverForeground = isDark ? colors.darkPopoverForeground : colors.lightPopoverForeground;
    final primary = isDark ? colors.darkPrimary : colors.lightPrimary;
    final primaryForeground = isDark ? colors.darkPrimaryForeground : colors.lightPrimaryForeground;
    final secondary = isDark ? colors.darkSecondary : colors.lightSecondary;
    final secondaryForeground = isDark ? colors.darkSecondaryForeground : colors.lightSecondaryForeground;
    final muted = isDark ? colors.darkMuted : colors.lightMuted;
    final mutedForeground = isDark ? colors.darkMutedForeground : colors.lightMutedForeground;
    final accent = isDark ? colors.darkAccent : colors.lightAccent;
    final accentForeground = isDark ? colors.darkAccentForeground : colors.lightAccentForeground;
    final destructive = isDark ? colors.darkDestructive : colors.lightDestructive;
    final destructiveForeground = isDark ? colors.darkDestructiveForeground : colors.lightDestructiveForeground;
    final border = isDark ? colors.darkBorder : colors.lightBorder;
    final input = isDark ? colors.darkInput : colors.lightInput;
    final ring = isDark ? colors.darkRing : colors.lightRing;

    final sidebarBackground = isDark ? colors.darkSidebarBackground : colors.lightSidebarBackground;
    final sidebarForeground = isDark ? colors.darkSidebarForeground : colors.lightSidebarForeground;
    final sidebarPrimary = isDark ? colors.darkSidebarPrimary : colors.lightSidebarPrimary;
    final sidebarPrimaryForeground = isDark ? colors.darkSidebarPrimaryForeground : colors.lightSidebarPrimaryForeground;
    final sidebarAccent = isDark ? colors.darkSidebarAccent : colors.lightSidebarAccent;
    final sidebarAccentForeground = isDark ? colors.darkSidebarAccentForeground : colors.lightSidebarAccentForeground;
    final sidebarBorder = isDark ? colors.darkSidebarBorder : colors.lightSidebarBorder;
    final sidebarRing = isDark ? colors.darkSidebarRing : colors.lightSidebarRing;

    // Color objects for RGB channels
    final success = isDark ? successDark : successLight;
    final successForeground = isDark ? successForegroundDark : successForegroundLight;
    final warning = isDark ? warningDark : warningLight;
    final warningForeground = isDark ? warningForegroundDark : warningForegroundLight;
    final info = isDark ? infoDark : infoLight;
    final infoForeground = isDark ? infoForegroundDark : infoForegroundLight;

    final primaryColor = isDark ? colors.darkPrimaryColor : colors.lightPrimaryColor;
    final secondaryColor = isDark ? colors.darkSecondaryColor : colors.lightSecondaryColor;
    final accentColor = isDark ? colors.darkAccentColor : colors.lightAccentColor;
    final mutedForegroundColor = isDark ? colors.darkMutedForegroundColor : colors.lightMutedForegroundColor;
    final destructiveColor = isDark ? colors.darkDestructiveColor : destructiveLight;
    final destructiveForegroundColor = isDark ? colors.darkDestructiveForegroundColor : destructiveForegroundLight;
    final borderColor = isDark ? colors.darkBorderColor : colors.lightBorderColor;
    final inputColor = isDark ? colors.darkInputColor : colors.lightInputColor;
    final backgroundColorObj = isDark ? colors.darkBackgroundColor : colors.lightBackgroundColor;
    final foregroundColorObj = isDark ? colors.darkForegroundColor : colors.lightForegroundColor;
    final cardColorObj = isDark ? colors.darkCardColor : colors.lightCardColor;
    final cardForegroundColorObj = isDark ? colors.darkCardForegroundColor : colors.lightCardForegroundColor;

    final List<Color> chartColors = isDark ? chartColorsDark : chartColorsLight;
    final double effectiveSurfaceOpacity = isDark ? surfaceOpacity : surfaceOpacityLight;

    return {
      // Identity
      '--arcane-style-id': id,
      '--arcane-style-name': name,

      // Core colors (oklch)
      '--arcane-background': background,
      '--arcane-foreground': foreground,
      '--arcane-card': card,
      '--arcane-card-foreground': cardForeground,
      '--arcane-popover': popover,
      '--arcane-popover-foreground': popoverForeground,
      '--arcane-primary': primary,
      '--arcane-primary-foreground': primaryForeground,
      '--arcane-on-primary': primaryForeground,
      '--arcane-secondary': secondary,
      '--arcane-secondary-foreground': secondaryForeground,
      '--arcane-on-secondary': secondaryForeground,
      '--arcane-muted': muted,
      '--arcane-muted-foreground': mutedForeground,
      '--arcane-accent': accent,
      '--arcane-accent-foreground': accentForeground,
      '--arcane-destructive': destructive,
      '--arcane-destructive-foreground': destructiveForeground,
      '--arcane-border': border,
      '--arcane-input': input,
      '--arcane-ring': ring,

      // Material-style aliases
      '--arcane-on-background': foreground,
      '--arcane-surface': card,
      '--arcane-on-surface': cardForeground,
      '--arcane-surface-variant': secondary,
      '--arcane-on-surface-variant': secondaryForeground,
      '--arcane-outline': border,
      '--arcane-outline-variant': input,
      '--arcane-error': destructive,
      '--arcane-on-error': destructiveForeground,
      '--arcane-tertiary': accent,
      '--arcane-on-tertiary': accentForeground,

      // Semantic colors
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
      '--arcane-destructive-container': 'rgba(${rgb(destructiveColor)}, 0.1)',

      // Extended colors (oklch with computed variants)
      '--arcane-accent-hover': isDark
          ? 'oklch(${_adjustLightness(accent, 0.03)})'
          : 'oklch(${_adjustLightness(accent, -0.03)})',
      '--arcane-accent-container': 'rgba(${rgb(accentColor)}, 0.1)',
      '--arcane-card-hover': isDark
          ? 'rgba(${rgb(foregroundColorObj)}, 0.05)'
          : 'rgba(${rgb(foregroundColorObj)}, 0.02)',
      '--arcane-card-alt': secondary,
      '--arcane-input-foreground': foreground,
      '--arcane-border-subtle': input,
      '--arcane-navbar': 'rgba(${rgb(backgroundColorObj)}, $effectiveSurfaceOpacity)',
      '--arcane-background-secondary': isDark
          ? 'oklch(${_adjustLightness(background, 0.02)})'
          : 'oklch(${_adjustLightness(background, -0.03)})',
      '--arcane-background-tertiary': isDark
          ? 'oklch(${_adjustLightness(background, 0.04)})'
          : 'oklch(${_adjustLightness(background, -0.06)})',
      '--arcane-text-subtle': 'rgba(${rgb(mutedForegroundColor)}, 0.85)',
      '--arcane-text-faint': 'rgba(${rgb(mutedForegroundColor)}, 0.65)',
      '--arcane-overlay': 'rgba(0, 0, 0, 0.5)',
      '--arcane-overlay-strong': 'rgba(0, 0, 0, 0.7)',
      '--arcane-scrim': 'rgba(0, 0, 0, 0.5)',
      '--arcane-tooltip': popover,
      '--arcane-tooltip-foreground': popoverForeground,
      '--arcane-code-background': secondary,
      '--arcane-inverse-surface': isDark ? 'oklch(1 0 0)' : 'oklch(0 0 0)',
      '--arcane-on-inverse-surface': isDark ? 'oklch(0 0 0)' : 'oklch(1 0 0)',
      '--arcane-surface-tint': accent,
      '--arcane-shadow-color': shadowColor.css,
      '--arcane-barrier-color': 'rgba(0, 0, 0, 0.5)',

      // Chart colors
      '--arcane-chart-1': chartColors[0].css,
      '--arcane-chart-2': chartColors[1].css,
      '--arcane-chart-3': chartColors[2].css,
      '--arcane-chart-4': chartColors[3].css,
      '--arcane-chart-5': chartColors[4].css,

      // Sidebar colors (oklch)
      '--arcane-sidebar-background': sidebarBackground,
      '--arcane-sidebar-foreground': sidebarForeground,
      '--arcane-sidebar-primary': sidebarPrimary,
      '--arcane-sidebar-primary-foreground': sidebarPrimaryForeground,
      '--arcane-sidebar-accent': sidebarAccent,
      '--arcane-sidebar-accent-foreground': sidebarAccentForeground,
      '--arcane-sidebar-border': sidebarBorder,
      '--arcane-sidebar-ring': sidebarRing,

      // RGB channels for rgba() compositing
      '--arcane-background-rgb': rgb(backgroundColorObj),
      '--arcane-foreground-rgb': rgb(foregroundColorObj),
      '--arcane-primary-rgb': rgb(primaryColor),
      '--arcane-secondary-rgb': rgb(secondaryColor),
      '--arcane-tertiary-rgb': rgb(accentColor),
      '--arcane-accent-rgb': rgb(accentColor),
      '--arcane-accent-hover-rgb': rgb(isDark ? accentColor.lighten(10) : accentColor.darken(10)),
      '--arcane-accent-container-rgb': rgb(accentColor),
      '--arcane-muted-rgb': rgb(mutedForegroundColor),
      '--arcane-destructive-rgb': rgb(destructiveColor),
      '--arcane-success-rgb': rgb(success),
      '--arcane-warning-rgb': rgb(warning),
      '--arcane-info-rgb': rgb(info),
      '--arcane-error-rgb': rgb(destructiveColor),
      '--arcane-on-error-rgb': rgb(destructiveForegroundColor),
      '--arcane-on-background-rgb': rgb(foregroundColorObj),
      '--arcane-surface-rgb': rgb(cardColorObj),
      '--arcane-on-surface-rgb': rgb(cardForegroundColorObj),
      '--arcane-surface-variant-rgb': rgb(secondaryColor),
      '--arcane-on-surface-variant-rgb': rgb(isDark ? colors.darkSecondaryForegroundColor : colors.lightSecondaryForegroundColor),
      '--arcane-outline-rgb': rgb(borderColor),
      '--arcane-outline-variant-rgb': rgb(inputColor),
      '--arcane-border-rgb': rgb(borderColor),
      '--arcane-card-rgb': rgb(cardColorObj),
      '--arcane-input-rgb': rgb(inputColor),

      // Typography
      '--arcane-font-sans': fontSans,
      '--arcane-font-heading': fontHeading,
      '--arcane-font-mono': fontMono,
      '--arcane-letter-spacing': letterSpacing,
      '--arcane-style-font-sans': fontSans,
      '--arcane-style-font-heading': fontHeading,
      '--arcane-style-font-mono': fontMono,

      // Radius
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

      // Spacing
      '--arcane-spacing': spacing,
      '--arcane-scaling': '$spacingScale',

      // Shadows
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

      // Effects & transitions
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

      // Borders
      '--arcane-style-border-width': borderWidth,
      '--arcane-style-focus-ring': focusRingStyle,

      // Glows
      '--arcane-accent-glow': 'rgba(${rgb(accentColor)}, 0.10)',
      '--arcane-secondary-glow': 'rgba(${rgb(secondaryColor)}, 0.10)',
      '--arcane-grid-color': 'rgba(${rgb(accentColor)}, 0.03)',
    };
  }

  /// Helper to adjust oklch lightness value from an oklch string
  String _adjustLightness(String oklch, double delta) {
    // Parse oklch(L C H) format
    final match = RegExp(r'oklch\(([0-9.]+)\s+([0-9.]+)\s+([0-9.]+)\)').firstMatch(oklch);
    if (match != null) {
      final l = double.parse(match.group(1)!);
      final c = match.group(2)!;
      final h = match.group(3)!;
      final newL = (l + delta).clamp(0.0, 1.0);
      return '$newL $c $h';
    }
    // If no hue (neutral), format is oklch(L 0 0)
    final neutralMatch = RegExp(r'oklch\(([0-9.]+)\s+0\s+0\)').firstMatch(oklch);
    if (neutralMatch != null) {
      final l = double.parse(neutralMatch.group(1)!);
      final newL = (l + delta).clamp(0.0, 1.0);
      return '$newL 0 0';
    }
    return oklch;
  }
}
