/// Status types
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

/// Properties for status indicator components.
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

/// Properties for simple status badge components (text + dot indicator).
class SimpleStatusBadgeProps {
  final StatusType status;
  final String label;

  const SimpleStatusBadgeProps({
    required this.status,
    required this.label,
  });
}
