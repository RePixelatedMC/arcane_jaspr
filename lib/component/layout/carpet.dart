import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' hide Color, Colors, ColorScheme, Gap, Padding, TextAlign, TextOverflow, Border, BorderRadius, BoxShadow, FontWeight, StyleRule;

import '../../util/arcane.dart';
import '../../util/appearance/colors.dart';

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
    final EdgeInsets effectivePadding = padding ?? const EdgeInsets.all(16);
    final String effectiveRadius = radius != null ? '${radius}px' : '0.375rem';

    return div(
      classes: 'arcane-carpet',
      styles: Styles(raw: {
        'background-color': color?.css ?? 'var(--muted)',
        'border-radius': effectiveRadius,
        'padding': effectivePadding.padding,
        if (border) 'border': '1px solid var(--border)',
      }),
      [child],
    );
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
    final String effectiveRadius = radius != null ? '${radius}px' : '0.375rem';

    // Generate shadow based on elevation
    String boxShadow;
    switch (elevation) {
      case 0:
        boxShadow = 'none';
        break;
      case 1:
        boxShadow = '0 1px 2px 0 hsl(0 0% 0% / 0.05)';
        break;
      case 2:
        boxShadow = '0 1px 3px 0 hsl(0 0% 0% / 0.1), 0 1px 2px -1px hsl(0 0% 0% / 0.1)';
        break;
      case 3:
        boxShadow = '0 4px 6px -1px hsl(0 0% 0% / 0.1), 0 2px 4px -2px hsl(0 0% 0% / 0.1)';
        break;
      case 4:
        boxShadow = '0 10px 15px -3px hsl(0 0% 0% / 0.1), 0 4px 6px -4px hsl(0 0% 0% / 0.1)';
        break;
      default:
        boxShadow = '0 20px 25px -5px hsl(0 0% 0% / 0.1), 0 8px 10px -6px hsl(0 0% 0% / 0.1)';
    }

    return div(
      classes: 'arcane-surface',
      styles: Styles(raw: {
        'background-color': color?.css ?? 'var(--card)',
        'border-radius': effectiveRadius,
        if (padding != null) 'padding': padding!.padding,
        if (border) 'border': '1px solid var(--border)',
        'box-shadow': boxShadow,
      }),
      [child],
    );
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
    if (vertical) {
      return div(
        classes: 'arcane-divider-vertical',
        styles: Styles(raw: {
          'width': '${thickness ?? 1}px',
          'background-color': color?.css ?? 'var(--border)',
          'align-self': 'stretch',
          if (indent != null) 'margin-top': '${indent}px',
          if (endIndent != null) 'margin-bottom': '${endIndent}px',
        }),
        [],
      );
    } else {
      return div(
        classes: 'arcane-divider',
        styles: Styles(raw: {
          'height': '${thickness ?? 1}px',
          'background-color': color?.css ?? 'var(--border)',
          'width': '100%',
          if (indent != null) 'margin-left': '${indent}px',
          if (endIndent != null) 'margin-right': '${endIndent}px',
        }),
        [],
      );
    }
  }
}
