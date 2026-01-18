import 'package:jaspr/jaspr.dart';

enum StatusType {
  online,
  offline,
  busy,
  away,
  success,
  error,
  warning,
  info,
}

/// Status indicator component properties.
class StatusIndicatorProps {
  final StatusType status;
  final String? label;
  final String? size;
  final bool pulse;

  const StatusIndicatorProps({
    required this.status,
    this.label,
    this.size,
    this.pulse = false,
  });
}

/// Simple status badge component properties.
class SimpleStatusBadgeProps {
  final StatusType status;
  final String label;

  const SimpleStatusBadgeProps({
    required this.status,
    required this.label,
  });
}

// ============================================================================
// RENDERER CONTRACT
// ============================================================================

/// Mixin defining the renderer methods for status indicator components.
mixin StatusIndicatorRendererContract {
  Component statusIndicator(StatusIndicatorProps props);
  Component statusBadge(SimpleStatusBadgeProps props);
}
