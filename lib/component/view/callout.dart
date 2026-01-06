import 'package:jaspr/jaspr.dart';

import '../../core/props/callout_props.dart';
import '../../core/theme_provider.dart';

// Re-export enums for usage
export '../../core/props/callout_props.dart' show CalloutVariant;

/// Inline callout/notice component
///
/// Use for highlighting important information inline with content.
///
/// ```dart
/// ArcaneCallout(
///   title: 'Pro Tip',
///   content: 'You can use keyboard shortcuts to speed up your workflow.',
///   variant: CalloutVariant.tip,
/// )
/// ```
class ArcaneCallout extends StatelessComponent {
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
  final VoidCallback? onDismiss;

  const ArcaneCallout({
    this.title,
    this.content,
    this.child,
    this.variant = CalloutVariant.info,
    this.icon,
    this.showIcon = true,
    this.dismissible = false,
    this.onDismiss,
    super.key,
  });

  /// Info callout constructor
  const ArcaneCallout.info({
    this.title,
    this.content,
    this.child,
    this.icon,
    this.showIcon = true,
    this.dismissible = false,
    this.onDismiss,
    super.key,
  }) : variant = CalloutVariant.info;

  /// Success callout constructor
  const ArcaneCallout.success({
    this.title,
    this.content,
    this.child,
    this.icon,
    this.showIcon = true,
    this.dismissible = false,
    this.onDismiss,
    super.key,
  }) : variant = CalloutVariant.success;

  /// Warning callout constructor
  const ArcaneCallout.warning({
    this.title,
    this.content,
    this.child,
    this.icon,
    this.showIcon = true,
    this.dismissible = false,
    this.onDismiss,
    super.key,
  }) : variant = CalloutVariant.warning;

  /// Error callout constructor
  const ArcaneCallout.error({
    this.title,
    this.content,
    this.child,
    this.icon,
    this.showIcon = true,
    this.dismissible = false,
    this.onDismiss,
    super.key,
  }) : variant = CalloutVariant.error;

  /// Tip callout constructor
  const ArcaneCallout.tip({
    this.title,
    this.content,
    this.child,
    this.icon,
    this.showIcon = true,
    this.dismissible = false,
    this.onDismiss,
    super.key,
  }) : variant = CalloutVariant.tip;

  /// Note callout constructor
  const ArcaneCallout.note({
    this.title,
    this.content,
    this.child,
    this.icon,
    this.showIcon = true,
    this.dismissible = false,
    this.onDismiss,
    super.key,
  }) : variant = CalloutVariant.note;

  /// Neutral callout constructor
  const ArcaneCallout.neutral({
    this.title,
    this.content,
    this.child,
    this.icon,
    this.showIcon = true,
    this.dismissible = false,
    this.onDismiss,
    super.key,
  }) : variant = CalloutVariant.neutral;

  @override
  Component build(BuildContext context) {
    return context.renderers.callout(CalloutProps(
      title: title,
      content: content,
      child: child,
      variant: variant,
      icon: icon,
      showIcon: showIcon,
      dismissible: dismissible,
      onDismiss: onDismiss,
    ));
  }
}
