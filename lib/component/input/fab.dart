import 'package:jaspr/jaspr.dart';

import '../../core/theme_provider.dart';

export '../../core/props/fab_props.dart' show ColorVariant, ComponentSize, FABPosition;

/// A floating action button component.
class ArcaneFAB extends StatelessComponent {
  final Component icon;
  final String? label;
  final void Function()? onPressed;
  final ColorVariant color;
  final ComponentSize size;
  final bool disabled;
  final FABPosition position;
  final String? tooltip;
  final String? id;
  final Map<String, String>? attributes;

  const ArcaneFAB({
    required this.icon,
    this.label,
    this.onPressed,
    this.color = ColorVariant.primary,
    this.size = ComponentSize.md,
    this.disabled = false,
    this.position = FABPosition.bottomRight,
    this.tooltip,
    this.id,
    this.attributes,
    super.key,
  });

  const ArcaneFAB.primary({
    required this.icon,
    this.label,
    this.onPressed,
    this.size = ComponentSize.md,
    this.disabled = false,
    this.position = FABPosition.bottomRight,
    this.tooltip,
    this.id,
    this.attributes,
    super.key,
  }) : color = ColorVariant.primary;

  const ArcaneFAB.secondary({
    required this.icon,
    this.label,
    this.onPressed,
    this.size = ComponentSize.md,
    this.disabled = false,
    this.position = FABPosition.bottomRight,
    this.tooltip,
    this.id,
    this.attributes,
    super.key,
  }) : color = ColorVariant.secondary;

  const ArcaneFAB.success({
    required this.icon,
    this.label,
    this.onPressed,
    this.size = ComponentSize.md,
    this.disabled = false,
    this.position = FABPosition.bottomRight,
    this.tooltip,
    this.id,
    this.attributes,
    super.key,
  }) : color = ColorVariant.success;

  const ArcaneFAB.destructive({
    required this.icon,
    this.label,
    this.onPressed,
    this.size = ComponentSize.md,
    this.disabled = false,
    this.position = FABPosition.bottomRight,
    this.tooltip,
    this.id,
    this.attributes,
    super.key,
  }) : color = ColorVariant.destructive;

  @override
  Component build(BuildContext context) {
    return context.renderers.fab(FABProps(
      icon: icon,
      label: label,
      onPressed: onPressed,
      color: color,
      size: size,
      disabled: disabled,
      position: position,
      tooltip: tooltip,
      id: id,
      attributes: attributes,
    ));
  }
}
