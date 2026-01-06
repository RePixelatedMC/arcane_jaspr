import 'package:jaspr/jaspr.dart';

import '../../core/theme_provider.dart';

export '../../core/props/status_badge_props.dart';

/// A status indicator badge with pulse animation.
///
/// Used for showing system status, service health, or state indicators.
///
/// ```dart
/// ArcaneStatusBadge(
///   status: StatusType.success,
///   label: 'All Systems Operational',
/// )
///
/// ArcaneStatusBadge.success('Online')
/// ArcaneStatusBadge.error('Service Down')
/// ```
class ArcaneStatusBadge extends StatelessComponent {
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

  /// Create a success status badge
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

  /// Create a warning status badge
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

  /// Create an error status badge
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

  /// Create an info status badge
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

  /// Create an offline status badge
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
