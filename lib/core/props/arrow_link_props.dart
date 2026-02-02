import 'package:jaspr/jaspr.dart';

enum ArrowLinkSize {
  xs,
  sm,
  md,
  lg,
}

/// Visual variant for arrow links.
enum ArrowLinkVariant {
  /// Inline text link (default)
  inline,

  /// Pill-shaped button with background and border
  pill,
}

/// Arrow link component properties.
class ArrowLinkProps {
  final String label;
  final String? href;
  final ArrowLinkSize size;
  final bool showArrow;
  final bool arrowBefore;
  final bool accent;
  final void Function()? onTap;

  /// Visual variant: inline (text link) or pill (button-like).
  final ArrowLinkVariant variant;

  /// Whether arrow should animate on hover (for pill variant).
  final bool animateArrow;

  const ArrowLinkProps({
    required this.label,
    this.href,
    this.size = ArrowLinkSize.sm,
    this.showArrow = true,
    this.arrowBefore = false,
    this.accent = true,
    this.onTap,
    this.variant = ArrowLinkVariant.inline,
    this.animateArrow = false,
  });

  /// Creates a pill-style arrow link (button-like with background).
  const ArrowLinkProps.pill({
    required this.label,
    this.href,
    this.size = ArrowLinkSize.sm,
    this.showArrow = true,
    this.arrowBefore = false,
    this.accent = true,
    this.onTap,
    this.animateArrow = true,
  }) : variant = ArrowLinkVariant.pill;
}

// ============================================================================
// RENDERER CONTRACT
// ============================================================================

/// Mixin defining the renderer methods for arrow link components.
mixin ArrowLinkRendererContract {
  Component arrowLink(ArrowLinkProps props);
}
