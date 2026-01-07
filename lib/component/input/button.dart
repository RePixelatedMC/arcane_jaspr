import 'package:jaspr/jaspr.dart';

import '../../core/theme_provider.dart';

export '../../core/props/button_props.dart' show ButtonVariant, ButtonSize;

/// A styled button component.
class ArcaneButton extends StatelessComponent {
  final String? label;
  final Component? child;
  final Component? icon;
  final Component? trailing;
  final void Function()? onPressed;
  final ButtonVariant variant;
  final ButtonSize size;
  final bool disabled;
  final bool loading;
  final bool fullWidth;
  final Map<String, String>? attributes;
  final String? id;

  const ArcaneButton({
    this.label,
    this.child,
    this.icon,
    this.trailing,
    this.onPressed,
    this.variant = ButtonVariant.primary,
    this.size = ButtonSize.medium,
    this.disabled = false,
    this.loading = false,
    this.fullWidth = false,
    this.attributes,
    this.id,
    super.key,
  });

  const ArcaneButton.primary({
    this.label,
    this.child,
    this.icon,
    this.trailing,
    this.onPressed,
    this.size = ButtonSize.medium,
    this.disabled = false,
    this.loading = false,
    this.fullWidth = false,
    this.attributes,
    this.id,
    super.key,
  }) : variant = ButtonVariant.primary;

  const ArcaneButton.secondary({
    this.label,
    this.child,
    this.icon,
    this.trailing,
    this.onPressed,
    this.size = ButtonSize.medium,
    this.disabled = false,
    this.loading = false,
    this.fullWidth = false,
    this.attributes,
    this.id,
    super.key,
  }) : variant = ButtonVariant.secondary;

  const ArcaneButton.outline({
    this.label,
    this.child,
    this.icon,
    this.trailing,
    this.onPressed,
    this.size = ButtonSize.medium,
    this.disabled = false,
    this.loading = false,
    this.fullWidth = false,
    this.attributes,
    this.id,
    super.key,
  }) : variant = ButtonVariant.outline;

  const ArcaneButton.ghost({
    this.label,
    this.child,
    this.icon,
    this.trailing,
    this.onPressed,
    this.size = ButtonSize.medium,
    this.disabled = false,
    this.loading = false,
    this.fullWidth = false,
    this.attributes,
    this.id,
    super.key,
  }) : variant = ButtonVariant.ghost;

  const ArcaneButton.destructive({
    this.label,
    this.child,
    this.icon,
    this.trailing,
    this.onPressed,
    this.size = ButtonSize.medium,
    this.disabled = false,
    this.loading = false,
    this.fullWidth = false,
    this.attributes,
    this.id,
    super.key,
  }) : variant = ButtonVariant.destructive;

  const ArcaneButton.warning({
    this.label,
    this.child,
    this.icon,
    this.trailing,
    this.onPressed,
    this.size = ButtonSize.medium,
    this.disabled = false,
    this.loading = false,
    this.fullWidth = false,
    this.attributes,
    this.id,
    super.key,
  }) : variant = ButtonVariant.warning;

  const ArcaneButton.success({
    this.label,
    this.child,
    this.icon,
    this.trailing,
    this.onPressed,
    this.size = ButtonSize.medium,
    this.disabled = false,
    this.loading = false,
    this.fullWidth = false,
    this.attributes,
    this.id,
    super.key,
  }) : variant = ButtonVariant.success;

  const ArcaneButton.link({
    this.label,
    this.child,
    this.icon,
    this.trailing,
    this.onPressed,
    this.size = ButtonSize.medium,
    this.disabled = false,
    this.loading = false,
    this.fullWidth = false,
    this.attributes,
    this.id,
    super.key,
  }) : variant = ButtonVariant.link;

  const ArcaneButton.info({
    this.label,
    this.child,
    this.icon,
    this.trailing,
    this.onPressed,
    this.size = ButtonSize.medium,
    this.disabled = false,
    this.loading = false,
    this.fullWidth = false,
    this.attributes,
    this.id,
    super.key,
  }) : variant = ButtonVariant.info;

  @override
  Component build(BuildContext context) {
    return context.renderers.button(ButtonProps(
      label: label,
      child: child,
      icon: icon,
      trailing: trailing,
      onPressed: onPressed,
      variant: variant,
      size: size,
      disabled: disabled,
      loading: loading,
      fullWidth: fullWidth,
      id: id,
      attributes: attributes,
    ));
  }
}
