import 'package:jaspr/jaspr.dart';

import '../../core/theme_provider.dart';

export '../../core/props/marquee_props.dart';

/// An infinite scrolling marquee/carousel component.
class ArcaneMarquee extends StatelessComponent {
  final List<Component> children;
  final String duration;
  final MarqueeDirection direction;
  final String? gap;
  final bool showFadeEdges;
  final String? fadeWidth;
  final String? fadeColor;
  final bool pauseOnHover;
  final String? id;

  const ArcaneMarquee({
    required this.children,
    this.duration = '30s',
    this.direction = MarqueeDirection.left,
    this.gap,
    this.showFadeEdges = true,
    this.fadeWidth,
    this.fadeColor,
    this.pauseOnHover = true,
    this.id,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return context.renderers.marquee(MarqueeProps(
      children: children,
      duration: duration,
      direction: direction,
      gap: gap,
      showFadeEdges: showFadeEdges,
      fadeWidth: fadeWidth,
      fadeColor: fadeColor,
      pauseOnHover: pauseOnHover,
      id: id,
    ));
  }
}

/// A reverse marquee that scrolls in the opposite direction.
class ArcaneMarqueeReverse extends StatelessComponent {
  final List<Component> children;
  final String duration;
  final String? gap;
  final bool showFadeEdges;
  final String? fadeWidth;
  final String? fadeColor;
  final bool pauseOnHover;
  final String? id;

  const ArcaneMarqueeReverse({
    required this.children,
    this.duration = '30s',
    this.gap,
    this.showFadeEdges = true,
    this.fadeWidth,
    this.fadeColor,
    this.pauseOnHover = true,
    this.id,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return context.renderers.marquee(MarqueeProps(
      children: children,
      duration: duration,
      direction: MarqueeDirection.right,
      gap: gap,
      showFadeEdges: showFadeEdges,
      fadeWidth: fadeWidth,
      fadeColor: fadeColor,
      pauseOnHover: pauseOnHover,
      id: id,
    ));
  }
}
