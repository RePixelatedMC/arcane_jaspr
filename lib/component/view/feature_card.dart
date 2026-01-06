import 'package:jaspr/jaspr.dart';

import '../../core/props/feature_card_props.dart';
import '../../core/theme_provider.dart';

// Re-export props for usage
export '../../core/props/feature_card_props.dart';

/// A feature card component (Supabase-style)
/// Used for showcasing product features with icon, title, and description
class ArcaneFeatureCard extends StatelessComponent {
  /// The feature title
  final String title;

  /// The feature description
  final String description;

  /// Optional icon component
  final Component? icon;

  /// Optional link URL
  final String? href;

  /// Click handler (alternative to href)
  final void Function()? onTap;

  /// Whether to show an arrow indicator
  final bool showArrow;

  /// Card orientation (vertical or horizontal)
  final bool horizontal;

  const ArcaneFeatureCard({
    required this.title,
    required this.description,
    this.icon,
    this.href,
    this.onTap,
    this.showArrow = false,
    this.horizontal = false,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return context.renderers.featureCard(FeatureCardProps(
      title: title,
      description: description,
      icon: icon,
      href: href,
      onTap: onTap,
      showArrow: showArrow,
      horizontal: horizontal,
    ));
  }
}

/// A simple icon card for feature grids
class ArcaneIconCard extends StatelessComponent {
  /// The card title
  final String title;

  /// Optional subtitle
  final String? subtitle;

  /// Icon component
  final Component icon;

  /// Click handler
  final void Function()? onTap;

  /// Optional link
  final String? href;

  const ArcaneIconCard({
    required this.title,
    required this.icon,
    this.subtitle,
    this.onTap,
    this.href,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return context.renderers.iconCard(IconCardProps(
      title: title,
      icon: icon,
      subtitle: subtitle,
      onTap: onTap,
      href: href,
    ));
  }
}
