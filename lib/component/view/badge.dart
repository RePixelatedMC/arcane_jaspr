import 'package:jaspr/jaspr.dart';

import '../../core/theme_provider.dart';

// Re-export for convenience
export '../../core/props/badge_props.dart' show BadgeVariant, BadgeSize;

/// A pill-shaped badge/label component.
///
/// The actual rendering is delegated to the current stylesheet's renderer,
/// ensuring consistent API regardless of which design system is active.
///
/// ## Basic Usage
///
/// ```dart
/// ArcaneBadge('Active')
/// ArcaneBadge('New', variant: BadgeVariant.success)
/// ```
///
/// ## Variants
///
/// Use named constructors for common variants:
///
/// ```dart
/// ArcaneBadge.primary('Premium')
/// ArcaneBadge.success('Active')
/// ArcaneBadge.warning('Pending')
/// ArcaneBadge.error('Failed')
/// ArcaneBadge.info('Beta')
/// ArcaneBadge.outline('Draft')
/// ```
class ArcaneBadge extends StatelessComponent {
  /// The badge text
  final String label;

  /// Optional leading icon
  final Component? icon;

  /// Badge style variant
  final BadgeVariant variant;

  /// Badge size
  final BadgeSize size;

  const ArcaneBadge(
    this.label, {
    this.icon,
    this.variant = BadgeVariant.standard,
    this.size = BadgeSize.medium,
    super.key,
  });

  /// Primary badge
  const ArcaneBadge.primary(
    this.label, {
    this.icon,
    this.size = BadgeSize.medium,
    super.key,
  }) : variant = BadgeVariant.primary;

  /// Secondary badge
  const ArcaneBadge.secondary(
    this.label, {
    this.icon,
    this.size = BadgeSize.medium,
    super.key,
  }) : variant = BadgeVariant.secondary;

  /// Success badge
  const ArcaneBadge.success(
    this.label, {
    this.icon,
    this.size = BadgeSize.medium,
    super.key,
  }) : variant = BadgeVariant.success;

  /// Warning badge
  const ArcaneBadge.warning(
    this.label, {
    this.icon,
    this.size = BadgeSize.medium,
    super.key,
  }) : variant = BadgeVariant.warning;

  /// Error/destructive badge
  const ArcaneBadge.error(
    this.label, {
    this.icon,
    this.size = BadgeSize.medium,
    super.key,
  }) : variant = BadgeVariant.error;

  /// Alias for error
  const ArcaneBadge.destructive(
    this.label, {
    this.icon,
    this.size = BadgeSize.medium,
    super.key,
  }) : variant = BadgeVariant.error;

  /// Info badge
  const ArcaneBadge.info(
    this.label, {
    this.icon,
    this.size = BadgeSize.medium,
    super.key,
  }) : variant = BadgeVariant.info;

  /// Outline badge
  const ArcaneBadge.outline(
    this.label, {
    this.icon,
    this.size = BadgeSize.medium,
    super.key,
  }) : variant = BadgeVariant.outline;

  @override
  Component build(BuildContext context) {
    // Delegate to the current stylesheet's badge renderer
    return context.renderers.badge(BadgeProps(
      label: label,
      icon: icon,
      variant: variant,
      size: size,
    ));
  }
}
