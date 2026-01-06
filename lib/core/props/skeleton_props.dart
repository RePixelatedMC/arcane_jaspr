/// Skeleton shape variants.
enum SkeletonShape {
  /// Rectangular skeleton
  rectangle,

  /// Circular skeleton
  circle,

  /// Text line skeleton
  text,
}

/// Properties for skeleton components.
class SkeletonProps {
  /// Width of the skeleton
  final String? width;

  /// Height of the skeleton
  final String? height;

  /// Border radius
  final String? borderRadius;

  /// Shape variant
  final SkeletonShape shape;

  /// Whether to animate the skeleton
  final bool animate;

  const SkeletonProps({
    this.width,
    this.height,
    this.borderRadius,
    this.shape = SkeletonShape.rectangle,
    this.animate = true,
  });

  /// Create a copy with modified properties
  SkeletonProps copyWith({
    String? width,
    String? height,
    String? borderRadius,
    SkeletonShape? shape,
    bool? animate,
  }) {
    return SkeletonProps(
      width: width ?? this.width,
      height: height ?? this.height,
      borderRadius: borderRadius ?? this.borderRadius,
      shape: shape ?? this.shape,
      animate: animate ?? this.animate,
    );
  }
}
