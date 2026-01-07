import 'package:jaspr/jaspr.dart';

import '../../core/theme_provider.dart';

export '../../core/props/alert_banner_props.dart';

/// An alert/banner component (Supabase-style)
class ArcaneAlertBanner extends StatelessComponent {
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

  const ArcaneAlertBanner({
    required this.message,
    this.title,
    this.variant = AlertBannerVariant.info,
    this.icon,
    this.action,
    this.dismissible = false,
    this.onDismiss,
    this.filled = false,
    super.key,
  });

  /// Info alert
  const ArcaneAlertBanner.info({
    required this.message,
    this.title,
    this.icon,
    this.action,
    this.dismissible = false,
    this.onDismiss,
    this.filled = false,
    super.key,
  }) : variant = AlertBannerVariant.info;

  /// Success alert
  const ArcaneAlertBanner.success({
    required this.message,
    this.title,
    this.icon,
    this.action,
    this.dismissible = false,
    this.onDismiss,
    this.filled = false,
    super.key,
  }) : variant = AlertBannerVariant.success;

  /// Warning alert
  const ArcaneAlertBanner.warning({
    required this.message,
    this.title,
    this.icon,
    this.action,
    this.dismissible = false,
    this.onDismiss,
    this.filled = false,
    super.key,
  }) : variant = AlertBannerVariant.warning;

  /// Error alert
  const ArcaneAlertBanner.error({
    required this.message,
    this.title,
    this.icon,
    this.action,
    this.dismissible = false,
    this.onDismiss,
    this.filled = false,
    super.key,
  }) : variant = AlertBannerVariant.error;

  @override
  Component build(BuildContext context) {
    return context.renderers.alertBanner(AlertBannerProps(
      message: message,
      title: title,
      variant: variant,
      icon: icon,
      action: action,
      dismissible: dismissible,
      onDismiss: onDismiss,
      filled: filled,
    ));
  }
}
