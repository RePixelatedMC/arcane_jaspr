import 'status_indicator_props.dart' show StatusType;

export 'status_indicator_props.dart' show StatusType;

enum StatusBadgeSize {
  sm,
  md,
  lg,
}

/// Status badge component properties.
class StatusBadgeProps {
  final StatusType status;
  final String label;
  final StatusBadgeSize size;
  final bool showGlow;
  final bool showPulse;
  final String? indicatorColor;
  final String? background;
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
