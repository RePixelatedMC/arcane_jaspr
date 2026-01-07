import 'package:jaspr/jaspr.dart';

enum AlertSeverity {
  info,
  success,
  warning,
  error,
}

enum AlertVariant {
  subtle,
  solid,
  outline,
  accent,
}

/// Alert component properties.
class AlertProps {
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

  const AlertProps({
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
  });

  AlertProps copyWith({
    AlertSeverity? severity,
    String? title,
    String? message,
    Component? child,
    AlertVariant? variant,
    Component? icon,
    bool? showIcon,
    bool? dismissible,
    void Function()? onDismiss,
    Component? action,
  }) {
    return AlertProps(
      severity: severity ?? this.severity,
      title: title ?? this.title,
      message: message ?? this.message,
      child: child ?? this.child,
      variant: variant ?? this.variant,
      icon: icon ?? this.icon,
      showIcon: showIcon ?? this.showIcon,
      dismissible: dismissible ?? this.dismissible,
      onDismiss: onDismiss ?? this.onDismiss,
      action: action ?? this.action,
    );
  }
}
