import 'package:jaspr/jaspr.dart';

/// Scroll direction for the marquee
enum MarqueeDirection {
  /// Scroll from right to left (default)
  left,

  /// Scroll from left to right
  right,
}

/// Properties for marquee components.
class MarqueeProps {
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

  /// Unique ID for the animation
  final String? id;

  const MarqueeProps({
    required this.children,
    this.duration = '30s',
    this.direction = MarqueeDirection.left,
    this.gap,
    this.showFadeEdges = true,
    this.fadeWidth,
    this.fadeColor,
    this.pauseOnHover = true,
    this.id,
  });
}
