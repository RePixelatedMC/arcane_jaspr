import 'package:jaspr/jaspr.dart';

enum ArrowLinkSize {
  xs,
  sm,
  md,
  lg,
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

// ============================================================================
// RENDERER CONTRACT
// ============================================================================

/// Mixin defining the renderer methods for arrow link components.
mixin ArrowLinkRendererContract {
  Component arrowLink(ArrowLinkProps props);
}
