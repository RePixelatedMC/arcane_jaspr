import 'package:jaspr/jaspr.dart';

import '../../core/theme_provider.dart';

export '../../core/props/badge_props.dart' show ColorVariant, StyleVariant, ComponentSize;

/// A pill-shaped badge/label component.
class ArcaneBadge extends StatelessComponent {
  final String label;
  final Component? icon;
  final ColorVariant color;
  final StyleVariant style;
  final ComponentSize size;

  const ArcaneBadge(
    this.label, {
    this.icon,
    this.color = ColorVariant.secondary,
    this.style = StyleVariant.solid,
    this.size = ComponentSize.md,
    super.key,
  });

  const ArcaneBadge.primary(
    this.label, {
    this.icon,
    this.size = ComponentSize.md,
    super.key,
  })  : color = ColorVariant.primary,
        style = StyleVariant.solid;

  const ArcaneBadge.secondary(
    this.label, {
    this.icon,
    this.size = ComponentSize.md,
    super.key,
  })  : color = ColorVariant.secondary,
        style = StyleVariant.solid;

  const ArcaneBadge.success(
    this.label, {
    this.icon,
    this.size = ComponentSize.md,
    super.key,
  })  : color = ColorVariant.success,
        style = StyleVariant.solid;

  const ArcaneBadge.warning(
    this.label, {
    this.icon,
    this.size = ComponentSize.md,
    super.key,
  })  : color = ColorVariant.warning,
        style = StyleVariant.solid;

  const ArcaneBadge.error(
    this.label, {
    this.icon,
    this.size = ComponentSize.md,
    super.key,
  })  : color = ColorVariant.destructive,
        style = StyleVariant.solid;

  const ArcaneBadge.destructive(
    this.label, {
    this.icon,
    this.size = ComponentSize.md,
    super.key,
  })  : color = ColorVariant.destructive,
        style = StyleVariant.solid;

  const ArcaneBadge.info(
    this.label, {
    this.icon,
    this.size = ComponentSize.md,
    super.key,
  })  : color = ColorVariant.info,
        style = StyleVariant.solid;

  const ArcaneBadge.outline(
    this.label, {
    this.icon,
    this.size = ComponentSize.md,
    super.key,
  })  : color = ColorVariant.secondary,
        style = StyleVariant.outline;

  @override
  Component build(BuildContext context) {
    return context.renderers.badge(BadgeProps(
      label: label,
      icon: icon,
      color: color,
      style: style,
      size: size,
    ));
  }
}
