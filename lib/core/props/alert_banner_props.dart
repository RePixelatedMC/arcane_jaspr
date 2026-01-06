import 'package:jaspr/jaspr.dart';

/// Alert/banner variants
enum AlertBannerVariant {
  info,
  success,
  warning,
  error,
  neutral,
}

/// Properties for alert banner components.
class AlertBannerProps {
  /// Alert message
  final String message;

  /// Optional title
  final String? title;

  /// Alert variant
  final AlertBannerVariant variant;

  /// Optional icon
  final Component? icon;

  /// Optional action button
  final Component? action;

  /// Whether the alert is dismissible
  final bool dismissible;

  /// Callback when dismissed
  final void Function()? onDismiss;

  /// Whether to use filled style
  final bool filled;

  const AlertBannerProps({
    required this.message,
    this.title,
    this.variant = AlertBannerVariant.info,
    this.icon,
    this.action,
    this.dismissible = false,
    this.onDismiss,
    this.filled = false,
  });
}
