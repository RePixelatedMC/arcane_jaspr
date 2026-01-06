/// Direction of the fade effect.
enum FadeDirection {
  /// Fades from left edge to transparent
  left,

  /// Fades from right edge to transparent
  right,

  /// Fades from top edge to transparent
  top,

  /// Fades from bottom edge to transparent
  bottom,
}

/// Props for fade edge components.
class FadeEdgeProps {
  /// The direction of the fade
  final FadeDirection direction;

  /// The color to fade from (typically the background color)
  final String? color;

  /// The width of the fade area (for left/right)
  final String? width;

  /// The height of the fade area (for top/bottom)
  final String? height;

  /// Z-index for stacking
  final String? zIndex;

  const FadeEdgeProps({
    required this.direction,
    this.color,
    this.width,
    this.height,
    this.zIndex,
  });
}
