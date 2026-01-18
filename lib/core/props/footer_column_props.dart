import 'package:jaspr/jaspr.dart';

import 'footer_props.dart';

/// Footer column component properties.
class FooterColumnProps {
  final String title;
  final List<FooterLink> links;
  final String? titleColor;
  final String? linkColor;
  final String? linkGap;

  const FooterColumnProps({
    required this.title,
    required this.links,
    this.titleColor,
    this.linkColor,
    this.linkGap,
  });
}

/// Footer brand column component properties.
class FooterBrandColumnProps {
  final Component logo;
  final String? description;
  final Component? bottomContent;
  final String? descriptionMaxWidth;

  const FooterBrandColumnProps({
    required this.logo,
    this.description,
    this.bottomContent,
    this.descriptionMaxWidth,
  });
}

// ============================================================================
// RENDERER CONTRACT
// ============================================================================

/// Mixin defining the renderer methods for footer column components.
mixin FooterColumnRendererContract {
  Component footerColumn(FooterColumnProps props);
  Component footerBrandColumn(FooterBrandColumnProps props);
}
