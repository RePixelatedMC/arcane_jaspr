import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import 'package:arcane_jaspr/core/props/skeleton_props.dart';

/// Neon Skeleton renderer.
///
/// Implements the Neon design language:
/// - Darker skeleton color for OLED
/// - Subtle pulse animation
/// - Larger default border radius
class NeonSkeleton extends StatelessComponent {
  final SkeletonProps props;

  const NeonSkeleton(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    // Default dimensions based on shape
    final (
      String defaultWidth,
      String defaultHeight,
      String defaultRadius,
    ) = switch (props.shape) {
      SkeletonShape.rectangle => ('100%', '20px', 'var(--radius-md)'),
      SkeletonShape.circle => (
        '48px',
        '48px',
        '9999px',
      ), // Neon: larger default
      SkeletonShape.text => ('100%', '1rem', 'var(--radius-sm)'),
    };

    final String width = props.width ?? defaultWidth;
    final String height = props.height ?? defaultHeight;
    final String borderRadius = props.borderRadius ?? defaultRadius;

    return dom.div(
      classes: 'neon-skeleton ${props.animate ? 'animate' : ''}',
      styles: dom.Styles(
        raw: {
          'width': width,
          'height': height,
          'border-radius': borderRadius,
          // Neon: darker skeleton for OLED
          'background-color': 'var(--muted)',
          if (props.animate) ...{
            'animation': 'neon-skeleton-pulse 2s ease-in-out infinite',
            'background':
                'linear-gradient(90deg, var(--muted) 0%, var(--secondary) 50%, var(--muted) 100%)',
            'background-size': '200% 100%',
          },
        },
      ),
      [],
    );
  }
}
