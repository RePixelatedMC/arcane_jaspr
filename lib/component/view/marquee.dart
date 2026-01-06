import 'package:jaspr/jaspr.dart';

import '../../core/theme_provider.dart';

// Re-export props for usage
export '../../core/props/marquee_props.dart';

/// An infinite scrolling marquee/carousel component.
///
/// Automatically duplicates content for seamless infinite scrolling.
/// Includes optional fade edges for smooth visual transitions.
///
/// ```dart
/// ArcaneMarquee(
///   children: [
///     for (final item in items) ItemCard(item),
///   ],
///   showFadeEdges: true,
///   duration: '30s',
/// )
/// ```
class ArcaneMarquee extends StatelessComponent {
  /// The content to scroll (will be duplicated for seamless looping)
  final List<Component> children;

  /// Animation duration (CSS time value, e.g., '20s', '30s')
  final String duration;

  /// Scroll direction
  final MarqueeDirection direction;

  /// Gap between items
  final String? gap;

  /// Whether to show fade edges
  final bool showFadeEdges;

  /// Fade edge width
  final String? fadeWidth;

  /// Background color for fade edges
  final String? fadeColor;

  /// Whether to pause animation on hover
  final bool pauseOnHover;

  /// Unique ID for the animation (required if multiple marquees on same page)
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

/// A reverse marquee that scrolls in the opposite direction
class ArcaneMarqueeReverse extends StatelessComponent {
  /// The content to scroll (will be duplicated for seamless looping)
  final List<Component> children;

  /// Animation duration (CSS time value)
  final String duration;

  /// Gap between items
  final String? gap;

  /// Whether to show fade edges
  final bool showFadeEdges;

  /// Fade edge width
  final String? fadeWidth;

  /// Background color for fade edges
  final String? fadeColor;

  /// Whether to pause animation on hover
  final bool pauseOnHover;

  /// Unique ID for the animation
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
