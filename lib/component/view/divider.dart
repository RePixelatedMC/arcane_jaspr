import 'package:jaspr/jaspr.dart';

import '../../core/theme_provider.dart';

export '../../core/props/divider_props.dart' show DividerVariant, DividerOrientation;

/// A horizontal divider component.
class ArcaneDivider extends StatelessComponent {
  final double? margin;
  final DividerVariant variant;
  final String? label;
  final bool dashed;

  const ArcaneDivider({
    this.margin,
    this.variant = DividerVariant.standard,
    this.label,
    this.dashed = false,
    super.key,
  });

  const ArcaneDivider.standard({
    this.margin,
    this.label,
    this.dashed = false,
    super.key,
  }) : variant = DividerVariant.standard;

  const ArcaneDivider.subtle({
    this.margin,
    this.label,
    this.dashed = false,
    super.key,
  }) : variant = DividerVariant.subtle;

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

/// A vertical divider component.
class ArcaneVerticalDivider extends StatelessComponent {
  final double? margin;
  final DividerVariant variant;
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
