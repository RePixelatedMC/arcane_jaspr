import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart'
    hide
        Color,
        Colors,
        ColorScheme,
        Gap,
        Padding,
        TextAlign,
        TextOverflow,
        Border,
        BorderRadius,
        BoxShadow,
        FontWeight;

import 'icon.dart';

/// Size options for arrow links
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
    final String fontSize = switch (size) {
      ArrowLinkSize.xs => '0.75rem',
      ArrowLinkSize.sm => '0.875rem',
      ArrowLinkSize.md => '1rem',
      ArrowLinkSize.lg => '1.125rem',
    };

    final IconSize iconSize = switch (size) {
      ArrowLinkSize.xs => IconSize.xs,
      ArrowLinkSize.sm => IconSize.sm,
      ArrowLinkSize.md => IconSize.sm,
      ArrowLinkSize.lg => IconSize.md,
    };

    final String color = accent ? 'var(--accent)' : 'var(--muted-foreground)';

    final List<Component> content = [
      if (showArrow && arrowBefore) ArcaneIcon.arrowLeft(size: iconSize),
      Component.text(label),
      if (showArrow && !arrowBefore) ArcaneIcon.arrowRight(size: iconSize),
    ];

    final Map<String, String> styles = {
      'display': 'inline-flex',
      'align-items': 'center',
      'gap': '0.5rem',
      'font-size': fontSize,
      'color': color,
      'text-decoration': 'none',
      'cursor': 'pointer',
      'transition': 'all 150ms ease',
    };

    if (href != null) {
      return a(
        classes: 'arcane-arrow-link',
        href: href!,
        styles: Styles(raw: styles),
        content,
      );
    }

    if (onTap != null) {
      return button(
        classes: 'arcane-arrow-link',
        attributes: {'type': 'button'},
        styles: Styles(raw: {
          ...styles,
          'background': 'none',
          'border': 'none',
          'padding': '0',
        }),
        events: {'click': (_) => onTap!()},
        content,
      );
    }

    // Fallback to span if no interaction
    return span(
      classes: 'arcane-arrow-link',
      styles: Styles(raw: styles),
      content,
    );
  }

  @css
  static final List<StyleRule> styles = [
    css('.arcane-arrow-link:hover').styles(raw: {
      'opacity': '0.8',
    }),
  ];
}
