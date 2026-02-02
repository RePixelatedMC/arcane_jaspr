import 'package:jaspr/jaspr.dart';

import '../../core/theme_provider.dart';

export '../../core/props/arrow_link_props.dart';

/// A simple inline text link with an arrow icon.
///
/// Supports two variants:
/// - Inline (default): Simple text link with arrow
/// - Pill: Button-like link with background, border, and hover effects
class ArcaneArrowLink extends StatelessComponent {
  final String label;
  final String? href;
  final void Function()? onTap;
  final ArrowLinkSize size;
  final bool showArrow;
  final bool arrowBefore;
  final bool accent;
  final ArrowLinkVariant variant;
  final bool animateArrow;

  const ArcaneArrowLink({
    required this.label,
    this.href,
    this.onTap,
    this.size = ArrowLinkSize.sm,
    this.showArrow = true,
    this.arrowBefore = false,
    this.accent = true,
    this.variant = ArrowLinkVariant.inline,
    this.animateArrow = false,
    super.key,
  });

  const ArcaneArrowLink.accent({
    required this.label,
    this.href,
    this.onTap,
    this.size = ArrowLinkSize.sm,
    this.showArrow = true,
    this.arrowBefore = false,
    this.variant = ArrowLinkVariant.inline,
    this.animateArrow = false,
    super.key,
  }) : accent = true;

  const ArcaneArrowLink.muted({
    required this.label,
    this.href,
    this.onTap,
    this.size = ArrowLinkSize.sm,
    this.showArrow = true,
    this.arrowBefore = false,
    this.variant = ArrowLinkVariant.inline,
    this.animateArrow = false,
    super.key,
  }) : accent = false;

  /// Creates a pill-style arrow link (button-like with background).
  /// This is the "View All" button style with animated arrow on hover.
  const ArcaneArrowLink.pill({
    required this.label,
    this.href,
    this.onTap,
    this.size = ArrowLinkSize.sm,
    this.showArrow = true,
    this.arrowBefore = false,
    this.accent = true,
    this.animateArrow = true,
    super.key,
  }) : variant = ArrowLinkVariant.pill;

  @override
  Component build(BuildContext context) {
    return context.renderers.arrowLink(ArrowLinkProps(
      label: label,
      href: href,
      size: size,
      showArrow: showArrow,
      arrowBefore: arrowBefore,
      accent: accent,
      onTap: onTap,
      variant: variant,
      animateArrow: animateArrow,
    ));
  }
}
