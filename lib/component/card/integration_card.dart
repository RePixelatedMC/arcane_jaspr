import 'package:jaspr/jaspr.dart';

import '../../core/theme_provider.dart';

// Re-export props for usage
export '../../core/props/integration_card_props.dart';

/// An integration/partner card (Supabase-style)
class ArcaneIntegrationCard extends StatelessComponent {
  /// Integration name
  final String name;

  /// Description
  final String? description;

  /// Logo image URL
  final String? logoUrl;

  /// Custom logo component
  final Component? logo;

  /// Link URL
  final String? href;

  /// Click handler
  final void Function()? onTap;

  /// Category/tag
  final String? category;

  /// Whether it's featured
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

/// A grid of integration cards
class ArcaneIntegrationGrid extends StatelessComponent {
  /// Integration card props list
  final List<IntegrationCardProps> integrations;

  /// Number of columns
  final int columns;

  /// Gap between cards
  final double gap;

  /// Optional title
  final String? title;

  /// Optional description
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
