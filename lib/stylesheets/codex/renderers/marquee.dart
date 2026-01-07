import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../core/props/marquee_props.dart';
import '../../../component/view/fade_edge.dart';

/// Codex Marquee renderer.
class CodexMarquee extends StatelessComponent {
  final MarqueeProps props;

  const CodexMarquee(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    final effectiveGap = props.gap ?? '2rem';
    final marqueeId = props.id ?? 'codex-marquee-${hashCode}';
    final isReverse = props.direction == MarqueeDirection.right;
    final animationName = isReverse
        ? 'codex-marquee-scroll-reverse-$marqueeId'
        : 'codex-marquee-scroll-$marqueeId';

    return dom.div(
      classes: 'codex-marquee',
      styles: const dom.Styles(raw: {
        'position': 'relative',
        'overflow': 'hidden',
        'width': '100%',
      }),
      [
        // Fade edges
        if (props.showFadeEdges) ...[
          ArcaneFadeEdge.left(
            color: props.fadeColor,
            width: props.fadeWidth,
          ),
          ArcaneFadeEdge.right(
            color: props.fadeColor,
            width: props.fadeWidth,
          ),
        ],
        // Scrolling track
        dom.div(
          classes: 'codex-marquee-track $marqueeId',
          styles: dom.Styles(raw: {
            'display': 'flex',
            'width': 'max-content',
            'animation': '$animationName ${props.duration} linear infinite',
            if (props.pauseOnHover) '--pause-on-hover': 'paused',
          }),
          [
            // First set of items
            dom.div(
              styles: dom.Styles(raw: {
                'display': 'flex',
                'gap': effectiveGap,
                'padding': '0 0.75rem',
              }),
              props.children,
            ),
            // Duplicate for seamless loop
            dom.div(
              styles: dom.Styles(raw: {
                'display': 'flex',
                'gap': effectiveGap,
                'padding': '0 0.75rem',
              }),
              props.children,
            ),
          ],
        ),
        // Inject animation keyframes
        Component.element(
          tag: 'style',
          children: [
            Component.text(isReverse
                ? '''
@keyframes $animationName {
  from { transform: translateX(-50%); }
  to { transform: translateX(0); }
}
${props.pauseOnHover ? '.$marqueeId:hover { animation-play-state: var(--pause-on-hover, running); }' : ''}
'''
                : '''
@keyframes $animationName {
  from { transform: translateX(0); }
  to { transform: translateX(-50%); }
}
${props.pauseOnHover ? '.$marqueeId:hover { animation-play-state: var(--pause-on-hover, running); }' : ''}
'''),
          ],
        ),
      ],
    );
  }
}
