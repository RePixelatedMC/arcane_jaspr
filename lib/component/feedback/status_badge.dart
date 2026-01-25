import 'package:jaspr/jaspr.dart';

import '../../core/theme_provider.dart';

export '../../core/props/status_indicator_props.dart'
    show StatusType, SimpleStatusBadgeProps;
export '../../core/shared/shared.dart' show ComponentSize;

/// Status indicator badge with optional pulse animation.
class ArcaneStatusBadge extends StatelessComponent {
  final StatusType status;
  final String label;

  const ArcaneStatusBadge({
    required this.status,
    required this.label,
    super.key,
  });

  const ArcaneStatusBadge.success(
    this.label, {
    super.key,
  }) : status = StatusType.success;

  const ArcaneStatusBadge.warning(
    this.label, {
    super.key,
  }) : status = StatusType.warning;

  const ArcaneStatusBadge.error(
    this.label, {
    super.key,
  }) : status = StatusType.error;

  const ArcaneStatusBadge.info(
    this.label, {
    super.key,
  }) : status = StatusType.info;

  const ArcaneStatusBadge.offline(
    this.label, {
    super.key,
  }) : status = StatusType.offline;

  @override
  Component build(BuildContext context) {
    return context.renderers.statusBadge(SimpleStatusBadgeProps(
      status: status,
      label: label,
    ));
  }
}
