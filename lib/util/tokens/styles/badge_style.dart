import '../tokens.dart';

// =============================================================================
// BADGE STYLE PRESETS
// =============================================================================

/// Badge styling presets
/// Use like: ArcaneBadge(style: BadgeStyle.success)
class BadgeStyle {
  final Map<String, String> styles;

  const BadgeStyle._(this.styles);

  /// Create a custom badge style
  const BadgeStyle.custom(this.styles);

  /// Merge with additional styles
  Map<String, String> withOverrides(Map<String, String> overrides) {
    return {...styles, ...overrides};
  }

  /// Default badge (neutral)
  static const BadgeStyle standard = BadgeStyle._({
    'background-color': ArcaneColors.surfaceVariant,
    'color': ArcaneColors.onSurface,
  });

  /// Primary badge (accent colored)
  static const BadgeStyle primary = BadgeStyle._({
    'background-color': ArcaneColors.accentContainer,
    'color': ArcaneColors.accent,
  });

  /// Secondary badge
  static const BadgeStyle secondary = BadgeStyle._({
    'background-color': ArcaneColors.secondaryContainer,
    'color': ArcaneColors.onSecondaryContainer,
  });

  /// Success badge (green)
  static const BadgeStyle success = BadgeStyle._({
    'background-color': ArcaneColors.success,
    'color': ArcaneColors.successForeground,
  });

  /// Warning badge (amber)
  static const BadgeStyle warning = BadgeStyle._({
    'background-color': ArcaneColors.warning,
    'color': ArcaneColors.warningForeground,
  });

  /// Error/destructive badge (red)
  static const BadgeStyle error = BadgeStyle._({
    'background-color': ArcaneColors.error,
    'color': ArcaneColors.errorForeground,
  });

  /// Alias for error
  static const BadgeStyle destructive = error;

  /// Info badge (blue)
  static const BadgeStyle info = BadgeStyle._({
    'background-color': ArcaneColors.info,
    'color': ArcaneColors.infoForeground,
  });

  /// Outline badge
  static const BadgeStyle outline = BadgeStyle._({
    'background-color': ArcaneColors.transparent,
    'color': ArcaneColors.onSurface,
    'border': '1px solid ${ArcaneColors.border}',
  });

  // =========================================================================
  // Rainbow Color Variants (with backdrop blur, minimal corners)
  // =========================================================================

  /// Gray/Neutral badge
  static const BadgeStyle gray = BadgeStyle._({
    'background-color': ArcaneColors.grayAlpha35,
    'color': ArcaneColors.gray,
    'border': '1px solid ${ArcaneColors.grayAlpha50}',
    'border-radius': ArcaneRadius.xs,
    'backdrop-filter': ArcaneEffects.backdropBlurLight,
    '-webkit-backdrop-filter': ArcaneEffects.backdropBlurLight,
    'text-shadow': ArcaneEffects.textShadowContrast,
    'font-size': '0.85rem',
  });

  /// Red badge
  static const BadgeStyle red = BadgeStyle._({
    'background-color': ArcaneColors.redAlpha35,
    'color': ArcaneColors.red,
    'border': '1px solid ${ArcaneColors.redAlpha50}',
    'border-radius': ArcaneRadius.xs,
    'backdrop-filter': ArcaneEffects.backdropBlurLight,
    '-webkit-backdrop-filter': ArcaneEffects.backdropBlurLight,
    'text-shadow': ArcaneEffects.textShadowContrast,
    'font-size': '0.85rem',
  });

  /// Orange badge
  static const BadgeStyle orange = BadgeStyle._({
    'background-color': ArcaneColors.orangeAlpha35,
    'color': ArcaneColors.orange,
    'border': '1px solid ${ArcaneColors.orangeAlpha50}',
    'border-radius': ArcaneRadius.xs,
    'backdrop-filter': ArcaneEffects.backdropBlurLight,
    '-webkit-backdrop-filter': ArcaneEffects.backdropBlurLight,
    'text-shadow': ArcaneEffects.textShadowContrast,
    'font-size': '0.85rem',
  });

  /// Amber/Yellow badge
  static const BadgeStyle yellow = BadgeStyle._({
    'background-color': ArcaneColors.yellowAlpha35,
    'color': ArcaneColors.yellow,
    'border': '1px solid ${ArcaneColors.yellowAlpha50}',
    'border-radius': ArcaneRadius.xs,
    'backdrop-filter': ArcaneEffects.backdropBlurLight,
    '-webkit-backdrop-filter': ArcaneEffects.backdropBlurLight,
    'text-shadow': ArcaneEffects.textShadowContrast,
    'font-size': '0.85rem',
  });

