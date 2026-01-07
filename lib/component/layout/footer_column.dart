import 'package:jaspr/jaspr.dart';

import '../../core/theme_provider.dart';

export '../../core/props/footer_column_props.dart';
export '../../core/props/footer_props.dart' show FooterLink;

/// A footer column with title and list of links.
class ArcaneFooterColumn extends StatelessComponent {
  final String title;
  final List<FooterLink> links;
  final String? titleColor;
  final String? linkColor;
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
class ArcaneFooterBrandColumn extends StatelessComponent {
  final Component logo;
  final String? description;
  final Component? bottomContent;
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
