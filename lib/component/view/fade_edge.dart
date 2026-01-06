import 'package:jaspr/jaspr.dart';

import '../../core/props/fade_edge_props.dart';
import '../../core/theme_provider.dart';

// Re-export props for usage
export '../../core/props/fade_edge_props.dart';

/// An overlay that creates a fade-to-transparent effect at an edge.
///
/// Commonly used for carousels, scrolling content, or overflow containers
/// to create a smooth visual transition at the edges.
///
/// ```dart
/// Stack([
///   // Scrolling content
///   HorizontalScrollView(...),
///   // Fade edges
///   ArcaneFadeEdge.left(color: '#09090b'),
///   ArcaneFadeEdge.right(color: '#09090b'),
/// ])
/// ```
class ArcaneFadeEdge extends StatelessComponent {
  /// The direction of the fade
  final FadeDirection direction;

  /// The color to fade from (typically the background color)
  /// Defaults to arcane background color
  final String? color;

  /// The width of the fade area (for left/right)
  final String? width;

  /// The height of the fade area (for top/bottom)
  final String? height;

  /// Z-index for stacking
  final String? zIndex;

  const ArcaneFadeEdge({
    required this.direction,
    this.color,
    this.width,
    this.height,
    this.zIndex,
    super.key,
  });

  /// Create a left fade edge
  const ArcaneFadeEdge.left({
    this.color,
    this.width,
    this.height,
    this.zIndex,
    super.key,
  }) : direction = FadeDirection.left;

  /// Create a right fade edge
  const ArcaneFadeEdge.right({
    this.color,
    this.width,
    this.height,
    this.zIndex,
    super.key,
  }) : direction = FadeDirection.right;

  /// Create a top fade edge
  const ArcaneFadeEdge.top({
    this.color,
    this.width,
    this.height,
    this.zIndex,
    super.key,
  }) : direction = FadeDirection.top;

  /// Create a bottom fade edge
  const ArcaneFadeEdge.bottom({
    this.color,
    this.width,
    this.height,
    this.zIndex,
    super.key,
  }) : direction = FadeDirection.bottom;

  @override
  Component build(BuildContext context) {
    return context.renderers.fadeEdge(FadeEdgeProps(
      direction: direction,
      color: color,
      width: width,
      height: height,
      zIndex: zIndex,
    ));
  }
}
