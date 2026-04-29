import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import 'package:arcane_jaspr/core/props/skeleton_props.dart';

class NeubrutalismSkeleton extends StatelessComponent {
  final SkeletonProps props;

  const NeubrutalismSkeleton(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    final (
      String defaultWidth,
      String defaultHeight,
      String? defaultClip,
      String? defaultRadius,
    ) = switch (props.shape) {
      SkeletonShape.rectangle => ('100%', '20px', 'none', null),
      SkeletonShape.circle => ('48px', '48px', null, '9999px'),
      SkeletonShape.text => (
        '100%',
        '1rem',
        null,
        'var(--nb-radius-soft, 4px)',
      ),
    };

    final String width = props.width ?? defaultWidth;
    final String height = props.height ?? defaultHeight;
    final String? borderRadius = props.borderRadius ?? defaultRadius;
    final bool useChamfer = borderRadius == null && defaultClip != null;

    return dom.div(
      classes: 'neubrutalism-skeleton ${props.animate ? 'animate' : ''}',
      styles: dom.Styles(
        raw: <String, String>{
          'width': width,
          'height': height,
          if (borderRadius != null) 'border-radius': borderRadius,
          if (useChamfer) 'clip-path': defaultClip,
          'background': 'var(--nb-paper, var(--card))',
          'border': 'var(--nb-border-thin, 2px) solid var(--nb-line, #000)',
          'box-shadow':
              'var(--nb-shadow-xs, 2px 2px 0 0 var(--nb-shadow-color, #000))',
          'opacity': props.animate ? '0.7' : '0.55',
        },
      ),
      const <Component>[],
    );
  }
}
