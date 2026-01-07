import 'package:jaspr/jaspr.dart';

import '../../core/theme_provider.dart';

export '../../core/props/status_badge_props.dart';

/// Status indicator badge with optional pulse animation.
class ArcaneStatusBadge extends StatelessComponent {
  final StatusType status;
  final String label;
  final StatusBadgeSize size;
  final bool showGlow;
  final bool showPulse;
  final String? indicatorColor;
  final String? background;
  final String? borderColor;

  const ArcaneStatusBadge({
    required this.status,
    required this.label,
    this.size = StatusBadgeSize.md,
    this.showGlow = true,
    this.showPulse = true,
    this.indicatorColor,
    this.background,
    this.borderColor,
    super.key,
  });

  const ArcaneStatusBadge.success(
    this.label, {
    this.size = StatusBadgeSize.md,
    this.showGlow = true,
    this.showPulse = true,
    this.indicatorColor,
    this.background,
    this.borderColor,
    super.key,
  }) : status = StatusType.success;

  const ArcaneStatusBadge.warning(
    this.label, {
    this.size = StatusBadgeSize.md,
    this.showGlow = true,
    this.showPulse = true,
    this.indicatorColor,
    this.background,
    this.borderColor,
    super.key,
  }) : status = StatusType.warning;

  const ArcaneStatusBadge.error(
    this.label, {
    this.size = StatusBadgeSize.md,
    this.showGlow = true,
    this.showPulse = true,
    this.indicatorColor,
    this.background,
    this.borderColor,
    super.key,
  }) : status = StatusType.error;

  const ArcaneStatusBadge.info(
    this.label, {
    this.size = StatusBadgeSize.md,
    this.showGlow = true,
    this.showPulse = true,
    this.indicatorColor,
    this.background,
    this.borderColor,
    super.key,
  }) : status = StatusType.info;

  const ArcaneStatusBadge.offline(
    this.label, {
    this.size = StatusBadgeSize.md,
    this.showGlow = false,
    this.showPulse = false,
    this.indicatorColor,
    this.background,
    this.borderColor,
    super.key,
  }) : status = StatusType.offline;

  @override
  Component build(BuildContext context) {
    return context.renderers.statusBadge2(StatusBadgeProps(
      status: status,
      label: label,
      size: size,
      showGlow: showGlow,
      showPulse: showPulse,
      indicatorColor: indicatorColor,
      background: background,
      borderColor: borderColor,
    ));
  }
}
