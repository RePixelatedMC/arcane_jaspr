import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import 'package:arcane_jaspr/core/props/skeleton_props.dart';

/// ShadCN Skeleton renderer.
///
/// Reference: https://ui.shadcn.com/docs/components/skeleton
class ShadcnSkeleton extends StatelessComponent {
  final SkeletonProps props;

  const ShadcnSkeleton(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    // Default dimensions based on shape
    final (defaultWidth, defaultHeight, defaultRadius) = switch (props.shape) {
      SkeletonShape.circle => ('2.5rem', '2.5rem', '9999px'),
      SkeletonShape.text => ('100%', '1rem', '0.25rem'),
      SkeletonShape.rectangle => ('100%', '1.25rem', '0.375rem'),
    };

    final width = props.width ?? defaultWidth;
    final height = props.height ?? defaultHeight;
    final borderRadius = props.borderRadius ?? defaultRadius;

    // ShadCN Skeleton: animate-pulse rounded-md bg-muted
    return dom.div(
      classes: 'arcane-skeleton ${props.animate ? 'animate' : ''}',
      styles: dom.Styles(
        raw: {
          'width': width,
          'height': height,
          'border-radius': borderRadius,
          'background-color': 'var(--muted)',
          if (props.animate)
            'animation':
                'arcane-pulse 2s cubic-bezier(0.4, 0, 0.6, 1) infinite',
        },
      ),
      [],
    );
  }
}
