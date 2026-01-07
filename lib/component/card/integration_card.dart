import 'package:jaspr/jaspr.dart';

import '../../core/theme_provider.dart';

export '../../core/props/integration_card_props.dart';

/// Integration/partner card displaying logo, name, and description.
class ArcaneIntegrationCard extends StatelessComponent {
  final String name;
  final String? description;
  final String? logoUrl;
  final Component? logo;
  final String? href;
  final void Function()? onTap;
  final String? category;
  final bool featured;

  const ArcaneIntegrationCard({
    required this.name,
    this.description,
    this.logoUrl,
    this.logo,
    this.href,
    this.onTap,
    this.category,
    this.featured = false,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return context.renderers.integrationCard(IntegrationCardProps(
      name: name,
      description: description,
      logoUrl: logoUrl,
      logo: logo,
      href: href,
      onTap: onTap,
      category: category,
      featured: featured,
    ));
  }
}

/// Grid layout for multiple integration cards.
class ArcaneIntegrationGrid extends StatelessComponent {
  final List<IntegrationCardProps> integrations;
  final int columns;
  final double gap;
  final String? title;
  final String? description;

  const ArcaneIntegrationGrid({
    required this.integrations,
    this.columns = 3,
    this.gap = 24,
    this.title,
    this.description,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return context.renderers.integrationGrid(IntegrationGridProps(
      integrations: integrations,
      columns: columns,
      gap: gap,
      title: title,
      description: description,
    ));
  }
}
