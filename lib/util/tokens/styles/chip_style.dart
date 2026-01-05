import '../tokens.dart';

// =============================================================================
// CHIP STYLE PRESETS
// =============================================================================

/// Chip styling presets
/// Use like: ArcaneChip(style: ChipStyle.primary)
class ChipStyle {
  final Map<String, String> styles;

  const ChipStyle._(this.styles);

  /// Create a custom chip style
  const ChipStyle.custom(this.styles);

  /// Default chip
  static const ChipStyle standard = ChipStyle._({
    'background-color': ArcaneColors.surfaceVariant,
    'color': ArcaneColors.onSurface,
    'border': 'none',
  });

  /// Primary chip
  static const ChipStyle primary = ChipStyle._({
    'background-color': ArcaneColors.accentContainer,
    'color': ArcaneColors.accent,
    'border': 'none',
  });

  /// Outlined chip
  static const ChipStyle outline = ChipStyle._({
    'background-color': ArcaneColors.transparent,
    'color': ArcaneColors.onSurface,
    'border': '1px solid ${ArcaneColors.border}',
  });

  /// Success chip
  static const ChipStyle success = ChipStyle._({
    'background-color': ArcaneColors.successAlpha15,
    'color': ArcaneColors.success,
    'border': 'none',
  });

  /// Warning chip
  static const ChipStyle warning = ChipStyle._({
    'background-color': ArcaneColors.warningAlpha15,
    'color': ArcaneColors.warning,
    'border': 'none',
  });

  /// Error chip
  static const ChipStyle error = ChipStyle._({
    'background-color': ArcaneColors.errorAlpha15,
    'color': ArcaneColors.error,
    'border': 'none',
  });

  // =========================================================================
  // Rainbow Color Variants (with backdrop blur, minimal corners)
  // =========================================================================

  /// Red chip
  static const ChipStyle red = ChipStyle._({
    'background-color': ArcaneColors.redAlpha20,
    'color': ArcaneColors.red,
    'border': '1px solid ${ArcaneColors.redAlpha40}',
    'border-radius': ArcaneRadius.xs,
    'backdrop-filter': ArcaneEffects.backdropBlurLight,
    '-webkit-backdrop-filter': ArcaneEffects.backdropBlurLight,
    'text-shadow': ArcaneEffects.textShadowContrast,
    'font-size': '0.85rem',
  });

  /// Orange chip
  static const ChipStyle orange = ChipStyle._({
    'background-color': ArcaneColors.orangeAlpha20,
    'color': ArcaneColors.orange,
    'border': '1px solid ${ArcaneColors.orangeAlpha40}',
    'border-radius': ArcaneRadius.xs,
    'backdrop-filter': ArcaneEffects.backdropBlurLight,
    '-webkit-backdrop-filter': ArcaneEffects.backdropBlurLight,
    'text-shadow': ArcaneEffects.textShadowContrast,
    'font-size': '0.85rem',
  });

  /// Amber/Yellow chip
  static const ChipStyle yellow = ChipStyle._({
    'background-color': ArcaneColors.yellowAlpha20,
    'color': ArcaneColors.yellow,
    'border': '1px solid ${ArcaneColors.yellowAlpha40}',
    'border-radius': ArcaneRadius.xs,
    'backdrop-filter': ArcaneEffects.backdropBlurLight,
    '-webkit-backdrop-filter': ArcaneEffects.backdropBlurLight,
    'text-shadow': ArcaneEffects.textShadowContrast,
    'font-size': '0.85rem',
  });

  /// Green chip
  static const ChipStyle green = ChipStyle._({
    'background-color': ArcaneColors.greenAlpha20,
    'color': ArcaneColors.green,
    'border': '1px solid ${ArcaneColors.greenAlpha40}',
    'border-radius': ArcaneRadius.xs,
    'backdrop-filter': ArcaneEffects.backdropBlurLight,
    '-webkit-backdrop-filter': ArcaneEffects.backdropBlurLight,
    'text-shadow': ArcaneEffects.textShadowContrast,
    'font-size': '0.85rem',
  });

