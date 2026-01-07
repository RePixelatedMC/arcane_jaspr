import 'package:jaspr/jaspr.dart';

import '../../core/theme_provider.dart';

export '../../core/props/status_indicator_props.dart';

/// Status indicator dot with optional label.
class ArcaneStatusIndicator extends StatelessComponent {
  final StatusType status;
  final String? label;
  final String? size;
  final bool pulse;

  const ArcaneStatusIndicator({
    required this.status,
    this.label,
    this.size,
    this.pulse = false,
    super.key,
  });

  const ArcaneStatusIndicator.online({
    this.label,
    this.size,
    this.pulse = true,
    super.key,
  }) : status = StatusType.online;

  const ArcaneStatusIndicator.offline({
    this.label,
    this.size,
    super.key,
  })  : status = StatusType.offline,
        pulse = false;

  const ArcaneStatusIndicator.busy({
    this.label,
    this.size,
    super.key,
  })  : status = StatusType.busy,
        pulse = false;

  const ArcaneStatusIndicator.away({
    this.label,
    this.size,
    super.key,
  })  : status = StatusType.away,
        pulse = false;

  @override
  Component build(BuildContext context) {
    return context.renderers.statusIndicator(StatusIndicatorProps(
      status: status,
      label: label,
      size: size,
      pulse: pulse,
    ));
  }
}

/// Status badge combining status indicator with text.
class ArcaneStatusBadge extends StatelessComponent {
  final StatusType status;
  final String label;

  const ArcaneStatusBadge({
    required this.status,
    required this.label,
    super.key,
  });

  const ArcaneStatusBadge.success({
    required this.label,
    super.key,
  }) : status = StatusType.success;

  const ArcaneStatusBadge.error({
    required this.label,
    super.key,
  }) : status = StatusType.error;

  const ArcaneStatusBadge.warning({
    required this.label,
    super.key,
  }) : status = StatusType.warning;

  const ArcaneStatusBadge.info({
    required this.label,
    super.key,
  }) : status = StatusType.info;

  @override
  Component build(BuildContext context) {
    return context.renderers.statusBadge(SimpleStatusBadgeProps(
      status: status,
      label: label,
    ));
  }
}
