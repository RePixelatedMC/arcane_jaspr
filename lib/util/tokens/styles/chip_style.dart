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
  // Rainbow Color Variants
  // =========================================================================

  /// Red chip
  static const ChipStyle red = ChipStyle._({
    'background-color': 'rgba(239, 68, 68, 0.15)',
    'color': '#EF4444',
    'border': 'none',
  });

  /// Orange chip
  static const ChipStyle orange = ChipStyle._({
    'background-color': 'rgba(249, 115, 22, 0.15)',
    'color': '#F97316',
    'border': 'none',
  });

  /// Amber/Yellow chip
  static const ChipStyle yellow = ChipStyle._({
    'background-color': 'rgba(234, 179, 8, 0.15)',
    'color': '#EAB308',
    'border': 'none',
  });

  /// Green chip
  static const ChipStyle green = ChipStyle._({
    'background-color': 'rgba(34, 197, 94, 0.15)',
    'color': '#22C55E',
    'border': 'none',
  });

  /// Teal chip
  static const ChipStyle teal = ChipStyle._({
    'background-color': 'rgba(20, 184, 166, 0.15)',
    'color': '#14B8A6',
    'border': 'none',
  });

  /// Cyan chip
  static const ChipStyle cyan = ChipStyle._({
    'background-color': 'rgba(6, 182, 212, 0.15)',
    'color': '#06B6D4',
    'border': 'none',
  });

  /// Blue chip
  static const ChipStyle blue = ChipStyle._({
    'background-color': 'rgba(59, 130, 246, 0.15)',
    'color': '#3B82F6',
    'border': 'none',
  });

  /// Indigo chip
  static const ChipStyle indigo = ChipStyle._({
    'background-color': 'rgba(99, 102, 241, 0.15)',
    'color': '#6366F1',
    'border': 'none',
  });

  /// Purple/Violet chip
  static const ChipStyle purple = ChipStyle._({
    'background-color': 'rgba(139, 92, 246, 0.15)',
    'color': '#8B5CF6',
    'border': 'none',
  });

  /// Pink chip
  static const ChipStyle pink = ChipStyle._({
    'background-color': 'rgba(236, 72, 153, 0.15)',
    'color': '#EC4899',
    'border': 'none',
  });

  /// Rose chip
  static const ChipStyle rose = ChipStyle._({
    'background-color': 'rgba(244, 63, 94, 0.15)',
    'color': '#F43F5E',
    'border': 'none',
  });
}
