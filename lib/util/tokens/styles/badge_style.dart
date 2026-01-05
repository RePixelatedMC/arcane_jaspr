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
  // Rainbow Color Variants
  // =========================================================================

  /// Red badge
  static const BadgeStyle red = BadgeStyle._({
    'background-color': 'rgba(239, 68, 68, 0.15)',
    'color': '#EF4444',
    'border': '1px solid rgba(239, 68, 68, 0.3)',
  });

  /// Orange badge
  static const BadgeStyle orange = BadgeStyle._({
    'background-color': 'rgba(249, 115, 22, 0.15)',
    'color': '#F97316',
    'border': '1px solid rgba(249, 115, 22, 0.3)',
  });

  /// Amber/Yellow badge
  static const BadgeStyle yellow = BadgeStyle._({
    'background-color': 'rgba(234, 179, 8, 0.15)',
    'color': '#EAB308',
    'border': '1px solid rgba(234, 179, 8, 0.3)',
  });

  /// Green badge
  static const BadgeStyle green = BadgeStyle._({
    'background-color': 'rgba(34, 197, 94, 0.15)',
    'color': '#22C55E',
    'border': '1px solid rgba(34, 197, 94, 0.3)',
  });

  /// Teal badge
  static const BadgeStyle teal = BadgeStyle._({
    'background-color': 'rgba(20, 184, 166, 0.15)',
    'color': '#14B8A6',
    'border': '1px solid rgba(20, 184, 166, 0.3)',
  });

  /// Cyan badge
  static const BadgeStyle cyan = BadgeStyle._({
    'background-color': 'rgba(6, 182, 212, 0.15)',
    'color': '#06B6D4',
    'border': '1px solid rgba(6, 182, 212, 0.3)',
  });

  /// Blue badge
  static const BadgeStyle blue = BadgeStyle._({
    'background-color': 'rgba(59, 130, 246, 0.15)',
    'color': '#3B82F6',
    'border': '1px solid rgba(59, 130, 246, 0.3)',
  });

  /// Indigo badge
  static const BadgeStyle indigo = BadgeStyle._({
    'background-color': 'rgba(99, 102, 241, 0.15)',
    'color': '#6366F1',
    'border': '1px solid rgba(99, 102, 241, 0.3)',
  });

  /// Purple/Violet badge
  static const BadgeStyle purple = BadgeStyle._({
    'background-color': 'rgba(139, 92, 246, 0.15)',
    'color': '#8B5CF6',
    'border': '1px solid rgba(139, 92, 246, 0.3)',
  });

  /// Pink badge
  static const BadgeStyle pink = BadgeStyle._({
    'background-color': 'rgba(236, 72, 153, 0.15)',
    'color': '#EC4899',
    'border': '1px solid rgba(236, 72, 153, 0.3)',
  });

  /// Rose badge
  static const BadgeStyle rose = BadgeStyle._({
    'background-color': 'rgba(244, 63, 94, 0.15)',
    'color': '#F43F5E',
    'border': '1px solid rgba(244, 63, 94, 0.3)',
  });
}
