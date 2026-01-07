enum DividerVariant {
  standard,
  subtle,
  bold,
}

enum DividerOrientation {
  horizontal,
  vertical,
}

/// Divider component properties.
class DividerProps {
  final double? margin;
  final DividerVariant variant;
  final String? label;
  final bool dashed;
  final DividerOrientation orientation;
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
