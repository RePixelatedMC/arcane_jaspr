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
      String? defaultClip,
      String? defaultRadius,
    ) = switch (props.shape) {
      SkeletonShape.rectangle => ('100%', '20px', 'var(--neon-clip-xs)', null),
      SkeletonShape.circle => ('48px', '48px', null, '9999px'),
      SkeletonShape.text => (
        '100%',
        '1rem',
        null,
        'var(--neon-radius-control)',
      ),
    };

    final String width = props.width ?? defaultWidth;
    final String height = props.height ?? defaultHeight;
    final String? borderRadius = props.borderRadius ?? defaultRadius;
    final bool useChamfer = borderRadius == null && defaultClip != null;

    return dom.div(
      classes: 'neon-skeleton ${props.animate ? 'animate' : ''}',
      styles: dom.Styles(
        raw: {
          'width': width,
          'height': height,
          if (borderRadius != null) 'border-radius': borderRadius,
          if (useChamfer) 'clip-path': defaultClip,
          'background':
              'color-mix(in srgb, var(--neon-accent) 6%, var(--neon-surface-2))',
          if (props.animate) ...{
            'animation': 'neon-skeleton-pulse 1.6s ease-in-out infinite',
            'background':
                'linear-gradient(90deg, color-mix(in srgb, var(--neon-accent) 6%, var(--neon-surface-2)) 0%, color-mix(in srgb, var(--neon-accent) 14%, var(--neon-surface-2)) 50%, color-mix(in srgb, var(--neon-accent) 6%, var(--neon-surface-2)) 100%)',
            'background-size': '200% 100%',
          },
        },
      ),
      [],
    );
  }
}
