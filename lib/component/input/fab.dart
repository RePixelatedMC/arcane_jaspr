import 'package:jaspr/jaspr.dart';

import '../../core/theme_provider.dart';

export '../../core/props/fab_props.dart' show FABVariant, FABSize, FABPosition;

/// A floating action button component.
///
/// ```dart
/// ArcaneFAB(
///   icon: Icon(Icons.add),
///   variant: FABVariant.primary,
/// )
/// ```
class ArcaneFAB extends StatelessComponent {
  /// The icon to display
  final Component icon;

  /// Optional label for extended FAB
  final String? label;

  /// Click handler
  final void Function()? onPressed;

  /// Style variant
  final FABVariant variant;

  /// FAB size
  final FABSize size;

  /// Whether the FAB is disabled
  final bool disabled;

  /// Position of the FAB
  final FABPosition position;

  /// Tooltip text
  final String? tooltip;

  /// Optional element ID
  final String? id;

  /// Additional HTML attributes
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

  /// Primary FAB
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

  /// Surface FAB
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

  /// Secondary FAB
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

  /// Success FAB
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

  /// Destructive FAB
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
