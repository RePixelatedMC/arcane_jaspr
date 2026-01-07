import 'package:jaspr/jaspr.dart';

/// Glass container component properties.
class GlassProps {
  final Component child;
  final double blur;
  final double opacity;
  final String? padding;
  final String? radius;
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

/// Glass card component properties.
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

/// Gradient glass component properties.
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
