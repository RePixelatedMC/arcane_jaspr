import 'package:jaspr/jaspr.dart';

enum SkeletonShape {
  rectangle,
  circle,
  text,
}

/// Skeleton component properties.
class SkeletonProps {
  final String? width;
  final String? height;
  final String? borderRadius;
  final SkeletonShape shape;
  final bool animate;

  const SkeletonProps({
    this.width,
    this.height,
    this.borderRadius,
    this.shape = SkeletonShape.rectangle,
    this.animate = true,
  });

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

// ============================================================================
// RENDERER CONTRACT
// ============================================================================

/// Mixin defining the renderer methods for skeleton components.
mixin SkeletonRendererContract {
  /// Renders a skeleton loading placeholder component.
  Component skeleton(SkeletonProps props);
}
