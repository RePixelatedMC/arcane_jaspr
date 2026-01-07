import 'package:jaspr/jaspr.dart';

import '../../core/theme_provider.dart';

/// Inline alert component for important messages that need user attention.
class ArcaneAlert extends StatelessComponent {
  final AlertSeverity severity;
  final String? title;
  final String? message;
  final Component? child;
  final AlertVariant variant;
  final Component? icon;
  final bool showIcon;
  final bool dismissible;
  final void Function()? onDismiss;
  final Component? action;

  const ArcaneAlert({
    required this.severity,
    this.title,
    this.message,
    this.child,
    this.variant = AlertVariant.subtle,
    this.icon,
    this.showIcon = true,
    this.dismissible = false,
    this.onDismiss,
    this.action,
    super.key,
  });

  const ArcaneAlert.info({
    this.title,
    this.message,
    this.child,
    this.variant = AlertVariant.subtle,
    this.icon,
    this.showIcon = true,
    this.dismissible = false,
    this.onDismiss,
    this.action,
    super.key,
  }) : severity = AlertSeverity.info;

  const ArcaneAlert.success({
    this.title,
    this.message,
    this.child,
    this.variant = AlertVariant.subtle,
    this.icon,
    this.showIcon = true,
    this.dismissible = false,
    this.onDismiss,
    this.action,
    super.key,
  }) : severity = AlertSeverity.success;

  const ArcaneAlert.warning({
    this.title,
    this.message,
    this.child,
    this.variant = AlertVariant.subtle,
    this.icon,
    this.showIcon = true,
    this.dismissible = false,
    this.onDismiss,
    this.action,
    super.key,
  }) : severity = AlertSeverity.warning;

  const ArcaneAlert.error({
    this.title,
    this.message,
    this.child,
    this.variant = AlertVariant.subtle,
    this.icon,
    this.showIcon = true,
    this.dismissible = false,
    this.onDismiss,
    this.action,
    super.key,
  }) : severity = AlertSeverity.error;

  @override
  Component build(BuildContext context) {
    return context.renderers.alert(AlertProps(
      severity: severity,
      title: title,
      message: message,
      child: child,
      variant: variant,
      icon: icon,
      showIcon: showIcon,
      dismissible: dismissible,
      onDismiss: onDismiss,
      action: action,
    ));
  }
}
