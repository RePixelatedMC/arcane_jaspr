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

  /// Red badge
  static const BadgeStyle red = BadgeStyle._({
    'background-color': ArcaneColors.redAlpha20,
    'color': ArcaneColors.red,
    'border': '1px solid ${ArcaneColors.redAlpha40}',
    'border-radius': ArcaneRadius.xs,
    'backdrop-filter': ArcaneEffects.backdropBlurLight,
    '-webkit-backdrop-filter': ArcaneEffects.backdropBlurLight,
    'text-shadow': ArcaneEffects.textShadowContrast,
    'font-size': '0.85rem',
  });

  /// Orange badge
  static const BadgeStyle orange = BadgeStyle._({
    'background-color': ArcaneColors.orangeAlpha20,
    'color': ArcaneColors.orange,
    'border': '1px solid ${ArcaneColors.orangeAlpha40}',
    'border-radius': ArcaneRadius.xs,
    'backdrop-filter': ArcaneEffects.backdropBlurLight,
    '-webkit-backdrop-filter': ArcaneEffects.backdropBlurLight,
    'text-shadow': ArcaneEffects.textShadowContrast,
    'font-size': '0.85rem',
  });

  /// Amber/Yellow badge
  static const BadgeStyle yellow = BadgeStyle._({
    'background-color': ArcaneColors.yellowAlpha20,
    'color': ArcaneColors.yellow,
    'border': '1px solid ${ArcaneColors.yellowAlpha40}',
    'border-radius': ArcaneRadius.xs,
    'backdrop-filter': ArcaneEffects.backdropBlurLight,
    '-webkit-backdrop-filter': ArcaneEffects.backdropBlurLight,
    'text-shadow': ArcaneEffects.textShadowContrast,
    'font-size': '0.85rem',
  });

  /// Green badge
  static const BadgeStyle green = BadgeStyle._({
    'background-color': ArcaneColors.greenAlpha20,
    'color': ArcaneColors.green,
    'border': '1px solid ${ArcaneColors.greenAlpha40}',
    'border-radius': ArcaneRadius.xs,
    'backdrop-filter': ArcaneEffects.backdropBlurLight,
    '-webkit-backdrop-filter': ArcaneEffects.backdropBlurLight,
    'text-shadow': ArcaneEffects.textShadowContrast,
    'font-size': '0.85rem',
  });

  /// Teal badge
  static const BadgeStyle teal = BadgeStyle._({
    'background-color': ArcaneColors.tealAlpha20,
    'color': ArcaneColors.teal,
    'border': '1px solid ${ArcaneColors.tealAlpha40}',
    'border-radius': ArcaneRadius.xs,
    'backdrop-filter': ArcaneEffects.backdropBlurLight,
    '-webkit-backdrop-filter': ArcaneEffects.backdropBlurLight,
    'text-shadow': ArcaneEffects.textShadowContrast,
    'font-size': '0.85rem',
  });

  /// Cyan badge
  static const BadgeStyle cyan = BadgeStyle._({
    'background-color': ArcaneColors.cyanAlpha20,
    'color': ArcaneColors.cyan,
    'border': '1px solid ${ArcaneColors.cyanAlpha40}',
    'border-radius': ArcaneRadius.xs,
    'backdrop-filter': ArcaneEffects.backdropBlurLight,
    '-webkit-backdrop-filter': ArcaneEffects.backdropBlurLight,
    'text-shadow': ArcaneEffects.textShadowContrast,
    'font-size': '0.85rem',
  });

  /// Blue badge
  static const BadgeStyle blue = BadgeStyle._({
    'background-color': ArcaneColors.blueAlpha20,
    'color': ArcaneColors.blue,
    'border': '1px solid ${ArcaneColors.blueAlpha40}',
    'border-radius': ArcaneRadius.xs,
    'backdrop-filter': ArcaneEffects.backdropBlurLight,
    '-webkit-backdrop-filter': ArcaneEffects.backdropBlurLight,
    'text-shadow': ArcaneEffects.textShadowContrast,
    'font-size': '0.85rem',
  });

  /// Indigo badge
  static const BadgeStyle indigo = BadgeStyle._({
    'background-color': ArcaneColors.indigoAlpha20,
    'color': ArcaneColors.indigo,
    'border': '1px solid ${ArcaneColors.indigoAlpha40}',
    'border-radius': ArcaneRadius.xs,
    'backdrop-filter': ArcaneEffects.backdropBlurLight,
    '-webkit-backdrop-filter': ArcaneEffects.backdropBlurLight,
    'text-shadow': ArcaneEffects.textShadowContrast,
    'font-size': '0.85rem',
  });

  /// Purple/Violet badge
  static const BadgeStyle purple = BadgeStyle._({
    'background-color': ArcaneColors.purpleAlpha20,
    'color': ArcaneColors.purple,
    'border': '1px solid ${ArcaneColors.purpleAlpha40}',
    'border-radius': ArcaneRadius.xs,
    'backdrop-filter': ArcaneEffects.backdropBlurLight,
    '-webkit-backdrop-filter': ArcaneEffects.backdropBlurLight,
    'text-shadow': ArcaneEffects.textShadowContrast,
    'font-size': '0.85rem',
  });

  /// Pink badge
  static const BadgeStyle pink = BadgeStyle._({
    'background-color': ArcaneColors.pinkAlpha20,
    'color': ArcaneColors.pink,
    'border': '1px solid ${ArcaneColors.pinkAlpha40}',
    'border-radius': ArcaneRadius.xs,
    'backdrop-filter': ArcaneEffects.backdropBlurLight,
    '-webkit-backdrop-filter': ArcaneEffects.backdropBlurLight,
    'text-shadow': ArcaneEffects.textShadowContrast,
    'font-size': '0.85rem',
  });

  /// Rose badge
  static const BadgeStyle rose = BadgeStyle._({
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
