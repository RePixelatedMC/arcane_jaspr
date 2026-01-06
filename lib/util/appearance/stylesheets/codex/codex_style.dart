import '../../colors.dart';
import '../../style_sheet.dart';

/// Codex design language - premium gaming aesthetic with custom fonts.
///
/// Uses custom fonts (Akzidenz-GroteskPro, ITCAvantGardeStd) loaded via @font-face.
/// Features glass effects, rich shadows, and dramatic visual style.
///
/// Characteristics:
/// - Sharp corners (smaller radius than ShadCN) - premium/technical look
/// - Rich shadows for depth (0.15-0.25 opacity)
/// - Glass/frosted effects on surfaces
/// - Custom premium fonts
/// - Emerald accent color
/// - Smooth, moderate animations
/// - Rounded-square toggle thumbs (NOT circles)
/// - Subtle gradients on interactive elements
class CodexStyleSheet extends ArcaneStyleSheet {
  const CodexStyleSheet();

  // ===========================================================================
  // IDENTITY
  // ===========================================================================

  @override
  String get id => 'codex';

  @override
  String get name => 'Codex';

  // ===========================================================================
  // COMPONENT STRUCTURE TOKENS
  // ===========================================================================

  @override
  InteractiveTokens get interactiveTokens => const InteractiveTokens(
        shape: ComponentShape.sharp,
        hoverShadow: ShadowIntensity.elevated,
        borderWeight: BorderWeight.standard,
        useGradients: true,
        hoverAnimation: AnimationPreset.lift,
        focusRingWidth: '2px',
        focusRingOffset: '2px',
      );

  @override
  ContainerTokens get containerTokens => const ContainerTokens(
        shape: ComponentShape.sharp,
        shadow: ShadowIntensity.elevated,
        borderWeight: BorderWeight.standard,
        useBackdropBlur: true,
        backdropBlur: '12px',
        surfaceOpacity: 0.85,
      );

  @override
  InputTokens get inputTokens => const InputTokens(
        shape: ComponentShape.sharp,
        borderWeight: BorderWeight.standard,
        focusShadow: ShadowIntensity.standard,
        filledByDefault: false,
      );

  @override
  IndicatorTokens get indicatorTokens => const IndicatorTokens(
        // Checkbox: Sharp/squared
        checkboxShape: ComponentShape.sharp,
        checkboxBorder: BorderWeight.medium,
        // Radio: Slightly rounded (not fully circular for uniqueness)
        radioShape: ComponentShape.rounded,
        radioBorder: BorderWeight.medium,
        // Toggle: Rounded track and thumb (NOT pill/circle - distinct from ShadCN)
        toggleTrackShape: ComponentShape.rounded,
        toggleThumbShape: ComponentShape.rounded,
        thumbShadow: true,
        // Toggle colors: Light thumb on dark track when ON
        thumbOnColor: 'var(--arcane-foreground)',
        thumbOffColor: 'var(--arcane-muted-foreground)',
        trackOnColor: 'var(--arcane-accent)',
        trackOffColor: 'var(--arcane-muted)',
        // Subtle gradient fill when checked
        useGradientFill: true,
        checkAnimation: AnimationPreset.scale,
      );

  // ===========================================================================
  // COLORS - Light Mode (Gaming aesthetic with emerald accent)
  // ===========================================================================

  @override
  Color get backgroundLight => Colors.zinc50;

  @override
  Color get foregroundLight => Colors.zinc900;

  @override
  Color get cardLight => Colors.white;

  @override
  Color get cardForegroundLight => Colors.zinc900;

  @override
  Color get popoverLight => Colors.white;

  @override
  Color get popoverForegroundLight => Colors.zinc900;

  // Primary is emerald (the brand color)
  @override
  Color get primaryLight => Colors.emerald600;

  @override
  Color get primaryForegroundLight => Colors.white;

  @override
  Color get secondaryLight => Colors.zinc100;

  @override
  Color get secondaryForegroundLight => Colors.zinc900;

  @override
  Color get mutedLight => Colors.zinc100;

  @override
  Color get mutedForegroundLight => Colors.zinc500;

  @override
  Color get accentLight => Colors.emerald100;

  @override
  Color get accentForegroundLight => Colors.emerald900;

  @override
  Color get destructiveLight => Colors.red600;

  @override
  Color get destructiveForegroundLight => Colors.white;

  @override
  Color get borderLight => Colors.zinc200;

  @override
  Color get inputLight => Colors.zinc200;

  @override
  Color get ringLight => Colors.emerald600;

  // ===========================================================================
  // COLORS - Dark Mode (Rich, gaming-inspired dark theme)
  // ===========================================================================

