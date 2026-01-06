import 'package:jaspr/jaspr.dart';

import '../../core/theme_provider.dart';

export '../../core/props/footer_column_props.dart';
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
    return context.renderers.footerColumn(FooterColumnProps(
      title: title,
      links: links,
      titleColor: titleColor,
      linkColor: linkColor,
      linkGap: linkGap,
    ));
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
    return context.renderers.footerBrandColumn(FooterBrandColumnProps(
      logo: logo,
      description: description,
      bottomContent: bottomContent,
      descriptionMaxWidth: descriptionMaxWidth,
    ));
  }
}
