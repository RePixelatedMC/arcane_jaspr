import 'package:jaspr/jaspr.dart';

import '../../util/arcane.dart';

/// Properties for carpet/surface container components.
class CarpetProps {
  /// The child component
  final Component child;

  /// Custom padding
  final EdgeInsets? padding;

  /// Border radius
  final double? radius;

  /// Background color
  final String? color;

  /// Whether to add a border
  final bool border;

  const CarpetProps({
    required this.child,
    this.padding,
    this.radius,
    this.color,
    this.border = false,
  });
}

/// Properties for surface components with elevation.
class SurfaceProps {
  /// The child component
  final Component child;

  /// Custom padding
  final EdgeInsets? padding;

  /// Border radius
  final double? radius;

  /// Elevation level (0-5)
  final int elevation;

  /// Background color
  final String? color;

  /// Whether to add a border
  final bool border;

  const SurfaceProps({
    required this.child,
    this.padding,
    this.radius,
    this.elevation = 1,
    this.color,
    this.border = true,
  });
}

/// Properties for divider components.
class ArcaneDividerProps {
  /// Thickness in pixels
  final double? thickness;

  /// Indent from start
  final double? indent;

  /// Indent from end
  final double? endIndent;

  /// Custom color
  final String? color;

  /// Whether vertical
  final bool vertical;

  const ArcaneDividerProps({
    this.thickness,
    this.indent,
    this.endIndent,
    this.color,
    this.vertical = false,
  });
}
