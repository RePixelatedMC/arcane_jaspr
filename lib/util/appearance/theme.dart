import 'package:jaspr/jaspr.dart';

import 'color_scheme.dart';
import 'colors.dart';
import 'style_sheet.dart';
import 'stylesheets/codex_style.dart';
import 'stylesheets/shadcn_style.dart';

export 'color_scheme.dart' show Brightness, ThemeMode;
export 'colors.dart';
export 'style_sheet.dart';
export 'stylesheets/stylesheets.dart';

/// Main theme configuration for Arcane Jaspr
///
/// Stylesheets are complete design systems that include ALL colors, typography,
/// layout tokens, and component defaults. Switch between radically different
/// visual styles by changing the stylesheet:
///
/// ```dart
/// ArcaneApp(
///   theme: ArcaneTheme.codex,  // Gaming aesthetic
///   child: MyApp(),
/// )
///
/// ArcaneApp(
///   theme: ArcaneTheme.shadcn, // Minimal/modern
///   child: MyApp(),
/// )
/// ```
class ArcaneTheme {
  /// The complete design system (colors, typography, layout, effects)
  final ArcaneStyleSheet styleSheet;

  /// The current theme mode (system, light, dark)
  final ThemeMode themeMode;

  /// Border radius scaling override.
  /// If null, uses the stylesheet's radiusScale.
  final double? radiusOverride;

  /// Surface opacity override for glass effects in dark mode.
  /// If null, uses the stylesheet's surfaceOpacity.
  final double? surfaceOpacityOverride;

  /// Surface opacity override for light mode.
  /// If null, uses the stylesheet's surfaceOpacityLight.
  final double? surfaceOpacityLightOverride;

  /// Blur radius override for surface effects.
  /// If null, uses the stylesheet's surfaceBlur.
  final double? surfaceBlurOverride;

  /// Global scaling factor
  final double scaling;

  /// Toast theme configuration
  final ArcaneToastTheme toast;

  /// Gutter theme configuration
  final GutterTheme gutter;

  /// Navigation theme configuration
  final NavigationTheme navigation;

  /// Card carousel theme configuration
  final CardCarouselTheme cardCarousel;

  /// Barrier colors for dialogs/overlays
  final ArcaneBarriers barrierColors;

  /// When true, secondary and tertiary backgrounds match the primary background.
  /// Use this for sleek, uniform dark designs without section contrast.
  final bool uniformBackgrounds;

  const ArcaneTheme({
    this.styleSheet = const CodexStyleSheet(),
    this.themeMode = ThemeMode.system,
    double? radius,
    double? surfaceOpacity,
    double? surfaceOpacityLight,
    double? surfaceBlur,
    this.scaling = 1.0,
    this.toast = const ArcaneToastTheme(),
    this.gutter = const GutterTheme(),
    this.navigation = const NavigationTheme(),
    this.cardCarousel = const CardCarouselTheme(),
    this.barrierColors = const ArcaneBarriers(),
    this.uniformBackgrounds = false,
  })  : radiusOverride = radius,
        surfaceOpacityOverride = surfaceOpacity,
        surfaceOpacityLightOverride = surfaceOpacityLight,
        surfaceBlurOverride = surfaceBlur;

  /// Border radius scaling (0.0 = square, 1.0 = fully rounded)
  /// Uses radiusOverride if set, otherwise falls back to stylesheet.
  double get radius => radiusOverride ?? styleSheet.radiusScale;

  /// Surface opacity for glass effects in dark mode.
  /// Uses surfaceOpacityOverride if set, otherwise falls back to stylesheet.
  double get surfaceOpacity =>
      surfaceOpacityOverride ?? styleSheet.surfaceOpacity;

  /// Surface opacity for light mode.
  /// Uses surfaceOpacityLightOverride if set, otherwise falls back to stylesheet.
  double get surfaceOpacityLight =>
      surfaceOpacityLightOverride ?? styleSheet.surfaceOpacityLight;

