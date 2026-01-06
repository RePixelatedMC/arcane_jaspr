import 'package:jaspr/jaspr.dart';

import '../../core/props/divider_props.dart';
import '../../core/theme_provider.dart';

export '../../core/props/divider_props.dart' show DividerVariant, DividerOrientation;

/// A horizontal divider component
///
/// ```dart
/// ArcaneDivider(
///   variant: DividerVariant.subtle,
/// )
/// ```
class ArcaneDivider extends StatelessComponent {
  /// Vertical margin
  final double? margin;

  /// Style variant
  final DividerVariant variant;

  /// Optional label in the middle
  final String? label;

  /// Whether to use a dashed style
  final bool dashed;

  const ArcaneDivider({
    this.margin,
    this.variant = DividerVariant.standard,
    this.label,
    this.dashed = false,
    super.key,
  });

  /// Standard divider
  const ArcaneDivider.standard({
    this.margin,
    this.label,
    this.dashed = false,
    super.key,
  }) : variant = DividerVariant.standard;

  /// Subtle divider
  const ArcaneDivider.subtle({
    this.margin,
    this.label,
    this.dashed = false,
    super.key,
  }) : variant = DividerVariant.subtle;

  /// Bold divider
  const ArcaneDivider.bold({
    this.margin,
    this.label,
    this.dashed = false,
    super.key,
  }) : variant = DividerVariant.bold;

  @override
  Component build(BuildContext context) {
    return context.renderers.divider(DividerProps(
      margin: margin,
      variant: variant,
      label: label,
      dashed: dashed,
      orientation: DividerOrientation.horizontal,
    ));
  }
}

/// A vertical divider component
class ArcaneVerticalDivider extends StatelessComponent {
  /// Horizontal margin
  final double? margin;

  /// Style variant
  final DividerVariant variant;

  /// Height (null for full height)
  final double? height;

  const ArcaneVerticalDivider({
    this.margin,
    this.variant = DividerVariant.standard,
    this.height,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return context.renderers.divider(DividerProps(
      margin: margin,
      variant: variant,
      orientation: DividerOrientation.vertical,
      height: height,
    ));
  }
}
