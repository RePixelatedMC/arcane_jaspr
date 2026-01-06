import 'package:jaspr/jaspr.dart';

import '../../core/theme_provider.dart';

// Re-export props for usage
export '../../core/props/arrow_link_props.dart';

/// A simple inline text link with an arrow icon.
///
/// Perfect for card footers, "Learn more" links, and inline CTAs.
///
/// ```dart
/// ArcaneArrowLink(
///   label: 'Learn more',
///   href: '/about',
/// )
///
/// // Or as a button with onTap
/// ArcaneArrowLink(
///   label: 'View details',
///   onTap: () => showDetails(),
/// )
/// ```
class ArcaneArrowLink extends StatelessComponent {
  /// The link text
  final String label;

  /// Optional href for navigation
  final String? href;

  /// Optional click handler (alternative to href)
  final void Function()? onTap;

  /// Size of the link text
  final ArrowLinkSize size;

  /// Whether to show the arrow (default: true)
  final bool showArrow;

  /// Arrow position - before or after text
  final bool arrowBefore;

  /// Use accent color (true) or muted color (false)
  final bool accent;

  const ArcaneArrowLink({
    required this.label,
    this.href,
    this.onTap,
    this.size = ArrowLinkSize.sm,
    this.showArrow = true,
    this.arrowBefore = false,
    this.accent = true,
    super.key,
  });

  /// Accent-colored link (default)
  const ArcaneArrowLink.accent({
    required this.label,
    this.href,
    this.onTap,
    this.size = ArrowLinkSize.sm,
    this.showArrow = true,
    this.arrowBefore = false,
    super.key,
  }) : accent = true;

  /// Muted/subtle link
  const ArcaneArrowLink.muted({
    required this.label,
    this.href,
    this.onTap,
    this.size = ArrowLinkSize.sm,
    this.showArrow = true,
    this.arrowBefore = false,
    super.key,
  }) : accent = false;

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
    ));
  }
}
