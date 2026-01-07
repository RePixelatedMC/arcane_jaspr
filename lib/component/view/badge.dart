import 'package:jaspr/jaspr.dart';

import '../../core/theme_provider.dart';

export '../../core/props/badge_props.dart' show BadgeVariant, BadgeSize;

/// A pill-shaped badge/label component.
class ArcaneBadge extends StatelessComponent {
  final String label;
  final Component? icon;
  final BadgeVariant variant;
  final BadgeSize size;

  const ArcaneBadge(
    this.label, {
    this.icon,
    this.variant = BadgeVariant.standard,
    this.size = BadgeSize.medium,
    super.key,
  });

  const ArcaneBadge.primary(
    this.label, {
    this.icon,
    this.size = BadgeSize.medium,
    super.key,
  }) : variant = BadgeVariant.primary;

  const ArcaneBadge.secondary(
    this.label, {
    this.icon,
    this.size = BadgeSize.medium,
    super.key,
  }) : variant = BadgeVariant.secondary;

  const ArcaneBadge.success(
    this.label, {
    this.icon,
    this.size = BadgeSize.medium,
    super.key,
  }) : variant = BadgeVariant.success;

  const ArcaneBadge.warning(
    this.label, {
    this.icon,
    this.size = BadgeSize.medium,
    super.key,
  }) : variant = BadgeVariant.warning;

  const ArcaneBadge.error(
    this.label, {
    this.icon,
    this.size = BadgeSize.medium,
    super.key,
  }) : variant = BadgeVariant.error;

  const ArcaneBadge.destructive(
    this.label, {
    this.icon,
    this.size = BadgeSize.medium,
    super.key,
  }) : variant = BadgeVariant.error;

  const ArcaneBadge.info(
    this.label, {
    this.icon,
    this.size = BadgeSize.medium,
    super.key,
  }) : variant = BadgeVariant.info;

  const ArcaneBadge.outline(
    this.label, {
    this.icon,
    this.size = BadgeSize.medium,
    super.key,
  }) : variant = BadgeVariant.outline;

  @override
  Component build(BuildContext context) {
    return context.renderers.badge(BadgeProps(
      label: label,
      icon: icon,
      variant: variant,
      size: size,
    ));
  }
}
