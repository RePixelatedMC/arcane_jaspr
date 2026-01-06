import 'package:jaspr/jaspr.dart';

/// Alert severity/type variants.
enum AlertSeverity {
  /// Informational
  info,

  /// Success/positive
  success,

  /// Warning
  warning,

  /// Error/danger
  error,
}

/// Alert visual style variants.
enum AlertVariant {
  /// Subtle/soft background
  subtle,

  /// Solid/filled background
  solid,

  /// Outline/bordered style
  outline,

  /// Left accent border
  accent,
}

/// Properties for alert components.
class AlertProps {
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

  /// Create a copy with modified properties
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
