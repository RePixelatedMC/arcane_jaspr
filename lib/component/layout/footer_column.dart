import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' hide Color, Colors, ColorScheme, Gap, Padding, TextAlign, TextOverflow, Border, BorderRadius, BoxShadow, FontWeight;

import '../../core/props/footer_props.dart';

// Re-export FooterLink for convenience
export '../../core/props/footer_props.dart' show FooterLink;

/// A footer column with title and list of links.
///
/// Common pattern for site footers with organized link groups.
///
/// ```dart
/// ArcaneFooterColumn(
///   title: 'Resources',
///   links: [
///     FooterLink(label: 'Documentation', href: '/docs'),
///     FooterLink(label: 'API Reference', href: '/api'),
///     FooterLink(label: 'Support', href: '/support'),
///   ],
/// )
/// ```
class ArcaneFooterColumn extends StatelessComponent {
  /// Column title
  final String title;

  /// List of links
  final List<FooterLink> links;

  /// Title text color
  final String? titleColor;

  /// Link text color
  final String? linkColor;

  /// Gap between links
  final String? linkGap;

  const ArcaneFooterColumn({
    required this.title,
    required this.links,
    this.titleColor,
    this.linkColor,
    this.linkGap,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    final effectiveTitleColor = titleColor ?? 'var(--foreground)';
    final effectiveLinkColor = linkColor ?? 'var(--muted-foreground)';
    final effectiveLinkGap = linkGap ?? '0.5rem';

    return div(
      styles: const Styles(raw: {
        'display': 'flex',
        'flex-direction': 'column',
        'align-items': 'flex-start',
      }),
      [
        // Title
        h4(
          styles: Styles(raw: {
            'font-family': 'ui-sans-serif, system-ui, sans-serif',
            'font-size': '0.875rem',
            'font-weight': '600',
            'color': effectiveTitleColor,
            'text-transform': 'uppercase',
            'letter-spacing': '0.05em',
            'margin': '0 0 1rem 0',
          }),
          [text(title)],
        ),
        // Links
        ...links.map((link) => a(
              href: link.href ?? '#',
              styles: Styles(raw: {
                'display': 'block',
                'font-size': '0.875rem',
                'color': effectiveLinkColor,
                'text-decoration': 'none',
                'margin-bottom': effectiveLinkGap,
                'transition': 'color 150ms ease',
              }),
              [
                if (link.icon != null) ...[
                  span([text(link.icon!)]),
                  text(' '),
                ],
                text(link.label),
              ],
            )),
      ],
    );
  }
}

/// A brand column for footers with logo, description, and optional status.
///
/// ```dart
/// ArcaneFooterBrandColumn(
///   logo: MyLogo(),
///   description: 'Premium game server hosting with instant deployment.',
///   bottomContent: ArcaneStatusBadge.success('All Systems Operational'),
/// )
/// ```
class ArcaneFooterBrandColumn extends StatelessComponent {
  /// Logo component
  final Component logo;

  /// Brand description text
  final String? description;

  /// Optional content at the bottom (e.g., status badge)
  final Component? bottomContent;

  /// Maximum width for description
  final String? descriptionMaxWidth;

  const ArcaneFooterBrandColumn({
    required this.logo,
    this.description,
    this.bottomContent,
    this.descriptionMaxWidth,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return div(
      styles: const Styles(raw: {
        'display': 'flex',
        'flex-direction': 'column',
        'align-items': 'flex-start',
      }),
      [
        // Logo
        div(
          styles: const Styles(raw: {
            'margin-bottom': '1rem',
          }),
          [logo],
        ),
        // Description
        if (description != null)
          p(
            styles: Styles(raw: {
              'font-size': '0.875rem',
              'color': 'var(--muted-foreground)',
              'line-height': '1.6',
              'margin': '0 0 1rem 0',
              'max-width': descriptionMaxWidth ?? '280px',
            }),
            [text(description!)],
          ),
        // Bottom content
        if (bottomContent != null) bottomContent!,
      ],
    );
  }
}