  @override
  Color get backgroundDark => Colors.zinc950;

  @override
  Color get foregroundDark => Colors.zinc50;

  @override
  Color get cardDark => Colors.zinc900;

  @override
  Color get cardForegroundDark => Colors.zinc50;

  @override
  Color get popoverDark => Colors.zinc900;

  @override
  Color get popoverForegroundDark => Colors.zinc50;

  // Primary is emerald (the brand color)
  @override
  Color get primaryDark => Colors.emerald500;

  @override
  Color get primaryForegroundDark => Colors.zinc950;

  @override
  Color get secondaryDark => Colors.zinc800;

  @override
  Color get secondaryForegroundDark => Colors.zinc50;

  @override
  Color get mutedDark => Colors.zinc800;

  @override
  Color get mutedForegroundDark => Colors.zinc400;

  @override
  Color get accentDark => Colors.emerald900;

  @override
  Color get accentForegroundDark => Colors.emerald100;

  @override
  Color get destructiveDark => Colors.red500;

  @override
  Color get destructiveForegroundDark => Colors.zinc50;

  @override
  Color get borderDark => Colors.zinc800;

  @override
  Color get inputDark => Colors.zinc800;

  @override
  Color get ringDark => Colors.emerald500;

  // ===========================================================================
  // CHART COLORS (Gaming-inspired vibrant palette)
  // ===========================================================================

  @override
  List<Color> get chartColorsLight => const [
        Color(0xFF10B981), // Emerald
        Color(0xFF3B82F6), // Blue
        Color(0xFFF59E0B), // Amber
        Color(0xFF8B5CF6), // Violet
        Color(0xFFEC4899), // Pink
      ];

  @override
  List<Color> get chartColorsDark => const [
        Color(0xFF34D399), // Emerald 400
        Color(0xFF60A5FA), // Blue 400
        Color(0xFFFBBF24), // Amber 400
        Color(0xFFA78BFA), // Violet 400
        Color(0xFFF472B6), // Pink 400
      ];

  // ===========================================================================
  // TYPOGRAPHY - Custom fonts via @font-face
  // ===========================================================================

  @override
  String get fontSans =>
      "'Akzidenz-GroteskPro', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, 'Helvetica Neue', Arial, sans-serif";

  @override
  String get fontHeading =>
      "'ITCAvantGardeStd', 'Akzidenz-GroteskPro', -apple-system, BlinkMacSystemFont, sans-serif";

  @override
  String get fontMono =>
      "'Hack', 'Fira Code', 'SF Mono', Consolas, 'Liberation Mono', monospace";

  @override
  String get letterSpacing => '-0.01em';

  @override
  String? get googleFontUrl => null; // Using local fonts only

