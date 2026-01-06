import 'package:jaspr/jaspr.dart';

import '../../core/props/glass_props.dart';
import '../../core/theme_provider.dart';
import '../../util/arcane.dart';

// Re-export props for usage
export '../../core/props/glass_props.dart';

/// A glassmorphism container component.
///
/// Creates a frosted glass effect using CSS backdrop-filter.
class ArcaneGlass extends StatelessComponent {
  /// The child component
  final Component child;

  /// Blur amount
  final double blur;

  /// Opacity of the glass surface
  final double opacity;

  /// Custom padding
  final EdgeInsets? padding;

  /// Border radius
  final double? radius;

  /// Whether to show a border
  final bool border;

  const ArcaneGlass({
    required this.child,
    this.blur = 12.0,
    this.opacity = 0.7,
    this.padding,
    this.radius,
    this.border = true,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return context.renderers.glass(GlassProps(
      child: child,
      blur: blur,
      opacity: opacity,
      padding: padding?.padding,
      radius: radius != null ? '${radius}px' : null,
      border: border,
    ));
  }
}

/// A glass card with standard card styling
class ArcaneGlassCard extends StatelessComponent {
  final Component child;
  final double blur;
  final double opacity;
  final EdgeInsets? padding;
  final double? radius;
  final bool border;
  final void Function()? onTap;

  const ArcaneGlassCard({
    required this.child,
    this.blur = 12.0,
    this.opacity = 0.7,
    this.padding,
    this.radius,
    this.border = true,
    this.onTap,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return context.renderers.glassCard(GlassCardProps(
      child: child,
      blur: blur,
      opacity: opacity,
      padding: padding?.padding ?? '1rem',
      radius: radius != null ? '${radius}px' : null,
      border: border,
      onTap: onTap,
    ));
  }
}

/// A gradient glass effect
class ArcaneGradientGlass extends StatelessComponent {
  final Component child;
  final double blur;
  final String? gradientStart;
  final String? gradientEnd;
  final double opacity;
  final EdgeInsets? padding;
  final double? radius;
  final String direction;

  const ArcaneGradientGlass({
    required this.child,
    this.blur = 12.0,
    this.gradientStart,
    this.gradientEnd,
    this.opacity = 0.2,
    this.padding,
    this.radius,
    this.direction = 'to bottom right',
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return context.renderers.gradientGlass(GradientGlassProps(
      child: child,
      blur: blur,
      gradientStart: gradientStart,
      gradientEnd: gradientEnd,
      opacity: opacity,
      padding: padding?.padding,
      radius: radius != null ? '${radius}px' : null,
      direction: direction,
    ));
  }
}
