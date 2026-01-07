import 'package:jaspr/jaspr.dart';

import '../../core/theme_provider.dart';

export '../../core/props/alert_banner_props.dart';

/// Alert/banner component with variant styles.
class ArcaneAlertBanner extends StatelessComponent {
  final String message;
  final String? title;
  final AlertBannerVariant variant;
  final Component? icon;
  final Component? action;
  final bool dismissible;
  final void Function()? onDismiss;
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
