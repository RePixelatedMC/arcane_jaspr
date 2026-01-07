import 'package:jaspr/jaspr.dart';

import '../../core/theme_provider.dart';

export '../../core/props/fab_props.dart' show FABVariant, FABSize, FABPosition;

/// A floating action button component.
class ArcaneFAB extends StatelessComponent {
  final Component icon;
  final String? label;
  final void Function()? onPressed;
  final FABVariant variant;
  final FABSize size;
  final bool disabled;
  final FABPosition position;
  final String? tooltip;
  final String? id;
  final Map<String, String>? attributes;

  const ArcaneFAB({
    required this.icon,
    this.label,
    this.onPressed,
    this.variant = FABVariant.primary,
    this.size = FABSize.regular,
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
    this.size = FABSize.regular,
    this.disabled = false,
    this.position = FABPosition.bottomRight,
    this.tooltip,
    this.id,
    this.attributes,
    super.key,
  }) : variant = FABVariant.primary;

  const ArcaneFAB.surface({
    required this.icon,
    this.label,
    this.onPressed,
    this.size = FABSize.regular,
    this.disabled = false,
    this.position = FABPosition.bottomRight,
    this.tooltip,
    this.id,
    this.attributes,
    super.key,
  }) : variant = FABVariant.surface;

  const ArcaneFAB.secondary({
    required this.icon,
    this.label,
    this.onPressed,
    this.size = FABSize.regular,
    this.disabled = false,
    this.position = FABPosition.bottomRight,
    this.tooltip,
    this.id,
    this.attributes,
    super.key,
  }) : variant = FABVariant.secondary;

  const ArcaneFAB.success({
    required this.icon,
    this.label,
    this.onPressed,
    this.size = FABSize.regular,
    this.disabled = false,
    this.position = FABPosition.bottomRight,
    this.tooltip,
    this.id,
    this.attributes,
    super.key,
  }) : variant = FABVariant.success;

  const ArcaneFAB.destructive({
    required this.icon,
    this.label,
    this.onPressed,
    this.size = FABSize.regular,
    this.disabled = false,
    this.position = FABPosition.bottomRight,
    this.tooltip,
    this.id,
    this.attributes,
    super.key,
  }) : variant = FABVariant.destructive;

  @override
  Component build(BuildContext context) {
    return context.renderers.fab(FABProps(
      icon: icon,
      label: label,
      onPressed: onPressed,
      variant: variant,
      size: size,
      disabled: disabled,
      position: position,
      tooltip: tooltip,
      id: id,
      attributes: attributes,
    ));
  }
}
