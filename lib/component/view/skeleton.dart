import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../core/theme_provider.dart';

/// Skeleton loading placeholder component
/// ShadCN Reference: https://ui.shadcn.com/docs/components/skeleton
///
/// ```dart
/// ArcaneSkeleton(width: '100%', height: '20px')
/// ArcaneSkeleton.circle(height: '48px')
/// ```
class ArcaneSkeleton extends StatelessComponent {
  final SkeletonShape shape;
  final String? width;
  final String? height;
  final String? borderRadius;
  final bool animate;

  const ArcaneSkeleton({
    this.shape = SkeletonShape.rectangle,
    this.width,
    this.height,
    this.borderRadius,
    this.animate = true,
    super.key,
  });

  /// Circle skeleton
  const ArcaneSkeleton.circle({
    this.height,
    this.animate = true,
    super.key,
  })  : shape = SkeletonShape.circle,
        width = null,
        borderRadius = null;

  /// Text line skeleton
  const ArcaneSkeleton.line({
    this.width,
    this.animate = true,
    super.key,
  })  : shape = SkeletonShape.text,
        height = null,
        borderRadius = null;

  @override
  Component build(BuildContext context) {
    return context.renderers.skeleton(SkeletonProps(
      shape: shape,
      width: width,
      height: height,
      borderRadius: borderRadius,
      animate: animate,
    ));
  }
}

/// Skeleton card placeholder
class ArcaneSkeletonCard extends StatelessComponent {
  final bool showAvatar;
  final int lines;

  const ArcaneSkeletonCard({
    this.showAvatar = true,
    this.lines = 3,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return dom.div(
      classes: 'arcane-skeleton-card',
      styles: const dom.Styles(raw: {
        'background-color': 'var(--card)',
        'border': '1px solid var(--border)',
        'border-radius': '0.5rem',
        'padding': '24px',
      }),
      [
        // Header with avatar
        if (showAvatar)
          const dom.div(
            styles: dom.Styles(raw: {
              'display': 'flex',
              'align-items': 'center',
              'gap': '16px',
              'margin-bottom': '24px',
            }),
            [
              ArcaneSkeleton(
                shape: SkeletonShape.circle,
                width: '48px',
                height: '48px',
              ),
              dom.div(
                styles: dom.Styles(raw: {
                  'flex': '1',
                  'display': 'flex',
                  'flex-direction': 'column',
                  'gap': '8px',
                }),
                [
                  ArcaneSkeleton(width: '40%', height: '16px'),
                  ArcaneSkeleton(width: '60%', height: '14px'),
                ],
              ),
            ],
          ),
        // Content lines
        for (var i = 0; i < lines; i++)
          dom.div(
            styles: dom.Styles(raw: {
              if (i < lines - 1) 'margin-bottom': '8px',
            }),
            [
              ArcaneSkeleton(
                width: i == lines - 1 ? '80%' : '100%',
                height: '16px',
              ),
            ],
          ),
      ],
    );
  }
}

/// Skeleton text block with multiple lines
class ArcaneSkeletonText extends StatelessComponent {
  final int lines;
  final String? lineHeight;

  const ArcaneSkeletonText({
    this.lines = 3,
    this.lineHeight,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return dom.div(
      classes: 'arcane-skeleton-text',
      styles: const dom.Styles(raw: {
        'display': 'flex',
        'flex-direction': 'column',
        'gap': '0.5rem',
      }),
      [
        for (var i = 0; i < lines; i++)
          ArcaneSkeleton(
            width: i == lines - 1 ? '70%' : '100%',
            height: lineHeight ?? '16px',
          ),
      ],
    );
  }
}