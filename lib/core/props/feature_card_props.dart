import 'package:jaspr/jaspr.dart';

/// Feature card component properties.
class FeatureCardProps {
  final String title;
  final String description;
  final Component? icon;
  final String? href;
  final void Function()? onTap;
  final bool showArrow;
  final bool horizontal;

  const FeatureCardProps({
    required this.title,
    required this.description,
    this.icon,
    this.href,
    this.onTap,
    this.showArrow = false,
    this.horizontal = false,
  });
}

/// Icon card component properties.
class IconCardProps {
  final String title;
  final String? subtitle;
  final Component icon;
  final void Function()? onTap;
  final String? href;

  const IconCardProps({
    required this.title,
    required this.icon,
    this.subtitle,
    this.onTap,
    this.href,
  });
}

// ============================================================================
// RENDERER CONTRACT
// ============================================================================

/// Mixin defining the renderer methods for feature card components.
mixin FeatureCardRendererContract {
  Component featureCard(FeatureCardProps props);
  Component iconCard(IconCardProps props);
}
