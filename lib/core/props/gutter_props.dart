/// Gutter size options
enum GutterSize {
  xsmall(4),
  small(8),
  medium(16),
  large(24),
  xlarge(32);

  final double pixels;
  const GutterSize(this.pixels);
}

/// Properties for gutter/spacing components.
class GutterProps {
  /// The size of the gutter
  final GutterSize size;

  /// Whether to render as a horizontal gutter
  final bool horizontal;

  const GutterProps({
    this.size = GutterSize.medium,
    this.horizontal = false,
  });
}

/// Properties for flexible gap components.
class GapProps {
  /// Size in pixels
  final double size;

  /// Whether horizontal
  final bool horizontal;

  const GapProps(this.size, {this.horizontal = false});
}