  /// Blur radius for surface effects.
  /// Uses surfaceBlurOverride if set, otherwise falls back to stylesheet.
  double get surfaceBlur => surfaceBlurOverride ?? styleSheet.surfaceBlur;

  // =========================================================================
  // STATIC STYLESHEET PRESETS
  // =========================================================================

  /// Codex design language (gaming aesthetic)
  ///
  /// Features:
  /// - Custom premium fonts (Akzidenz-GroteskPro, ITCAvantGardeStd)
  /// - Sharp corners, rich shadows
  /// - Glass/frosted effects
  /// - Emerald accent color
  static const ArcaneTheme codex = ArcaneTheme(styleSheet: CodexStyleSheet());

  /// ShadCN design language (minimal, modern)
  ///
  /// Features:
  /// - Google Fonts (Inter)
  /// - Rounded corners (0.625rem)
  /// - Minimal shadows, border-focused
  /// - No glass effects
  /// - Matches tweakcn.com exactly
  static const ArcaneTheme shadcn = ArcaneTheme(styleSheet: ShadcnStyleSheet());

  /// Get the current brightness based on theme mode
  Brightness get brightness {
    if (themeMode == ThemeMode.system) {
      return Brightness.dark; // Default to dark for system
    }
    return themeMode.brightness;
  }

  /// Whether currently in dark mode
  bool get isDark => brightness == Brightness.dark;

  /// Whether currently in light mode
  bool get isLight => brightness == Brightness.light;

  /// Copy with modifications
  ArcaneTheme copyWith({
    ArcaneStyleSheet? styleSheet,
    ThemeMode? themeMode,
    double? radius,
    double? surfaceOpacity,
    double? surfaceOpacityLight,
    double? surfaceBlur,
    double? scaling,
    ArcaneToastTheme? toast,
    GutterTheme? gutter,
    NavigationTheme? navigation,
    CardCarouselTheme? cardCarousel,
    ArcaneBarriers? barrierColors,
    bool? uniformBackgrounds,
  }) {
    return ArcaneTheme(
      styleSheet: styleSheet ?? this.styleSheet,
      themeMode: themeMode ?? this.themeMode,
      radius: radius ?? radiusOverride,
      surfaceOpacity: surfaceOpacity ?? surfaceOpacityOverride,
      surfaceOpacityLight: surfaceOpacityLight ?? surfaceOpacityLightOverride,
      surfaceBlur: surfaceBlur ?? surfaceBlurOverride,
      scaling: scaling ?? this.scaling,
      toast: toast ?? this.toast,
      gutter: gutter ?? this.gutter,
      navigation: navigation ?? this.navigation,
      cardCarousel: cardCarousel ?? this.cardCarousel,
      barrierColors: barrierColors ?? this.barrierColors,
      uniformBackgrounds: uniformBackgrounds ?? this.uniformBackgrounds,
    );
  }

  /// Create a copy with a different stylesheet
  ArcaneTheme withStyleSheet(ArcaneStyleSheet newStyleSheet) {
    return copyWith(styleSheet: newStyleSheet);
  }

  /// Get effective surface opacity based on brightness
  double get effectiveSurfaceOpacity =>
      brightness == Brightness.light ? surfaceOpacityLight : surfaceOpacity;

  /// Get current accent color from stylesheet
  Color get accentPrimary =>
      isDark ? styleSheet.primaryDark : styleSheet.primaryLight;

  /// Get current foreground color from stylesheet
  Color get foreground =>
      isDark ? styleSheet.foregroundDark : styleSheet.foregroundLight;

  /// Get current background color from stylesheet
  Color get background =>
      isDark ? styleSheet.backgroundDark : styleSheet.backgroundLight;

  /// Generate CSS custom properties for the theme
  ///
  /// All CSS variables come from the stylesheet's toCssVariables method.
  /// This is the single source of truth for the entire app appearance.
  Map<String, String> get cssVariables {
    final Map<String, String> vars = styleSheet.toCssVariables(brightness);

    // Add uniform background overrides if enabled
    if (uniformBackgrounds) {
      final Color bg =
          isDark ? styleSheet.backgroundDark : styleSheet.backgroundLight;
      vars['--arcane-background-secondary'] = bg.css;
      vars['--arcane-background-tertiary'] = bg.css;
    }

    // Add barrier color overrides
    vars['--arcane-barrier-color'] = barrierColors.dialog.css;
    vars['--arcane-overlay'] = barrierColors.dialog.css;

    // Add scaling
    vars['--arcane-scaling'] = '$scaling';

    return vars;
  }