  /// Green badge
  static const BadgeStyle green = BadgeStyle._({
    'background-color': ArcaneColors.greenAlpha35,
    'color': ArcaneColors.green,
    'border': '1px solid ${ArcaneColors.greenAlpha50}',
    'border-radius': ArcaneRadius.xs,
    'backdrop-filter': ArcaneEffects.backdropBlurLight,
    '-webkit-backdrop-filter': ArcaneEffects.backdropBlurLight,
    'text-shadow': ArcaneEffects.textShadowContrast,
    'font-size': '0.85rem',
  });

  /// Teal badge
  static const BadgeStyle teal = BadgeStyle._({
    'background-color': ArcaneColors.tealAlpha35,
    'color': ArcaneColors.teal,
    'border': '1px solid ${ArcaneColors.tealAlpha50}',
    'border-radius': ArcaneRadius.xs,
    'backdrop-filter': ArcaneEffects.backdropBlurLight,
    '-webkit-backdrop-filter': ArcaneEffects.backdropBlurLight,
    'text-shadow': ArcaneEffects.textShadowContrast,
    'font-size': '0.85rem',
  });

  /// Cyan badge
  static const BadgeStyle cyan = BadgeStyle._({
    'background-color': ArcaneColors.cyanAlpha35,
    'color': ArcaneColors.cyan,
    'border': '1px solid ${ArcaneColors.cyanAlpha50}',
    'border-radius': ArcaneRadius.xs,
    'backdrop-filter': ArcaneEffects.backdropBlurLight,
    '-webkit-backdrop-filter': ArcaneEffects.backdropBlurLight,
    'text-shadow': ArcaneEffects.textShadowContrast,
    'font-size': '0.85rem',
  });

  /// Blue badge
  static const BadgeStyle blue = BadgeStyle._({
    'background-color': ArcaneColors.blueAlpha35,
    'color': ArcaneColors.blue,
    'border': '1px solid ${ArcaneColors.blueAlpha50}',
    'border-radius': ArcaneRadius.xs,
    'backdrop-filter': ArcaneEffects.backdropBlurLight,
    '-webkit-backdrop-filter': ArcaneEffects.backdropBlurLight,
    'text-shadow': ArcaneEffects.textShadowContrast,
    'font-size': '0.85rem',
  });

  /// Indigo badge
  static const BadgeStyle indigo = BadgeStyle._({
    'background-color': ArcaneColors.indigoAlpha35,
    'color': ArcaneColors.indigo,
    'border': '1px solid ${ArcaneColors.indigoAlpha50}',
    'border-radius': ArcaneRadius.xs,
    'backdrop-filter': ArcaneEffects.backdropBlurLight,
    '-webkit-backdrop-filter': ArcaneEffects.backdropBlurLight,
    'text-shadow': ArcaneEffects.textShadowContrast,
    'font-size': '0.85rem',
  });

  /// Purple/Violet badge
  static const BadgeStyle purple = BadgeStyle._({
    'background-color': ArcaneColors.purpleAlpha35,
    'color': ArcaneColors.purple,
    'border': '1px solid ${ArcaneColors.purpleAlpha50}',
    'border-radius': ArcaneRadius.xs,
    'backdrop-filter': ArcaneEffects.backdropBlurLight,
    '-webkit-backdrop-filter': ArcaneEffects.backdropBlurLight,
    'text-shadow': ArcaneEffects.textShadowContrast,
    'font-size': '0.85rem',
  });

  /// Pink badge
  static const BadgeStyle pink = BadgeStyle._({
    'background-color': ArcaneColors.pinkAlpha35,
    'color': ArcaneColors.pink,
    'border': '1px solid ${ArcaneColors.pinkAlpha50}',
    'border-radius': ArcaneRadius.xs,
    'backdrop-filter': ArcaneEffects.backdropBlurLight,
    '-webkit-backdrop-filter': ArcaneEffects.backdropBlurLight,
    'text-shadow': ArcaneEffects.textShadowContrast,
    'font-size': '0.85rem',
  });

  /// Rose badge
  static const BadgeStyle rose = BadgeStyle._({
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