  /// Teal chip
  static const ChipStyle teal = ChipStyle._({
    'background-color': ArcaneColors.tealAlpha20,
    'color': ArcaneColors.teal,
    'border': '1px solid ${ArcaneColors.tealAlpha40}',
    'border-radius': ArcaneRadius.xs,
    'backdrop-filter': ArcaneEffects.backdropBlurLight,
    '-webkit-backdrop-filter': ArcaneEffects.backdropBlurLight,
    'text-shadow': ArcaneEffects.textShadowContrast,
    'font-size': '0.85rem',
  });

  /// Cyan chip
  static const ChipStyle cyan = ChipStyle._({
    'background-color': ArcaneColors.cyanAlpha20,
    'color': ArcaneColors.cyan,
    'border': '1px solid ${ArcaneColors.cyanAlpha40}',
    'border-radius': ArcaneRadius.xs,
    'backdrop-filter': ArcaneEffects.backdropBlurLight,
    '-webkit-backdrop-filter': ArcaneEffects.backdropBlurLight,
    'text-shadow': ArcaneEffects.textShadowContrast,
    'font-size': '0.85rem',
  });

  /// Blue chip
  static const ChipStyle blue = ChipStyle._({
    'background-color': ArcaneColors.blueAlpha20,
    'color': ArcaneColors.blue,
    'border': '1px solid ${ArcaneColors.blueAlpha40}',
    'border-radius': ArcaneRadius.xs,
    'backdrop-filter': ArcaneEffects.backdropBlurLight,
    '-webkit-backdrop-filter': ArcaneEffects.backdropBlurLight,
    'text-shadow': ArcaneEffects.textShadowContrast,
    'font-size': '0.85rem',
  });

  /// Indigo chip
  static const ChipStyle indigo = ChipStyle._({
    'background-color': ArcaneColors.indigoAlpha20,
    'color': ArcaneColors.indigo,
    'border': '1px solid ${ArcaneColors.indigoAlpha40}',
    'border-radius': ArcaneRadius.xs,
    'backdrop-filter': ArcaneEffects.backdropBlurLight,
    '-webkit-backdrop-filter': ArcaneEffects.backdropBlurLight,
    'text-shadow': ArcaneEffects.textShadowContrast,
    'font-size': '0.85rem',
  });

  /// Purple/Violet chip
  static const ChipStyle purple = ChipStyle._({
    'background-color': ArcaneColors.purpleAlpha20,
    'color': ArcaneColors.purple,
    'border': '1px solid ${ArcaneColors.purpleAlpha40}',
    'border-radius': ArcaneRadius.xs,
    'backdrop-filter': ArcaneEffects.backdropBlurLight,
    '-webkit-backdrop-filter': ArcaneEffects.backdropBlurLight,
    'text-shadow': ArcaneEffects.textShadowContrast,
    'font-size': '0.85rem',
  });

  /// Pink chip
  static const ChipStyle pink = ChipStyle._({
    'background-color': ArcaneColors.pinkAlpha20,
    'color': ArcaneColors.pink,
    'border': '1px solid ${ArcaneColors.pinkAlpha40}',
    'border-radius': ArcaneRadius.xs,
    'backdrop-filter': ArcaneEffects.backdropBlurLight,
    '-webkit-backdrop-filter': ArcaneEffects.backdropBlurLight,
    'text-shadow': ArcaneEffects.textShadowContrast,
    'font-size': '0.85rem',
  });

  /// Rose chip
  static const ChipStyle rose = ChipStyle._({
    'background-color': ArcaneColors.roseAlpha20,
    'color': ArcaneColors.rose,
    'border': '1px solid ${ArcaneColors.roseAlpha40}',
    'border-radius': ArcaneRadius.xs,
    'backdrop-filter': ArcaneEffects.backdropBlurLight,
    '-webkit-backdrop-filter': ArcaneEffects.backdropBlurLight,
    'text-shadow': ArcaneEffects.textShadowContrast,
    'font-size': '0.85rem',
  });
}
