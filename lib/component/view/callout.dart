import 'package:jaspr/jaspr.dart';

import '../../core/theme_provider.dart';

export '../../core/props/callout_props.dart' show CalloutVariant;

/// Inline callout/notice component for highlighting important information.
class ArcaneCallout extends StatelessComponent {
  final String? title;
  final String? content;
  final Component? child;
  final CalloutVariant variant;
  final Component? icon;
  final bool showIcon;
  final bool dismissible;
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
