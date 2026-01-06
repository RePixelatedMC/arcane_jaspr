import 'package:jaspr/jaspr.dart';

import '../../core/theme_provider.dart';

/// Inline alert component
///
/// Use for important messages that need user attention.
///
/// ```dart
/// ArcaneAlert(
///   severity: AlertSeverity.warning,
///   title: 'Warning',
///   message: 'Your session will expire in 5 minutes.',
/// )
/// ```
class ArcaneAlert extends StatelessComponent {
  /// Alert severity/type
  final AlertSeverity severity;

  /// Optional title
  final String? title;

  /// Alert message
  final String? message;

  /// Child component (alternative to message)
  final Component? child;

  /// Visual style variant
  final AlertVariant variant;

  /// Custom icon (overrides default)
  final Component? icon;

  /// Whether to show icon
  final bool showIcon;

  /// Whether the alert is dismissible
  final bool dismissible;

  /// Callback when dismissed
  final void Function()? onDismiss;

  /// Action button
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

  /// Info alert
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

  /// Success alert
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

  /// Warning alert
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

  /// Error alert
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
