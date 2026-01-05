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

  /// Gray/Neutral chip
  static const ChipStyle gray = ChipStyle._({
    'background-color': ArcaneColors.grayAlpha35,
    'color': ArcaneColors.gray,
    'border': '1px solid ${ArcaneColors.grayAlpha50}',
    'border-radius': ArcaneRadius.xs,
    'backdrop-filter': ArcaneEffects.backdropBlurLight,
    '-webkit-backdrop-filter': ArcaneEffects.backdropBlurLight,
    'text-shadow': ArcaneEffects.textShadowContrast,
    'font-size': '0.85rem',
  });

  /// Red chip
  static const ChipStyle red = ChipStyle._({
    'background-color': ArcaneColors.redAlpha35,
    'color': ArcaneColors.red,
    'border': '1px solid ${ArcaneColors.redAlpha50}',
    'border-radius': ArcaneRadius.xs,
    'backdrop-filter': ArcaneEffects.backdropBlurLight,
    '-webkit-backdrop-filter': ArcaneEffects.backdropBlurLight,
    'text-shadow': ArcaneEffects.textShadowContrast,
    'font-size': '0.85rem',
  });

  /// Orange chip
  static const ChipStyle orange = ChipStyle._({
    'background-color': ArcaneColors.orangeAlpha35,
    'color': ArcaneColors.orange,
    'border': '1px solid ${ArcaneColors.orangeAlpha50}',
    'border-radius': ArcaneRadius.xs,
    'backdrop-filter': ArcaneEffects.backdropBlurLight,
    '-webkit-backdrop-filter': ArcaneEffects.backdropBlurLight,
    'text-shadow': ArcaneEffects.textShadowContrast,
    'font-size': '0.85rem',
  });

  /// Amber/Yellow chip
  static const ChipStyle yellow = ChipStyle._({
    'background-color': ArcaneColors.yellowAlpha35,
    'color': ArcaneColors.yellow,
    'border': '1px solid ${ArcaneColors.yellowAlpha50}',
    'border-radius': ArcaneRadius.xs,
    'backdrop-filter': ArcaneEffects.backdropBlurLight,
    '-webkit-backdrop-filter': ArcaneEffects.backdropBlurLight,
    'text-shadow': ArcaneEffects.textShadowContrast,
    'font-size': '0.85rem',
  });

  /// Green chip
  static const ChipStyle green = ChipStyle._({
    'background-color': ArcaneColors.greenAlpha35,
    'color': ArcaneColors.green,
    'border': '1px solid ${ArcaneColors.greenAlpha50}',
    'border-radius': ArcaneRadius.xs,
    'backdrop-filter': ArcaneEffects.backdropBlurLight,
    '-webkit-backdrop-filter': ArcaneEffects.backdropBlurLight,
    'text-shadow': ArcaneEffects.textShadowContrast,
    'font-size': '0.85rem',
  });

  /// Teal chip
  static const ChipStyle teal = ChipStyle._({
    'background-color': ArcaneColors.tealAlpha35,
    'color': ArcaneColors.teal,
    'border': '1px solid ${ArcaneColors.tealAlpha50}',
    'border-radius': ArcaneRadius.xs,
    'backdrop-filter': ArcaneEffects.backdropBlurLight,
    '-webkit-backdrop-filter': ArcaneEffects.backdropBlurLight,
    'text-shadow': ArcaneEffects.textShadowContrast,
    'font-size': '0.85rem',
  });

  /// Cyan chip
  static const ChipStyle cyan = ChipStyle._({
    'background-color': ArcaneColors.cyanAlpha35,
    'color': ArcaneColors.cyan,
    'border': '1px solid ${ArcaneColors.cyanAlpha50}',
    'border-radius': ArcaneRadius.xs,
    'backdrop-filter': ArcaneEffects.backdropBlurLight,
    '-webkit-backdrop-filter': ArcaneEffects.backdropBlurLight,
    'text-shadow': ArcaneEffects.textShadowContrast,
    'font-size': '0.85rem',
  });

  /// Blue chip
  static const ChipStyle blue = ChipStyle._({
    'background-color': ArcaneColors.blueAlpha35,
    'color': ArcaneColors.blue,
    'border': '1px solid ${ArcaneColors.blueAlpha50}',
    'border-radius': ArcaneRadius.xs,
    'backdrop-filter': ArcaneEffects.backdropBlurLight,
    '-webkit-backdrop-filter': ArcaneEffects.backdropBlurLight,
    'text-shadow': ArcaneEffects.textShadowContrast,
    'font-size': '0.85rem',
  });

  /// Indigo chip
  static const ChipStyle indigo = ChipStyle._({
    'background-color': ArcaneColors.indigoAlpha35,
    'color': ArcaneColors.indigo,
    'border': '1px solid ${ArcaneColors.indigoAlpha50}',
    'border-radius': ArcaneRadius.xs,
    'backdrop-filter': ArcaneEffects.backdropBlurLight,
    '-webkit-backdrop-filter': ArcaneEffects.backdropBlurLight,
    'text-shadow': ArcaneEffects.textShadowContrast,
    'font-size': '0.85rem',
  });

  /// Purple/Violet chip
  static const ChipStyle purple = ChipStyle._({
    'background-color': ArcaneColors.purpleAlpha35,
    'color': ArcaneColors.purple,
    'border': '1px solid ${ArcaneColors.purpleAlpha50}',
    'border-radius': ArcaneRadius.xs,
    'backdrop-filter': ArcaneEffects.backdropBlurLight,
    '-webkit-backdrop-filter': ArcaneEffects.backdropBlurLight,
    'text-shadow': ArcaneEffects.textShadowContrast,
    'font-size': '0.85rem',
  });

  /// Pink chip
  static const ChipStyle pink = ChipStyle._({
    'background-color': ArcaneColors.pinkAlpha35,
    'color': ArcaneColors.pink,
    'border': '1px solid ${ArcaneColors.pinkAlpha50}',
    'border-radius': ArcaneRadius.xs,
    'backdrop-filter': ArcaneEffects.backdropBlurLight,
    '-webkit-backdrop-filter': ArcaneEffects.backdropBlurLight,
    'text-shadow': ArcaneEffects.textShadowContrast,
    'font-size': '0.85rem',
  });

  /// Rose chip
  static const ChipStyle rose = ChipStyle._({
    'background-color': ArcaneColors.roseAlpha35,
    'color': ArcaneColors.rose,
    'border': '1px solid ${ArcaneColors.roseAlpha50}',
    'border-radius': ArcaneRadius.xs,
    'backdrop-filter': ArcaneEffects.backdropBlurLight,
    '-webkit-backdrop-filter': ArcaneEffects.backdropBlurLight,
    'text-shadow': ArcaneEffects.textShadowContrast,
    'font-size': '0.85rem',
  });
}
