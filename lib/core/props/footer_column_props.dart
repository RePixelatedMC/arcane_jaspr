import 'package:jaspr/jaspr.dart';

import 'footer_props.dart';

/// Properties for footer column components.
class FooterColumnProps {
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

  const FooterColumnProps({
    required this.title,
    required this.links,
    this.titleColor,
    this.linkColor,
    this.linkGap,
  });
}

/// Properties for footer brand column components.
class FooterBrandColumnProps {
  /// Logo component
  final Component logo;

  /// Brand description text
  final String? description;

  /// Optional content at the bottom (e.g., status badge)
  final Component? bottomContent;

  /// Maximum width for description
  final String? descriptionMaxWidth;

  const FooterBrandColumnProps({
    required this.logo,
    this.description,
    this.bottomContent,
    this.descriptionMaxWidth,
  });
}
