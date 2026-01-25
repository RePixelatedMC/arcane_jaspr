import '../shared/shared.dart';
import 'status_indicator_props.dart' show StatusType;

export '../shared/shared.dart' show ComponentSize;
export 'status_indicator_props.dart' show StatusType;

/// Status badge component properties.
class StatusBadgeProps {
  final StatusType status;
  final String label;
  final ComponentSize size;
  final bool showGlow;
  final bool showPulse;
  final String? indicatorColor;
  final String? background;
  final String? borderColor;

  const StatusBadgeProps({
    required this.status,
    required this.label,
    this.size = ComponentSize.md,
    this.showGlow = true,
    this.showPulse = true,
    this.indicatorColor,
    this.background,
    this.borderColor,
  });
}

// Note: The statusBadge renderer method is defined in StatusIndicatorRendererContract
// using SimpleStatusBadgeProps. The StatusBadgeProps class here can be used for
// a more feature-rich status badge component in the future.
