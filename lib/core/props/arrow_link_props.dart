/// Size options for arrow links.
enum ArrowLinkSize {
  /// Extra small - 12px
  xs,

  /// Small - 14px
  sm,

  /// Medium - 16px (default)
  md,

  /// Large - 18px
  lg,
}

/// Props for arrow link components.
class ArrowLinkProps {
  /// The link text
  final String label;

  /// Optional href for navigation
  final String? href;

  /// Size of the link text
  final ArrowLinkSize size;

  /// Whether to show the arrow (default: true)
  final bool showArrow;

  /// Arrow position - before or after text
  final bool arrowBefore;

  /// Use accent color (true) or muted color (false)
  final bool accent;

  /// Optional click handler (alternative to href)
  final void Function()? onTap;

  const ArrowLinkProps({
    required this.label,
    this.href,
    this.size = ArrowLinkSize.sm,
    this.showArrow = true,
    this.arrowBefore = false,
    this.accent = true,
    this.onTap,
  });
}
