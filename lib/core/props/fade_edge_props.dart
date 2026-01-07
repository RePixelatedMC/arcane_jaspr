enum FadeDirection {
  left,
  right,
  top,
  bottom,
}

/// Fade edge component properties.
class FadeEdgeProps {
  final FadeDirection direction;
  final String? color;
  final String? width;
  final String? height;
  final String? zIndex;

  const FadeEdgeProps({
    required this.direction,
    this.color,
    this.width,
    this.height,
    this.zIndex,
  });
}
