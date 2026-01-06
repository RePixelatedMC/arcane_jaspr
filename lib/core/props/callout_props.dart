import 'package:jaspr/jaspr.dart';

/// Callout style variants.
enum CalloutVariant {
  /// Informational callout (blue)
  info,

  /// Success/positive callout (green)
  success,

  /// Warning callout (amber)
  warning,

  /// Error/danger callout (red)
  error,

  /// Neutral/default callout (gray)
  neutral,

  /// Tip/hint callout (accent)
  tip,

  /// Note callout (primary)
  note,
}

/// Properties for callout components.
class CalloutProps {
  /// Optional title
  final String? title;

  /// Content text
  final String? content;

  /// Child component (alternative to content)
  final Component? child;

  /// Style variant
  final CalloutVariant variant;

  /// Optional icon override
  final Component? icon;

  /// Whether to show the default icon
  final bool showIcon;

  /// Whether the callout is dismissible
  final bool dismissible;

  /// Callback when dismissed
  final void Function()? onDismiss;

  const CalloutProps({
    this.title,
    this.content,
    this.child,
    this.variant = CalloutVariant.info,
    this.icon,
    this.showIcon = true,
    this.dismissible = false,
    this.onDismiss,
  });
}
