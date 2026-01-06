import 'package:jaspr/jaspr.dart';

/// Properties for glass container components.
class GlassProps {
  /// The child component
  final Component child;

  /// Blur amount
  final double blur;

  /// Opacity of the glass surface
  final double opacity;

  /// Custom padding (as CSS string)
  final String? padding;

  /// Border radius (as CSS string)
  final String? radius;

  /// Whether to show a border
  final bool border;

  const GlassProps({
    required this.child,
    this.blur = 12.0,
    this.opacity = 0.7,
    this.padding,
    this.radius,
    this.border = true,
  });
}

/// Properties for glass card components.
class GlassCardProps {
  final Component child;
  final double blur;
  final double opacity;
  final String? padding;
  final String? radius;
  final bool border;
  final void Function()? onTap;

  const GlassCardProps({
    required this.child,
    this.blur = 12.0,
    this.opacity = 0.7,
    this.padding,
    this.radius,
    this.border = true,
    this.onTap,
  });
}

/// Properties for gradient glass components.
class GradientGlassProps {
  final Component child;
  final double blur;
  final String? gradientStart;
  final String? gradientEnd;
  final double opacity;
  final String? padding;
  final String? radius;
  final String direction;

  const GradientGlassProps({
    required this.child,
    this.blur = 12.0,
    this.gradientStart,
    this.gradientEnd,
    this.opacity = 0.2,
    this.padding,
    this.radius,
    this.direction = 'to bottom right',
  });
}
