import 'package:jaspr/jaspr.dart';

import '../../core/theme_provider.dart';
import '../../util/arcane.dart';
import '../../util/appearance/colors.dart';

export '../../core/props/carpet_props.dart';

/// A background container component that provides a subtle surface layer.
///
/// Useful for creating visual hierarchy in layouts.
class ArcaneCarpet extends StatelessComponent {
  /// The child component
  final Component child;

  /// Custom padding
  final EdgeInsets? padding;

  /// Border radius
  final double? radius;

  /// Background color override
  final Color? color;

  /// Whether to add a border
  final bool border;

  const ArcaneCarpet({
    required this.child,
    this.padding,
    this.radius,
    this.color,
    this.border = false,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return context.renderers.carpet(CarpetProps(
      child: child,
      padding: padding,
      radius: radius,
      color: color?.css,
      border: border,
    ));
  }
}

/// A surface component with customizable elevation and appearance
class ArcaneSurface extends StatelessComponent {
  final Component child;
  final EdgeInsets? padding;
  final double? radius;
  final int elevation;
  final Color? color;
  final bool border;

  const ArcaneSurface({
    required this.child,
    this.padding,
    this.radius,
    this.elevation = 1,
    this.color,
    this.border = true,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return context.renderers.surface(SurfaceProps(
      child: child,
      padding: padding,
      radius: radius,
      elevation: elevation,
      color: color?.css,
      border: border,
    ));
  }
}

/// A divider component
class ArcaneDivider extends StatelessComponent {
  final double? thickness;
  final double? indent;
  final double? endIndent;
  final Color? color;
  final bool vertical;

  const ArcaneDivider({
    this.thickness,
    this.indent,
    this.endIndent,
    this.color,
    this.vertical = false,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return context.renderers.arcaneDivider(ArcaneDividerProps(
      thickness: thickness,
      indent: indent,
      endIndent: endIndent,
      color: color?.css,
      vertical: vertical,
    ));
  }
}
