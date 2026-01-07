import 'package:jaspr/jaspr.dart';

import '../../core/theme_provider.dart';

export '../../core/props/feature_card_props.dart';

/// Feature card for showcasing product features with icon, title, and description.
class ArcaneFeatureCard extends StatelessComponent {
  final String title;
  final String description;
  final Component? icon;
  final String? href;
  final void Function()? onTap;
  final bool showArrow;
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

/// Simple icon card for feature grids.
class ArcaneIconCard extends StatelessComponent {
  final String title;
  final String? subtitle;
  final Component icon;
  final void Function()? onTap;
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
