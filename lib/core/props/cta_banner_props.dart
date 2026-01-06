import 'package:jaspr/jaspr.dart';

/// Properties for CTA banner components.
class CtaBannerProps {
  /// Banner title
  final String title;

  /// Optional subtitle
  final String? subtitle;

  /// Primary action button
  final Component? primaryAction;

  /// Secondary action button
  final Component? secondaryAction;

  /// Gradient start color
  final String? gradientStart;

  /// Gradient end color
  final String? gradientEnd;

  /// Background image URL
  final String? backgroundImage;

  const CtaBannerProps({
    required this.title,
    this.subtitle,
    this.primaryAction,
    this.secondaryAction,
    this.gradientStart,
    this.gradientEnd,
    this.backgroundImage,
  });
}