  @override
  String? get fontFaceCss => '''
/* Hack - Code/Monospace */
@font-face {
  font-family: 'Hack';
  src: url('/fonts/HackFont/Hack-Regular.ttf') format('truetype');
  font-weight: 400;
  font-style: normal;
  font-display: swap;
}

@font-face {
  font-family: 'Hack';
  src: url('/fonts/HackFont/Hack-Bold.ttf') format('truetype');
  font-weight: 700;
  font-style: normal;
  font-display: swap;
}

@font-face {
  font-family: 'Hack';
  src: url('/fonts/HackFont/Hack-Italic.ttf') format('truetype');
  font-weight: 400;
  font-style: italic;
  font-display: swap;
}

@font-face {
  font-family: 'Hack';
  src: url('/fonts/HackFont/Hack-BoldItalic.ttf') format('truetype');
  font-weight: 700;
  font-style: italic;
  font-display: swap;
}

/* Akzidenz-GroteskPro - Body Text */
@font-face {
  font-family: 'Akzidenz-GroteskPro';
  src: url('/fonts/Akzidenz-GroteskPro/akzidenzgroteskpro_light.woff2') format('woff2'),
       url('/fonts/Akzidenz-GroteskPro/akzidenzgroteskpro_light.woff') format('woff');
  font-weight: 300;
  font-style: normal;
  font-display: swap;
}

@font-face {
  font-family: 'Akzidenz-GroteskPro';
  src: url('/fonts/Akzidenz-GroteskPro/akzidenzgroteskpro_regular.woff2') format('woff2'),
       url('/fonts/Akzidenz-GroteskPro/akzidenzgroteskpro_regular.woff') format('woff');
  font-weight: 400;
  font-style: normal;
  font-display: swap;
}

@font-face {
  font-family: 'Akzidenz-GroteskPro';
  src: url('/fonts/Akzidenz-GroteskPro/akzidenzgroteskpro_md.woff2') format('woff2'),
       url('/fonts/Akzidenz-GroteskPro/akzidenzgroteskpro_md.woff') format('woff');
  font-weight: 500;
  font-style: normal;
  font-display: swap;
}

@font-face {
  font-family: 'Akzidenz-GroteskPro';
  src: url('/fonts/Akzidenz-GroteskPro/akzidenzgroteskpro_bold.woff2') format('woff2'),
       url('/fonts/Akzidenz-GroteskPro/akzidenzgroteskpro_bold.ttf') format('truetype');
  font-weight: 700;
  font-style: normal;
  font-display: swap;
}

/* ITCAvantGardeStd - Headings */
@font-face {
  font-family: 'ITCAvantGardeStd';
  src: url('/fonts/ITCAvantGardeStd/ITCAvantGardeStd-Bk.woff2') format('woff2'),
       url('/fonts/ITCAvantGardeStd/ITCAvantGardeStd-Bk.woff') format('woff');
  font-weight: 400;
  font-style: normal;
  font-display: swap;
}

@font-face {
  font-family: 'ITCAvantGardeStd';
  src: url('/fonts/ITCAvantGardeStd/ITCAvantGardeStd-Md.woff2') format('woff2'),
       url('/fonts/ITCAvantGardeStd/ITCAvantGardeStd-Md.woff') format('woff');
  font-weight: 500;
  font-style: normal;
  font-display: swap;
}

@font-face {
  font-family: 'ITCAvantGardeStd';
  src: url('/fonts/ITCAvantGardeStd/ITCAvantGardeStd-Demi.woff2') format('woff2'),
       url('/fonts/ITCAvantGardeStd/ITCAvantGardeStd-Demi.woff') format('woff');
  font-weight: 600;
  font-style: normal;
  font-display: swap;
}

@font-face {
  font-family: 'ITCAvantGardeStd';
  src: url('/fonts/ITCAvantGardeStd/ITCAvantGardeStd-Bold.woff2') format('woff2'),
       url('/fonts/ITCAvantGardeStd/ITCAvantGardeStd-Bold.woff') format('woff');
  font-weight: 700;
  font-style: normal;
  font-display: swap;
}
''';

  // ===========================================================================
  // RADIUS - Sharper, more technical look
  // ===========================================================================

  @override
  double get radiusScale => 0.5;

  @override
  String get radius => '6px';

  @override
  String get radiusXs => '2px';

  @override
  String get radiusSm => '3px';

  @override
  String get radiusMd => '4px';

  @override
  String get radiusLg => '6px';

  @override
  String get radiusXl => '8px';

  @override
  String get radius2xl => '10px';

  // ===========================================================================
  // SHADOWS - Rich, dramatic shadows
  // ===========================================================================

  @override
  bool get useShadows => true;

  @override
  double get shadowIntensity => 1.0;

  @override
  String get shadowXs => '0 1px 2px rgba(0, 0, 0, 0.08)';

  @override
  String get shadowSm =>
      '0 2px 4px rgba(0, 0, 0, 0.12), 0 1px 2px rgba(0, 0, 0, 0.08)';

  @override
  String get shadowMd =>
      '0 4px 8px -1px rgba(0, 0, 0, 0.15), 0 2px 4px -1px rgba(0, 0, 0, 0.10)';

  @override
  String get shadowLg =>
      '0 10px 20px -3px rgba(0, 0, 0, 0.20), 0 4px 8px -2px rgba(0, 0, 0, 0.12)';

  @override
  String get shadowXl =>
      '0 20px 30px -5px rgba(0, 0, 0, 0.25), 0 10px 15px -5px rgba(0, 0, 0, 0.15)';

  // ===========================================================================
  // BORDERS
  // ===========================================================================

  @override
  String get borderWidth => '1px';

  @override
  bool get borderFocused => false;

  // ===========================================================================
  // TRANSITIONS - Smooth, moderate animations
  // ===========================================================================

  @override
  int get transitionFast => 150;

  @override
  int get transitionNormal => 200;

  @override
  int get transitionSlow => 300;

  @override
  String get easingDefault => 'ease';

  // ===========================================================================
  // SURFACE EFFECTS - Glass effects enabled
  // ===========================================================================

  @override
  double get surfaceOpacity => 0.8;

  @override
  double get surfaceOpacityLight => 0.9;

  @override
  double get surfaceBlur => 12.0;

  @override
  bool get useGlassEffects => true;

  // ===========================================================================
  // COMPONENT DEFAULTS
  // ===========================================================================

  @override
  String get buttonDefaultVariant => 'primary';

  @override
  String get cardDefaultVariant => 'elevated';

  @override
  String get focusRingStyle => '2px solid var(--arcane-ring)';
}