  /// Generate inline style string for CSS variables
  String get cssVariablesStyle {
    return cssVariables.entries.map((e) => '${e.key}: ${e.value}').join('; ');
  }

  /// Get theme from context (via InheritedComponent)
  static ArcaneTheme of(BuildContext context) {
    return ArcaneThemeProvider.of(context)?.theme ?? const ArcaneTheme();
  }

  /// Try to get theme from context
  static ArcaneTheme? maybeOf(BuildContext context) {
    return ArcaneThemeProvider.of(context)?.theme;
  }
}

/// Toast theme configuration
class ArcaneToastTheme {
  final Duration duration;
  final double maxWidth;

  const ArcaneToastTheme({
    this.duration = const Duration(seconds: 4),
    this.maxWidth = 400,
  });
}

/// Gutter theme configuration
class GutterTheme {
  final double small;
  final double medium;
  final double large;

  const GutterTheme({
    this.small = 8,
    this.medium = 16,
    this.large = 24,
  });
}

/// Navigation theme configuration
class NavigationTheme {
  final double sidebarWidth;
  final double sidebarCollapsedWidth;
  final double bottomNavHeight;

  const NavigationTheme({
    this.sidebarWidth = 280,
    this.sidebarCollapsedWidth = 64,
    this.bottomNavHeight = 64,
  });
}

/// Card carousel theme configuration
class CardCarouselTheme {
  final double cardWidth;
  final double cardHeight;
  final double spacing;

  const CardCarouselTheme({
    this.cardWidth = 300,
    this.cardHeight = 200,
    this.spacing = 16,
  });
}

/// Barrier colors for overlays
class ArcaneBarriers {
  final Color barrierColor;
  final double barrierOpacity;
  final Color? dialogBarrierColor;
  final double? dialogBarrierOpacity;
  final Color? menuBarrierColor;
  final double? menuBarrierOpacity;

  const ArcaneBarriers({
    this.barrierColor = Colors.black,
    this.barrierOpacity = 0.5,
    this.dialogBarrierColor,
    this.dialogBarrierOpacity,
    this.menuBarrierColor,
    this.menuBarrierOpacity,
  });

  Color get dialog => (dialogBarrierColor ?? barrierColor)
      .withOpacity(dialogBarrierOpacity ?? barrierOpacity);

  Color get menu => (menuBarrierColor ?? barrierColor)
      .withOpacity(menuBarrierOpacity ?? barrierOpacity);
}

/// InheritedComponent for theme propagation
class ArcaneThemeProvider extends InheritedComponent {
  final ArcaneTheme theme;

  const ArcaneThemeProvider({
    required this.theme,
    required super.child,
    super.key,
  });

  static ArcaneThemeProvider? of(BuildContext context) {
    return context.dependOnInheritedComponentOfExactType<ArcaneThemeProvider>();
  }

  @override
  bool updateShouldNotify(ArcaneThemeProvider oldComponent) {
    return theme != oldComponent.theme;
  }
}

/// Extension to easily access theme from context
extension ArcaneThemeContext on BuildContext {
  ArcaneTheme get arcaneTheme => ArcaneTheme.of(this);
  bool get isDarkMode => arcaneTheme.isDark;
  bool get isLightMode => arcaneTheme.isLight;

  /// Get the current stylesheet from context
  ArcaneStyleSheet get styleSheet => arcaneTheme.styleSheet;

  /// Check if using Codex stylesheet
  bool get isCodexStyle => styleSheet is CodexStyleSheet;

  /// Check if using ShadCN stylesheet
  bool get isShadcnStyle => styleSheet is ShadcnStyleSheet;
}
