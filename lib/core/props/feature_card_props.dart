import 'package:jaspr/jaspr.dart';

/// Props for feature card component.
class FeatureCardProps {
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

/// Props for icon card component.
class IconCardProps {
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

  const IconCardProps({
    required this.title,
    required this.icon,
    this.subtitle,
    this.onTap,
    this.href,
  });
}
