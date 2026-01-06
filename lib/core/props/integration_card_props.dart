import 'package:jaspr/jaspr.dart';

/// Props for integration card component.
class IntegrationCardProps {
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

  const IntegrationCardProps({
    required this.name,
    this.description,
    this.logoUrl,
    this.logo,
    this.href,
    this.onTap,
    this.category,
    this.featured = false,
  });
}

/// Props for integration grid component.
class IntegrationGridProps {
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

  const IntegrationGridProps({
    required this.integrations,
    this.columns = 3,
    this.gap = 24,
    this.title,
    this.description,
  });
}
