import 'status_indicator_props.dart' show StatusType;

export 'status_indicator_props.dart' show StatusType;

/// Status badge size
enum StatusBadgeSize {
  /// Small: compact, minimal text
  sm,

  /// Medium: default size
  md,

  /// Large: prominent display
  lg,
}

/// Properties for status badge components.
class StatusBadgeProps {
  /// The status type (determines color)
  final StatusType status;

  /// The label text
  final String label;

  /// Badge size
  final StatusBadgeSize size;

  /// Whether to show the glow effect on the indicator
  final bool showGlow;

  /// Whether to show the pulse animation
  final bool showPulse;

  /// Custom indicator color (overrides status default)
  final String? indicatorColor;

  /// Custom background color
  final String? background;

  /// Custom border color
  final String? borderColor;

  const StatusBadgeProps({
    required this.status,
    required this.label,
    this.size = StatusBadgeSize.md,
    this.showGlow = true,
    this.showPulse = true,
    this.indicatorColor,
    this.background,
    this.borderColor,
  });
}
