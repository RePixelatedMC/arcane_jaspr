/// Divider style variants.
enum DividerVariant {
  /// Standard divider (1px, border color)
  standard,

  /// Subtle divider (1px, muted color)
  subtle,

  /// Bold divider (2px, border color)
  bold,
}

/// Divider orientation.
enum DividerOrientation {
  /// Horizontal divider
  horizontal,

  /// Vertical divider
  vertical,
}

/// Properties for divider components.
class DividerProps {
  /// Margin in pixels (vertical for horizontal, horizontal for vertical)
  final double? margin;

  /// Style variant
  final DividerVariant variant;

  /// Optional label in the middle (horizontal only)
  final String? label;

  /// Whether to use a dashed style
  final bool dashed;

  /// Orientation
  final DividerOrientation orientation;

  /// Height for vertical divider (null for full height)
  final double? height;

  const DividerProps({
    this.margin,
    this.variant = DividerVariant.standard,
    this.label,
    this.dashed = false,
    this.orientation = DividerOrientation.horizontal,
    this.height,
  });
}
